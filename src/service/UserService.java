package service;

import java.sql.SQLException;
import java.util.ArrayList;
import models.BeanUser;
import persistence.UserDAO;

public class UserService {	

	/**
	 * Returns the full users' list
	 * @return The complete Users List in ArrayList<BeanUser> type.
	 * @throws Exception
	 */
	public ArrayList<BeanUser> getUsersList() throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<BeanUser> usersList =  userDAO.getUsersList();
		return usersList;	
	}

	/**
	 * Check if the user exists in the database
	 * @param a User 
	 * @return a Boolean true if exists. 
	 * @throws Exception
	 */
	public Boolean userExists (BeanUser user) throws Exception{
		ArrayList<BeanUser> usersList = getUsersList(); 
		Boolean exists = false; 
		for(BeanUser userInList: usersList){
			if(user.getUserName().equals(userInList.getUserName())){
				exists = true; 
			}
		}	
		return exists; 
	}
	
	/**
	 * Insert a user into the database
	 * @param a User 
	 * @throws Exception
	 */
	public void insertUser(BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		userDAO.insertUser(user);
	}
	
	/**
	 * Checks if the user can login 
	 * @param user
	 * @return Boolean true if the user can login
	 * @throws Exception
	 */
	public boolean LoginUser(BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.isValidLogin(user.getUserName(), user.getPassword());
	}
	
	/**
	 * Get the user Name of a user with a given id
	 * @param id
	 * @return the UserName
	 * @throws Exception
	 */
	public String getUserName(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUserNameByAttr(id,"userName");
	}

	/** 
	 * Deletes the user with the given ID
	 * @param userID
	 * @throws Exception
	 */
	public void deletetUser(int userID) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		userDAO.deletetUser(userID);
	}

	/**
	 * Get the subscriptions' list of a given user id
	 * @param id
	 * @return The complete list of Subscriptions in ArrayList<Integer> type
	 * @throws Exception
	 */
	public ArrayList<Integer> getSubscriptionsList(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<Integer> usersList =  userDAO.getSubscriptions(id);
		return usersList;	
	}
	
	/**
	 * Subscribes the current user to another given user. 
	 * @param userName of the current user. 
	 * @param subscriptorName of the user to subscribe
	 * @throws Exception
	 */
	public void subscribe(String userName, String subscriptorName) throws Exception{
		int userID = getUser(userName).getUserId();
		int subscriptorID = getUser(subscriptorName).getUserId();
		if(!getSubscriptionsList(userID).contains(subscriptorID)){
			UserDAO userDAO = new UserDAO();
			userDAO.addSubscriptions(userID, subscriptorID);
		}
	}
	
	/**
	 * @param userName
	 * @param subscriptorName
	 * @throws Exception
	 */
	public void unSubscribe(String userName, String subscriptorName) throws Exception{
		int userID = getUser(userName).getUserId();
		int subscriptorID = getUser(subscriptorName).getUserId();
		if(getSubscriptionsList(userID).contains(subscriptorID)){
			UserDAO userDAO = new UserDAO();
			userDAO.deleteSubscription(userID, subscriptorID);
		}
	}
	
	/**
	 * @param userName
	 * @return
	 * @throws Exception
	 */
	public BeanUser getUser(String userName) throws Exception {
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUser(userName);
	}
}
