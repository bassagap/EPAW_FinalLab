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
	public Boolean isValidUserName(String userName) throws SQLException{
		Boolean isValid = true; 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName +"'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isValid = false; 
		}
		return isValid; 
	}
	public void insertUser(BeanUser user) throws SQLException{
		String query = "INSERT INTO USERS (USERNAME, PASSWORD, GENDER, WEIGHT, DATEOFBIRTH, MAIL) VALUES ('"+user.getUserName()+ "', '" + user.getPassword()+  "', '" +user.getGender()+ "', '"+ user.getWeight() + "', '"+user.getDateOfBirth()+"', '"+ user.getMail()+ "')"; 
		int resultSet =  statement.executeUpdate(query);
	}
	public void deletetUser(int userID) throws SQLException{
		String query ="DELETE FROM USERS WHERE ID = '"+ userID + "'"; 
		int resultSet =  statement.executeUpdate(query);
	}
	// execute query to access users table: 
	public ArrayList<BeanUser> getUsersList () throws Exception{
		String query = "SELECT * FROM USERS";
		ResultSet resultSet =  statement.executeQuery(query);
		ArrayList<BeanUser> userList = new ArrayList<BeanUser>();
		  while(resultSet.next()){
			 BeanUser user = new BeanUser(); 
			 user.setUserName(resultSet.getString("userName"));
			 user.setPassword(resultSet.getString("password"));
			 user.setMail(resultSet.getString("mail"));
			 user.setVisibility(resultSet.getString("visibility"));
			 user.setUserType(resultSet.getString("userType"));
			 userList.add(user);
		  }
		  return userList;
		
	}
	public void disconnectBD() throws SQLException {
		statement.close();
		connection.close();
	}
	public boolean isValidLogin(String userName, String password) throws SQLException {
		Boolean isValid = false; 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName +"' AND PASSWORD = '" + password + "'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isValid = true; 
		}
		return isValid; 
	}
	public boolean isAdminUser(String userName) throws SQLException {
		Boolean isAdmin = false; 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName + "' AND USERTYPE = 'admin'";  
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isAdmin = true; 
		}
		return isAdmin; 
	}
	public boolean isPublicUser(String userName) throws SQLException {
		Boolean isPublicUser = false; 
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName + "' AND VISIBILITY = 'public'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isPublicUser = true; 
		}
		return isPublicUser; 
	}
	public void addSubscriptions(int userID, int subscriptorID) throws SQLException{
		String query = "INSERT INTO SUBSCRIPTIONS (USER_ID, SUBSCRIPTION_ID) VALUES ('" + userID+ "', '" + subscriptorID + "')";
		int resultSet =  statement.executeUpdate(query);
	}
	public void deleteSubscription(int userID, int subscriptorID) throws SQLException{
		String query = "DELETE FROM SUBSCRIPTIONS WHERE SUBSCRIPTION_ID = '"+ subscriptorID + "' AND USER_ID = '"+ userID +"'"; ;
		int resultSet =  statement.executeUpdate(query);
	}
	public void deleteSubscriptions( int subscriptorID) throws SQLException{
		String query = "DELETE FROM SUBSCRIPTIONS WHERE SUBSCRIPTION_ID = '"+ subscriptorID + "'"; ;
		int resultSet =  statement.executeUpdate(query);
	}
	
	public ArrayList<Integer> getSubscriptions(int userID) throws SQLException{
		ArrayList<Integer> subscriptionsList = new ArrayList<Integer>(); 
		String query = "SELECT * FROM USERS INNER JOIN subscriptions ON (users.id = subscriptions.user_id) WHERE users.id = '" + userID + "'";
		ResultSet resultSet =  statement.executeQuery(query);
		
		 while(resultSet.next()){
			 Integer id = resultSet.getInt("subscription_id");
			 subscriptionsList.add(id);
		  }
		return subscriptionsList;		
	}
	public int getUserID(String userName) throws SQLException {		
		String query = "SELECT * FROM USERS WHERE USERNAME = '" + userName + "'"; 
		int userID = -1;
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			userID = resultSet.getInt("id");
		}
		return userID;
	}

	public String getUserNameByAttr(int id, String attr) throws SQLException{
		String query = "SELECT * FROM USERS WHERE ID = '" + id + "'"; 
		String userName = "";
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			userName = resultSet.getString(attr);
		}
		return userName;
	}
}
