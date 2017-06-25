package persistence;

import java.sql.*;
import java.util.ArrayList;
import models.BeanUser;


public class UserDAO {
	private Connection connection;
	private Statement statement;
	
	public UserDAO() throws Exception{
		String user = "mysql";
		String password = "prac"; 
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection("jdbc:mysql://localhost/ts1?user=" + user + "&password=" + password ); 
		statement = connection.createStatement(); 
	}
	public void disconnectBD() throws SQLException {
		statement.close();
		connection.close();
	}
	/**
	 * Inserts a new user to the database
	 * @param user new user registered
	 * @throws SQLException
	 */
	public void insertUser(BeanUser user) throws SQLException{
		String query = "INSERT INTO USERS (USERNAME, PASSWORD, GENDER, WEIGHT, DATEOFBIRTH, MAIL) VALUES ('"+user.getUserName()+ "', '" + user.getPassword()+  "', '" +user.getGender()+ "', '"+ user.getWeight() + "', '"+user.getDateOfBirth()+"', '"+ user.getMail()+ "')"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	/**
	 * Deletes a user register from the users table 
	 * @param userID of the user to be deleted
	 * @throws SQLException
	 */
	public void deletetUser(int userID) throws SQLException{
		String query ="DELETE FROM USERS WHERE ID = '"+ userID + "'"; 
		int resultSet =  statement.executeUpdate(query);
	}
	/**
	 * Gets the user object from the given userName register on the user table. 
	 * @param userName of the register to be recovered from the DB
	 * @return user returns the user object of the given register with the given userName
	 * @throws Exception
	 */
	public BeanUser getUser(String userName) throws Exception {
		BeanUser user = new BeanUser(); 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			user.setUserId(resultSet.getInt("id"));
			user.setUserName(resultSet.getString("userName"));
			user.setMail(resultSet.getString("mail"));
			user.setVisibility(resultSet.getString("visibility"));
			user.setUserType(resultSet.getString("userType"));
			user.setPassword(resultSet.getString("password"));
		}
		disconnectBD();
		return user;
	}

	/**
	 * Gets all users list from the users table
	 * @return userList users object list 
	 * @throws Exception
	 */
	public ArrayList<BeanUser> getUsersList () throws Exception{
		String query = "SELECT * FROM USERS";
		ResultSet resultSet =  statement.executeQuery(query);
		ArrayList<BeanUser> userList = new ArrayList<BeanUser>();
		  while(resultSet.next()){
			 BeanUser user = new BeanUser(); 
			 user.setUserId(resultSet.getInt("id"));
			 user.setUserName(resultSet.getString("userName"));
			 user.setPassword(resultSet.getString("password"));
			 user.setMail(resultSet.getString("mail"));
			 user.setVisibility(resultSet.getString("visibility"));
			 user.setUserType(resultSet.getString("userType"));
			 userList.add(user);
		  }
		  disconnectBD();
		  return userList;
	}
	/**
	 * Verifies if the given user and password register exists on the users table 
	 * @param userName of the user to be loged
	 * @param password of the user to be loged
	 * @return isValid Boolean true if the user with the given password exists in the users table
	 * @throws SQLException
	 */
	public boolean isValidLogin(String userName, String password) throws SQLException {
		Boolean isValid = false; 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName +"' AND PASSWORD = '" + password + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isValid = true; 
		}
		disconnectBD();
		return isValid; 
	}

	/**
	 * Insert a new subscription register into the subscriptions table for the given user and the given subscriptor ID
	 * @param userID user who subscribes to another user
	 * @param subscriptorID user to which the user is subscribed
	 * @throws SQLException
	 */
	public void addSubscriptions(int userID, int subscriptorID) throws SQLException{
		String query = "INSERT INTO SUBSCRIPTIONS (USER_ID, SUBSCRIPTION_ID) VALUES ('" + userID+ "', '" + subscriptorID + "')";
		int resultSet =  statement.executeUpdate(query);	
		disconnectBD();
	}
	/**
	 * Deletes a subscription register of the given user and subscriptor id
	 * @param userID user who unsubscribes from another user
	 * @param subscriptorID user to which the user is unsubscribed
	 * @throws SQLException
	 */
	public void deleteSubscription(int userID, int subscriptorID) throws SQLException{
		String query = "DELETE FROM SUBSCRIPTIONS WHERE SUBSCRIPTION_ID = '"+ subscriptorID + "' AND USER_ID = '"+ userID +"'"; ;
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	
	/**
	 * Get a list of the subscriptions of a given user
	 * @param userID the user from which the subscriptions are calculated
	 * @return subscriptionsList the list with the user IDs to which the user is subscribed.
	 * @throws SQLException
	 */
	public ArrayList<Integer> getSubscriptions(int userID) throws SQLException{
		ArrayList<Integer> subscriptionsList = new ArrayList<Integer>(); 
		String query = "SELECT * FROM USERS INNER JOIN subscriptions ON (users.id = subscriptions.user_id) WHERE users.id = '" + userID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		
		 while(resultSet.next()){
			 Integer id = resultSet.getInt("subscription_id");
			 subscriptionsList.add(id);
		  }
		 disconnectBD();
		return subscriptionsList;		
	}

	/**
	 * Get the user name of a user by a given attribute
	 * @param id the user id 
	 * @param attr the attribute recovered
	 * @return userName of the user register with the given ID
	 * @throws SQLException
	 */
	public String getUserNameByAttr(int id, String attr) throws SQLException{
		String query = "SELECT * FROM USERS WHERE ID = '" + id + "'"; 
		String userName = "";
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			userName = resultSet.getString(attr);
		}
		disconnectBD();
		return userName;
	}


}
