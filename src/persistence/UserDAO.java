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
		String query = "SELECT * FROM TAULA WHERE USERNAME = '" + userName +"'"; 
		ResultSet resultSet =  statement.executeQuery(query);
		if(resultSet.next()){
			isValid = false; 
		}
		return isValid; 
	}
	public void insertUser(BeanUser user) throws SQLException{
		String query = "INSERT INTO TAULA (USERNAME, PASSWORD, GENDER, WEIGHT, DATEOFBIRTH, MAIL) VALUES ('"+user.getUserName()+ "', '" + user.getPassword()+  "', '" +user.getGender()+ "', '"+ user.getWeight() + "', '"+user.getDateOfBirth()+"', '"+ user.getMail()+ "')"; 
		int resultSet =  statement.executeUpdate(query);
	}
	
	// execute query to access users table: 
	public ArrayList<BeanUser> getUsersList () throws Exception{
		String query = "SELECT * FROM TAULA";
		ResultSet resultSet =  statement.executeQuery(query);
		ArrayList<BeanUser> userList = new ArrayList<BeanUser>();
		  while(resultSet.next()){
			 BeanUser user = new BeanUser(); 
			 user.setUserName(resultSet.getString("userName"));
			 user.setPassword(resultSet.getString("password"));
			 user.setMail(resultSet.getString("mail"));
			 userList.add(user);
		  }
		  return userList;
		
	}
	public void disconnectBD() throws SQLException {
		statement.close();
		connection.close();
	}
}
