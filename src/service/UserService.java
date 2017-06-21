package service;

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
	public String getUserName(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUserNameByAttr(id,"userName");
	}
	public String getUserEmail(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUserNameByAttr(id,"mail");
	}
	public String getUserType(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUserNameByAttr(id,"userType");
	}
	public Boolean userExistsByName (String user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return !userDAO.isValidUserName(user); 
	}
	public void deletetUser(int user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		TweetService tweetService = new TweetService();
		userDAO.deletetUser(user);
		userDAO.deleteSubscriptions(user);
		tweetService.deleteUserTweets(user);
		
	}
	public ArrayList<Integer> getSubscriptionsList(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<Integer> usersList =  userDAO.getSubscriptions(id);
		return usersList;	
	}
}
