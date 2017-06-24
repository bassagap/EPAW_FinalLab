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
	public void insertUser(BeanUser user) throws SQLException{
		String query = "INSERT INTO USERS (USERNAME, PASSWORD, GENDER, WEIGHT, DATEOFBIRTH, MAIL) VALUES ('"+user.getUserName()+ "', '" + user.getPassword()+  "', '" +user.getGender()+ "', '"+ user.getWeight() + "', '"+user.getDateOfBirth()+"', '"+ user.getMail()+ "')"; 
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
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

	public void addSubscriptions(int userID, int subscriptorID) throws SQLException{
		String query = "INSERT INTO SUBSCRIPTIONS (USER_ID, SUBSCRIPTION_ID) VALUES ('" + userID+ "', '" + subscriptorID + "')";
		int resultSet =  statement.executeUpdate(query);	
		disconnectBD();
	}
	public void deleteSubscription(int userID, int subscriptorID) throws SQLException{
		String query = "DELETE FROM SUBSCRIPTIONS WHERE SUBSCRIPTION_ID = '"+ subscriptorID + "' AND USER_ID = '"+ userID +"'"; ;
		int resultSet =  statement.executeUpdate(query);
		disconnectBD();
	}
	
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

}
