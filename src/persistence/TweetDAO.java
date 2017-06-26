package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import models.BeanTweet;

public class TweetDAO {
	private Connection connection;
	private Statement statement;

	public TweetDAO() throws Exception{
		String user = "mysql";
		String password = "prac"; 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection("jdbc:mysql://localhost/ts1?user=" + user + "&password=" + password ); 
		statement = connection.createStatement(); 
	}

	/**
	 * Gets the tweets list filtering by user's, user subscriptior's tweets and public user's tweets 
	 * @param userID of the user from which the tweet list is going to be retrieved
	 * @param subscriptors of the given user
	 * @return tweetsList with tweets from the user, its subscriptors, and the public users
	 * @throws SQLException
	 */
	public ArrayList<BeanTweet> getFilteredTweetsList(int userID, ArrayList<Integer> subscriptors) throws SQLException{
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			subscriptors.add(userID);	
			for (Integer user : subscriptors){
				String query = "SELECT * FROM TWEETS WHERE (USER_ID1 = '" + user + "' AND NOT VISIBILITY = 'public' ) OR (VISIBILITY = 'public' AND NOT USER_ID1 = '"+ user +"')";
				ResultSet resultSet =  statement.executeQuery(query);
				while(resultSet.next()){
					BeanTweet tweet = new BeanTweet(); 
					tweet.setHashTag(resultSet.getString("hashtag"));
					tweet.setDescription(resultSet.getString("description"));
					tweet.setUser(resultSet.getString("user"));
					tweet.setVisibility(resultSet.getString("visibility"));
					tweet.setPublicationDate(resultSet.getDate("publicationDate"));
					tweet.setIdTweet(resultSet.getInt("id"));
					tweet.setLikes(resultSet.getInt("likes"));
					tweet.setParentTweet(resultSet.getInt("parentTweet"));
					tweetsList.add(tweet);
				}
			}
		} catch (SQLException e) {
            e.printStackTrace();
        }
		disconnectBD();
		return tweetsList;
	}
	/**
	 * Gets the full tweets list, it is meant for admin users 
	 * @return tweetsList full tweet list retrieved from the tweets table
	 * @throws SQLException
	 */
	public ArrayList<BeanTweet> getFullTweetsList() throws SQLException{
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			String query = "SELECT * FROM TWEETS" ;
			ResultSet resultSet =  statement.executeQuery(query);
			while(resultSet.next()){
				BeanTweet tweet = new BeanTweet(); 
				tweet.setHashTag(resultSet.getString("hashtag"));
				tweet.setDescription(resultSet.getString("description"));
				tweet.setUser(resultSet.getString("user"));
				tweet.setVisibility(resultSet.getString("visibility"));
				tweet.setPublicationDate(resultSet.getDate("publicationDate"));
				tweet.setIdTweet(resultSet.getInt("id"));
				tweet.setLikes(resultSet.getInt("likes"));
				tweetsList.add(tweet);
			}
			resultSet.close();
			statement.close();
		} catch (SQLException e) {
            e.printStackTrace();
        }	
		disconnectBD();
		return tweetsList;
	}
	/**
	 * Gets the tweets list filtering by user's and user subscriptior's tweets 
	 * @param userID  of the user from which the personalized tweet list is going to be retrieved
	 * @param subscriptors of the given user
	 * @return tweetsList with tweets from the user and its subscriptors only
	 * @throws SQLException
	 */
	/**
	 * Gets the User's Tweets
	 * @param userID of the user from which the tweet list is going to be retrieved
	 * @return tweetsList with tweets from the user
	 * @throws SQLException
	 */
	public ArrayList<BeanTweet> getUserTweets(int userID) throws SQLException{
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			String query = "SELECT * FROM TWEETS WHERE (USER_ID1 = '" + userID + "')";
			ResultSet resultSet =  statement.executeQuery(query);
			while(resultSet.next()){
				BeanTweet tweet = new BeanTweet(); 
				tweet.setHashTag(resultSet.getString("hashtag"));
				tweet.setDescription(resultSet.getString("description"));
				tweet.setUser(resultSet.getString("user"));
				tweet.setVisibility(resultSet.getString("visibility"));
				tweet.setPublicationDate(resultSet.getDate("publicationDate"));
				tweet.setIdTweet(resultSet.getInt("id"));
				tweet.setLikes(resultSet.getInt("likes"));
				tweet.setParentTweet(resultSet.getInt("parentTweet"));
				tweetsList.add(tweet);
			}
		} catch (SQLException e) {
            e.printStackTrace();
        }
		disconnectBD();
		return tweetsList;
	}
	public ArrayList<BeanTweet> getPersonalizedTweetsList(int userID, ArrayList<Integer> subscriptors) throws SQLException{
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			subscriptors.add(userID);
			for (Integer user : subscriptors){
				String query = "SELECT * FROM TWEETS WHERE USER_ID1 = '" + user + "'";
				ResultSet resultSet =  statement.executeQuery(query);
				while(resultSet.next()){
					BeanTweet tweet = new BeanTweet(); 
					tweet.setHashTag(resultSet.getString("hashtag"));
					tweet.setDescription(resultSet.getString("description"));
					tweet.setUser(resultSet.getString("user"));
					tweet.setVisibility(resultSet.getString("visibility"));
					tweet.setPublicationDate(resultSet.getDate("publicationDate"));
					tweet.setIdTweet(resultSet.getInt("id"));
					tweet.setLikes(resultSet.getInt("likes"));
					tweet.setParentTweet(resultSet.getInt("parentTweet"));
					tweetsList.add(tweet);
				}
			}
		} catch (SQLException e) {
            e.printStackTrace();
        }	
		disconnectBD();
		return tweetsList;
	}
	/**
	 * Get the tweet with the given ID
	 * @param tweetID of the tweet register to be retrieved
	 * @return tweet object with all the information from tweet register on the table tweets 
	 * @throws SQLException
	 */
	public BeanTweet getTweet(int tweetID) throws SQLException {
		BeanTweet tweet = new BeanTweet(); 
		String query = "SELECT * FROM TWEETS WHERE ID = '"+ tweetID + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()) {
			tweet.setHashTag(resultSet.getString("hashtag"));
			tweet.setDescription(resultSet.getString("description"));
			tweet.setUser(resultSet.getString("user"));
			tweet.setVisibility(resultSet.getString("visibility"));
			tweet.setPublicationDate(resultSet.getDate("publicationDate"));
			tweet.setIdTweet(resultSet.getInt("id"));
			tweet.setLikes(resultSet.getInt("likes"));
			tweet.setParentTweet(resultSet.getInt("parentTweet"));
		}
		disconnectBD();
		return tweet;
	}
	/**
	 * Inserts a tweet into the tweets table on the DB
	 * @param tweet object with all the information needed to be inserted as a new register on the tweets table
	 * @throws SQLException
	 */
	public void insertTweet(BeanTweet tweet) throws SQLException {
		String query = "INSERT INTO TWEETS (HASHTAG, USER, PUBLICATIONDATE, DESCRIPTION, VISIBILITY, USER_ID1, PARENTTWEET) VALUES ('"+tweet.getHashTag()+ "', '" + tweet.getUser()+  "', '" +tweet.getPublicationDate()+ "', '"+ tweet.getDescription() + "', '"+tweet.getVisibility()+ "','" + tweet.getUser_id1() + "', '"+tweet.getParentTweet() + "')"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	/**
	 * Delets the tweet register with the given ID of the tweets table 
	 * @param idTweet integer indicating the tweet register on the tweeets table to be deleted 
	 * @throws SQLException
	 */
	public void deleteTweet(int idTweet) throws SQLException{
		String query = "DELETE FROM TWEETS WHERE ID = '"+ idTweet + "'"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}

	/**
	 * Updates the tweet register with the given ID of the tweets table 
	 * @param tweet  object with the information needed to update its register on tweets table 
	 * @throws SQLException
	 */
	public void editTweet(BeanTweet tweet) throws SQLException {
		String query = "UPDATE tweets SET LIKES = '" +tweet.getLikes()+ "', HASHTAG = '" + tweet.getHashTag() + "' , DESCRIPTION = '"+tweet.getDescription()  +"' WHERE ID = '" + tweet.getIdTweet() +"'";
		int resultSet =  statement.executeUpdate(query);
		statement.close();
		disconnectBD();
	}

	// Like feature: 
	
	/**
	 * Insert a new like register into the likes table
	 * @param userID 
	 * @param tweetID
	 * @throws SQLException
	 */
	public void addLike(int userID, int tweetID) throws SQLException{
		String query = "INSERT INTO LIKES (USER_ID2, TWEET_ID2) VALUES ('" + userID + "', '" + tweetID + "')";
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	/**
	 * Updates the number of likes of a tweet register in the tweets table 
	 * @param tweet
	 * @throws SQLException
	 */
	public void updateLike(BeanTweet tweet) throws SQLException{
		String query ="UPDATE tweets SET LIKES = '" +tweet.getLikes()+ "' WHERE ID = '" + tweet.getIdTweet() +"'";
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	/**
	 * Deletes a like register of a given user and tweet IDs from the likes table
	 * @param userID
	 * @param tweetID
	 * @throws SQLException
	 */
	public void deleteLike(int userID, int tweetID) throws SQLException{
		String query = "DELETE FROM LIKES WHERE USER_ID2 = '"+ userID + "' AND TWEET_ID2 = '"+ tweetID +"'"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}

	/**
	 * Get the number of likes that a tweet has 
	 * @param tweetID
	 * @return likes 
	 * @throws SQLException
	 */
	public Integer countTweetLikes (int tweetID) throws SQLException{
		Integer likes = 0; 
		String query = "SELECT * FROM LIKES INNER JOIN TWEETS ON (likes.tweet_id2 = tweets.id) WHERE tweets.id ='" + tweetID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		 while(resultSet.next()){
			 likes ++;
		  }
		 disconnectBD();
		return likes;		
	}
	/**
	 * Checks if a given user has liked or not a given tweet
	 * @param tweetID
	 * @param userID
	 * @return userHasLiked: returns true if the user has liked the given tweet
	 * @throws SQLException
	 */
	public Boolean userHasLiked(int tweetID, int userID) throws SQLException{
		Boolean userHasLiked = false; 
		String query = "SELECT * FROM LIKES INNER JOIN TWEETS ON (likes.tweet_id2 = tweets.id) WHERE tweets.id ='" + tweetID + "' AND likes.user_id2 = '" + userID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		 if(resultSet.next()){
			 userHasLiked = true; 
		  }
		 disconnectBD();
		return userHasLiked;		
	}
	public void disconnectBD() throws SQLException {
		statement.close();
		connection.close();
	}
	/**
	 * Search Tweet by given attribute
	 * @param search
	 * @param attribute
	 * @return tweetsList
	 * @throws SQLException
	 */
	public ArrayList<BeanTweet>  searchTweetByAttr (String search, String attribute) throws SQLException{
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>(); 
		String query = "SELECT * FROM TWEETS WHERE " + attribute  + " LIKE '%" + search + "%'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		while(resultSet.next()){
			BeanTweet tweet = new BeanTweet(); 
			tweet.setHashTag(resultSet.getString("hashtag"));
			tweet.setDescription(resultSet.getString("description"));
			tweet.setUser(resultSet.getString("user"));
			tweet.setVisibility(resultSet.getString("visibility"));
			tweet.setPublicationDate(resultSet.getDate("publicationDate"));
			tweet.setIdTweet(resultSet.getInt("id"));
			tweet.setLikes(resultSet.getInt("likes"));
			tweet.setParentTweet(resultSet.getInt("parentTweet"));
			tweetsList.add(tweet);
		}
		disconnectBD();
		return tweetsList;		
	}
}