package service;

import java.util.ArrayList;
import models.BeanTweet;
import persistence.TweetDAO;


public class TweetService {
	
	public ArrayList<BeanTweet> getTweetsList(String userName) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		UserService userService = new UserService();
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		if(userService.isAdminUser(userName)){
			tweetsList =  tweetDAO.getFullTweetsList(userName);
		} else {
			tweetsList =  tweetDAO.getFilteredTweetsList(userName);
		}
		 
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
}
