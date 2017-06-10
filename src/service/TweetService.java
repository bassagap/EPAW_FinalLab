package service;

import java.util.ArrayList;
import models.BeanTweet;
import persistence.TweetDAO;


public class TweetService {
	public ArrayList<BeanTweet> getTweetsList() throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		ArrayList<BeanTweet> tweetsList =  tweetDAO.getTweetsList();
		return tweetsList;	
	}

	public void insertTweet(BeanTweet tweet) throws Exception{
		TweetDAO tweetDAO = new TweetDAO(); 
		tweetDAO.insertTweet(tweet);
	}

}
