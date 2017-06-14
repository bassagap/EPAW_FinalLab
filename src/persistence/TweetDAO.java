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

	public ArrayList<BeanTweet> getFilteredTweetsList(String userName){
		ArrayList<BeanTweet> tweetsList = new ArrayList<BeanTweet>();
		try {
			String query = "SELECT * FROM TWEETS WHERE USER = '" + userName + "' OR VISIBILITY = 'public'" ;
			ResultSet resultSet =  statement.executeQuery(query);
			while(resultSet.next()){
				BeanTweet tweet = new BeanTweet(); 
				tweet.setHashTag(resultSet.getString("hashtag"));
				tweet.setDescription(resultSet.getString("description"));
				tweet.setUser(resultSet.getString("user"));
				tweet.setVisibility(resultSet.getString("visibility"));
				tweet.setPublicationDate(resultSet.getDate("publicationDate"));
				tweet.setIdTweet(resultSet.getInt("idtweets"));
				tweetsList.add(tweet);
			}
			resultSet.close();
			statement.close();
		} catch (SQLException e) {
            e.printStackTrace();
        }	
		return tweetsList;
	}
	public ArrayList<BeanTweet> getFullTweetsList(String userName){
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
				tweet.setIdTweet(resultSet.getInt("idtweets"));
				tweetsList.add(tweet);
			}
			resultSet.close();
			statement.close();
		} catch (SQLException e) {
            e.printStackTrace();
        }	
		return tweetsList;
	}

	public void insertTweet(BeanTweet tweet) throws SQLException {
		String query = "INSERT INTO TWEETS (HASHTAG, USER, PUBLICATIONDATE, DESCRIPTION, VISIBILITY) VALUES ('"+tweet.getHashTag()+ "', '" + tweet.getUser()+  "', '" +tweet.getPublicationDate()+ "', '"+ tweet.getDescription() + "', '"+tweet.getVisibility()+ "')"; 
		int resultSet =  statement.executeUpdate(query);
	}
	public void deleteTweet(int idTweet) throws SQLException{
		String query = "DELETE FROM TWEETS WHERE IDTWEETS = '"+ idTweet + "'"; 
		int resultSet =  statement.executeUpdate(query);
	}
	public String getTweetUser(int idTweet) throws SQLException{
		String user = ""; 
		String query = "SELECT * FROM TWEETS WHERE IDTWEETS = '"+ idTweet + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if (resultSet.next()) {
			user = resultSet.getString("user");
		}
		return user; 
	}

}

