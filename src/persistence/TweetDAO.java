package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import models.BeanTweet;
import models.BeanUser;

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

	public ArrayList<BeanTweet> getFilteredTweetsList(int userID, ArrayList<Integer> subscriptors) throws SQLException{
		//  TO DO: Pass the subscriptors variable in a popper way
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			subscriptors.add(userID);
			
			for (Integer user : subscriptors){
				String query = "SELECT * FROM TWEETS WHERE USER_ID1 = '" + user + "' AND NOT VISIBILITY = 'public'";
				ResultSet resultSet =  statement.executeQuery(query);
				while(resultSet.next()){
					BeanTweet tweet = new BeanTweet(); 
					tweet.setHashTag(resultSet.getString("hashtag"));
					tweet.setDescription(resultSet.getString("description"));
					tweet.setUser(resultSet.getString("user"));
					tweet.setVisibility(resultSet.getString("visibility"));
					tweet.setPublicationDate(resultSet.getDate("publicationDate"));
					tweet.setIdTweet(resultSet.getInt("id"));
					tweet.setPopularity(resultSet.getInt("popularity"));
					tweet.setLikes(resultSet.getInt("likes"));
					tweetsList.add(tweet);
				}
			}
			String query = "SELECT * FROM TWEETS WHERE VISIBILITY = 'public'";
			ResultSet resultSet =  statement.executeQuery(query);
			while(resultSet.next()){
				BeanTweet tweet = new BeanTweet(); 
				tweet.setHashTag(resultSet.getString("hashtag"));
				tweet.setDescription(resultSet.getString("description"));
				tweet.setUser(resultSet.getString("user"));
				tweet.setVisibility(resultSet.getString("visibility"));
				tweet.setPublicationDate(resultSet.getDate("publicationDate"));
				tweet.setIdTweet(resultSet.getInt("id"));
				tweet.setPopularity(resultSet.getInt("popularity"));
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
	public ArrayList<BeanTweet> getFullTweetsList(String userName) throws SQLException{
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
				tweet.setPopularity(resultSet.getInt("popularity"));
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
	public ArrayList<BeanTweet> getPersonalizedTweetsList(int userID, ArrayList<Integer> subscriptors) throws SQLException{
		//  TO DO: Pass the subscriptors variable in a popper way
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
					tweet.setPopularity(resultSet.getInt("popularity"));
					tweet.setLikes(resultSet.getInt("likes"));
					tweetsList.add(tweet);
				}
				//resultSet.close();
				//statement.close();
			}
		} catch (SQLException e) {
            e.printStackTrace();
        }	
		disconnectBD();
		return tweetsList;
	}
	public void insertTweet(BeanTweet tweet) throws SQLException {
		String query = "INSERT INTO TWEETS (HASHTAG, USER, PUBLICATIONDATE, DESCRIPTION, VISIBILITY, USER_ID1, POPULARITY) VALUES ('"+tweet.getHashTag()+ "', '" + tweet.getUser()+  "', '" +tweet.getPublicationDate()+ "', '"+ tweet.getDescription() + "', '"+tweet.getVisibility()+ "','" + tweet.getUser_id1() + "', '"+ tweet.getPopularity()+"')"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	public void deleteTweet(int idTweet) throws SQLException{
		String query = "DELETE FROM TWEETS WHERE ID = '"+ idTweet + "'"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	public String getTweetUser(int idTweet) throws SQLException{
		String user = ""; 
		String query = "SELECT * FROM TWEETS WHERE ID = '"+ idTweet + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if (resultSet.next()) {
			user = resultSet.getString("user");
		}
		disconnectBD();
		return user; 
	}
	public int getTweetPopularity(BeanTweet tweet) throws SQLException{
		String hashTag = tweet.getHashTag(); 
		int popularity = 0; 
		String query = "SELECT * FROM TWEETS WHERE HASHTAG = '"+ hashTag + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		while(resultSet.next()) {
			popularity++; 
		}
		disconnectBD();
		return popularity; 
	}
	public void deleteUserTweets(int userID) throws SQLException {
		String query = "DELETE FROM TWEETS WHERE USER_ID1 = '"+ userID + "'"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}

	public void editTweet(BeanTweet tweet) throws SQLException {
		String query = "UPDATE tweets SET LIKES = '" +tweet.getLikes()+ "' WHERE ID = '" + tweet.getIdTweet() +"'";
		int resultSet =  statement.executeUpdate(query);
		statement.close();
		disconnectBD();
	}

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
			tweet.setPopularity(resultSet.getInt("popularity"));
			tweet.setLikes(resultSet.getInt("likes"));
		}
		disconnectBD();
		return tweet;
	}
	// Like feature: 
	
	public void addLike(int userID, int tweetID) throws SQLException{
		System.out.println("Error: " + userID);
		System.out.println("Error: " + tweetID);
		String query = "INSERT INTO LIKES (USER_ID2, TWEET_ID2) VALUES ('" + userID + "', '" + tweetID + "')";
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	public void updateLike(BeanTweet tweet) throws SQLException{
		String query ="UPDATE tweets SET LIKES = '" +tweet.getLikes()+ "' WHERE ID = '" + tweet.getIdTweet() +"'";
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	public void deleteLike(int userID, int tweetID) throws SQLException{
		String query = "DELETE FROM LIKES WHERE USER_ID2 = '"+ userID + "' AND TWEET_ID2 = '"+ tweetID +"'"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	public ArrayList<Integer> getLikes(int tweetID) throws SQLException{
		ArrayList<Integer> likesList = new ArrayList<Integer>(); 
		String query = "SELECT * FROM LIKES INNER JOIN TWEETS ON (likes.tweet_id2 = tweets.id) WHERE tweets.id ='" + tweetID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		 while(resultSet.next()){
			 Integer id = resultSet.getInt("subscription_id");
			 likesList.add(id);
		  }
		 disconnectBD();
		return likesList;		
	}
	public Integer countTweetLikes (int tweetID) throws SQLException{
		Integer likes = 0; 
		String query = "SELECT * FROM LIKES INNER JOIN TWEETS ON (likes.tweet_id2 = tweets.id) WHERE tweets.id ='" + tweetID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		 while(resultSet.next()){
			 likes ++;
		  }
		 System.out.println("Count: " + likes);
		 disconnectBD();
		return likes;		
	}
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
}

