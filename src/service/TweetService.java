package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import models.BeanTweet;
import models.BeanUser;
import persistence.TweetDAO;


public class TweetService {
	
	public ArrayList<BeanTweet> getTweetsList(String userName, String personalized) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		UserService userService = new UserService();
		BeanUser user = userService.getUser(userName);
		ArrayList<Integer> subscriptorsID = userService.getSubscriptionsList(user.getUserId());
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();		
		if("admin".equals(user.getUserType())){
			tweetsList =  tweetDAO.getFullTweetsList(userName);
		} else if ("true".equals(personalized)){
			tweetsList =  tweetDAO.getPersonalizedTweetsList(user.getUserId(), subscriptorsID);
		}
		else {
			tweetsList =  tweetDAO.getFilteredTweetsList(user.getUserId(), subscriptorsID);
		}
		enrichTweetList(tweetsList, user.getUserId());
		tweetsList.sort(Comparator.comparing(BeanTweet::getPublicationDate).thenComparing(BeanTweet::getLikes));
		Collections.reverse(tweetsList);
		return tweetsList;	
	}
	public void insertTweet(BeanTweet tweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.insertTweet(tweet);
	}
	public void deleteTweet(int idTweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.deleteTweet(idTweet);
	}
	public String getTweetUser(int idTweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 	
		return tweetDAO.getTweetUser(idTweet);
	}

	public void editTweet(BeanTweet tweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.editTweet(tweet);
	}
	
	public BeanTweet retweet(int userID, int tweetID, java.sql.Date date ) throws Exception{
		BeanTweet tweet = new BeanTweet(); 
		UserService userService = new UserService(); 
		TweetDAO tweetDAO = new TweetDAO(); 
		tweet = tweetDAO.getTweet(tweetID); 
		tweet.setUser_id1(userID);
		tweet.setUser(userService.getUserName(userID));
		tweet.setPublicationDate(date);
		insertTweet(tweet); 
		return tweet; 
	}
	//Like feature: 
	public void deleteLike(int userID, int tweetID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.deleteLike(userID, tweetID);
	}
	public void addLike(int userID, int tweetID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.addLike(userID, tweetID);
	}
	public void updateLike(BeanTweet tweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.updateLike(tweet);
	}
	public ArrayList<Integer> getLikes (int tweetID) throws Exception{
		ArrayList<Integer> likesList = new ArrayList<Integer>();
		TweetDAO tweetDAO = new TweetDAO(); 
		likesList = tweetDAO.getLikes(tweetID); 
		return likesList; 	
	}
	public BeanTweet getTweet(int idTweet, int userID) throws Exception {
		BeanTweet tweet = new BeanTweet(); 
		UserService userService = new UserService(); 
		TweetDAO tweetDAO = new TweetDAO(); 
		tweet = tweetDAO.getTweet(idTweet); 
		enrichTweet(tweet, userID); 
		return tweet; 
	}
	public int countTweetLikes(int idTweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		return tweetDAO.countTweetLikes(idTweet);
	}
	public boolean userHasLiked(int idTweet, int userID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		return tweetDAO.userHasLiked(idTweet, userID);
	}
	public void disconectBD() throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.disconnectBD();
	}
	private BeanTweet enrichTweet (BeanTweet tweet, int userID) throws Exception{
		tweet.setLikes(countTweetLikes(tweet.getIdTweet()));
		if(userHasLiked(tweet.getIdTweet(), userID)){
			 tweet.setIsLiked(true);
		} else {
			tweet.setIsLiked(false);
		}
		return tweet; 
	}
	private ArrayList<BeanTweet> enrichTweetList(ArrayList<BeanTweet> tweetsList, int userID) throws Exception{
		for(BeanTweet tweet : tweetsList){
			enrichTweet(tweet, userID);
		}
		return tweetsList;
	}
	
}
