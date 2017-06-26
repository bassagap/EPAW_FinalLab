package service;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import models.BeanTweet;
import models.BeanUser;
import persistence.TweetDAO;


public class TweetService {
	
	/**
	 * Returns the tweet list filtred according to user profile and storyline configuration and ordered by date and likes
	 * @param userName of the loged user
	 * @param personalized, indicates the storyline configuration.
	 * @return tweetList of type ArrayList<BeanTweet>  with the tweets already filtered and orderd
	 * @throws Exception
	 */
	public ArrayList<BeanTweet> getTweetsList(String userName, String personalized, Boolean isSearching, String search) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		UserService userService = new UserService();
		BeanUser user = userService.getUser(userName);
		ArrayList<Integer> subscriptorsID = userService.getSubscriptionsList(user.getUserId());
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();		
		if("admin".equals(user.getUserType())){
			tweetsList =  tweetDAO.getFullTweetsList();
		} else if ("true".equals(personalized)){
			tweetsList =  tweetDAO.getPersonalizedTweetsList(user.getUserId(), subscriptorsID);
		} else if (isSearching){
			tweetsList = tweetDAO.searchTweetByAttr(search, "user");
		}
		else {
			tweetsList =  tweetDAO.getFilteredTweetsList(user.getUserId(), subscriptorsID);
		}
		enrichTweetList(tweetsList, user.getUserId());
		tweetsList.sort(Comparator.comparing(BeanTweet::getPublicationDate).thenComparing(BeanTweet::getLikes));
		Collections.reverse(tweetsList);
		return tweetsList;	
	}
	
	
	/**
	 * Inserts a tweet into the database
	 * @param tweet
	 * @throws Exception
	 */
	public void insertTweet(BeanTweet tweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.insertTweet(tweet);
	}
	
	/**
	 * Deletes a tweet from the database
	 * @param idTweet
	 * @throws Exception
	 */
	public void deleteTweet(int idTweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.deleteTweet(idTweet);
	}
	

	/**
	 * Edits the given tweet
	 * @param tweet
	 * @throws Exception
	 */
	public void editTweet(BeanTweet tweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.editTweet(tweet);
	}
	
	/**
	 * Retweet a tweet, this means that inserts a new tweet into the database, with the retweeted tweet description and hashtag, but with the retweeter user as the owner, 
	 * with new date and likes setted to zero again
	 * @param userID
	 * @param tweetID
	 * @param date
	 * @return tweet added to the database. 
	 * @throws Exception
	 */
	public BeanTweet retweet(int userID, int tweetID, java.sql.Date date ) throws Exception{
		BeanTweet tweet = new BeanTweet(); 
		UserService userService = new UserService(); 
		TweetDAO tweetDAO = new TweetDAO(); 
		tweet = tweetDAO.getTweet(tweetID); 
		tweet.setUser_id1(userID);
		tweet.setUser(userService.getUserName(userID));
		tweet.setPublicationDate(date);
		tweet.setParentTweet(tweetID);
		insertTweet(tweet); 
		return tweet; 
	}

	/**
	 * Deletes a tweet
	 * @param userID
	 * @param tweetID
	 * @throws Exception
	 */
	public void deleteLike(int userID, int tweetID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.deleteLike(userID, tweetID);
	}
	
	/**
	 * Adds a like from user with the given ID to the tweet with the given ID 
	 * @param userID of the user who liked a tweet
	 * @param tweetID of the tweet liked by a user
	 * @throws Exception
	 */
	public void addLike(int userID, int tweetID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.addLike(userID, tweetID);
	}
	
	/**
	 * Updates the number of likes of a tweet 
	 * @param tweet
	 * @throws Exception
	 */
	public void updateLike(BeanTweet tweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.updateLike(tweet);
	}
	
	/**
	 * Gets the tweet from the DB and enrichs it with information not stored in the DB. 
	 * @param idTweet
	 * @param userID
	 * @return tweet enriched 
	 * @throws Exception
	 */
	public BeanTweet getTweet(int idTweet, int userID) throws Exception {
		BeanTweet tweet = new BeanTweet(); 
		TweetDAO tweetDAO = new TweetDAO(); 
		tweet = tweetDAO.getTweet(idTweet); 
		enrichTweet(tweet, userID); 
		return tweet; 
	}
	
	/**
	 * @param idTweet
	 * @return
	 * @throws Exception
	 */
	private int countTweetLikes(int idTweet) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		return tweetDAO.countTweetLikes(idTweet);
	}
	
	/**
	 * @param idTweet
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	private boolean userHasLiked(int idTweet, int userID) throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		return tweetDAO.userHasLiked(idTweet, userID);
	}
	
	/**
	 * @throws Exception
	 */
	public void disconectBD() throws Exception {
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.disconnectBD();
	}
	
	/**
	 * @param tweet
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	private BeanTweet enrichTweet (BeanTweet tweet, int userID) throws Exception{
		tweet.setLikes(countTweetLikes(tweet.getIdTweet()));
		if(userHasLiked(tweet.getIdTweet(), userID)){
			 tweet.setIsLiked(true);
		} else {
			tweet.setIsLiked(false);
		}
		return tweet; 
	}
	
	/**
	 * @param tweetsList
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	private ArrayList<BeanTweet> enrichTweetList(ArrayList<BeanTweet> tweetsList, int userID) throws Exception{
		for(BeanTweet tweet : tweetsList){
			enrichTweet(tweet, userID);
		}
		return tweetsList;
	}
	
}
