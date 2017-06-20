package service;

import java.sql.SQLException;
import java.util.ArrayList;
import models.BeanUser;
import persistence.UserDAO;

public class UserService {
	public ArrayList<BeanUser> getUsersList() throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<BeanUser> usersList =  userDAO.getUsersList();
		return usersList;	
	}
	public Boolean userExists (BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return !userDAO.isValidUserName(user.getUserName()); 
	}
	public void insertUser(BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		userDAO.insertUser(user);
	}
	public boolean LoginUser(BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.isValidLogin(user.getUserName(), user.getPassword());
	}
	public boolean isAdminUser(String userName) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.isAdminUser(userName);
	}
	public boolean isPublicUser(String userName) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.isPublicUser(userName);
	}
	public int getUserID(String userName) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUserID(userName);
	}
	public void deletetUser(int user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		TweetService tweetService = new TweetService();
		userDAO.deletetUser(user);
		userDAO.deleteSubscriptions(user);
		tweetService.deleteUserTweets(user);
		
	}
	public ArrayList<Integer> getSubscriptors(int userID) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getSubscriptions(userID);
	}
}
