package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import models.BeanTweet;
import persistence.TweetDAO;


public class TweetService {
	
	public ArrayList<BeanTweet> getTweetsList(String userName, String personalized) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		UserService userService = new UserService();
		int userID = userService.getUserID(userName);
		ArrayList<Integer> subscriptorsID = userService.getSubscriptors(userID);
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		
		if(userService.isAdminUser(userName)){
			tweetsList =  tweetDAO.getFullTweetsList(userName);
		} else if ("true".equals(personalized)){
			tweetsList =  tweetDAO.getPersonalizedTweetsList(userID, subscriptorsID);
		}
		else {
			tweetsList =  tweetDAO.getFilteredTweetsList(userID, subscriptorsID);
		}
		tweetsList.sort(Comparator.comparing(BeanTweet::getPublicationDate).thenComparing(BeanTweet::getPopularity));
		Collections.reverse(tweetsList);
		return tweetsList;	
	}
	public int getTweetPopularity(BeanTweet tweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		return tweetDAO.getTweetPopularity(tweet);
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

	public void deleteUserTweets(int user) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.deleteUserTweets(user);
	}

	public void editTweet(BeanTweet tweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.editTweet(tweet);
		
	}
}
