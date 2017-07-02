package service;


import java.util.ArrayList;

import models.BeanUser;
import persistence.UserDAO;

public class UserService {	

	/**
	 * Returns the full users' list
	 * @return The complete Users List in ArrayList<BeanUser> type.
	 * @throws Exception
	 */
	public ArrayList<BeanUser> getUsersList( int userID) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<BeanUser> usersList =  userDAO.getUsersList();
		enrichUserList(usersList, userID);
		return usersList;	
	}
	
	/**
	 * @param user
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	private BeanUser enrichUser (BeanUser user, int userID) throws Exception{
		if(isSubscribed(userID, user.getUserId())){
			 user.setIsSubscribed(true);
		} else {
			user.setIsSubscribed(false);
		}
		return user; 
	}
	
	/**
	 * @param tweetsList
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	private ArrayList<BeanUser> enrichUserList(ArrayList<BeanUser> usersList, int userID) throws Exception{
		for(BeanUser user : usersList){
			enrichUser(user, userID);
		}
		return usersList;
	}
	/**
	 * Check if the user exists in the database
	 * @param user  
	 * @return exists a Boolean true if exists. 
	 * @throws Exception
	 */
	public Boolean userExists (BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		Boolean exists = ! userDAO.isValidUserName(user.getUserName());	
		return exists; 
	}
	/**
	 * @throws Exception
	 */
	public void disconectBD() throws Exception {
		UserDAO userDAO = new UserDAO(); 
		userDAO.disconnectBD();
	}
	/**
	 * Insert a user into the database
	 * @param user to be inserted
	 * @throws Exception
	 */
	public void insertUser(BeanUser user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		userDAO.insertUser(user);
	}
	
	/**
	 * Checks if the user can login 
	 * @param user to check if can be loged or not
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
	 * @param id of the user from which the subscriptions are recovered
	 * @return The complete list of Subscriptions in ArrayList<Integer> type
	 * @throws Exception
	 */
	public ArrayList<Integer> getSubscriptionsList(int id) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<Integer> usersList =  userDAO.getSubscriptions(id);
		return usersList;	
	}
	
	/**
	 * Check if the user is subscribed to other user
	 * @param id of the user
	 * @param id of the possible subscriber
	 * @return True if it's a subscription
	 * @throws Exception
	 */
	public Boolean isSubscribed(int id, int id2) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		ArrayList<Integer> usersList =  userDAO.getSubscriptions(id);
		return usersList.contains(id2);	
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
	 * Erases one of the subscription of one user
	 * @param userName of the user from which a subscription is about to be erased
	 * @param subscriptorName subscription name of the user to which the current user is about to subscribe
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
	 * Get the user object with the given userName
	 * @param userName the user name of the user to be retrieved from the DB
	 * @return user object
	 * @throws Exception
	 */
	public BeanUser getUser(String userName) throws Exception {
		UserDAO userDAO = new UserDAO(); 
		return userDAO.getUser(userName);
	}
	/**
	 * Set the mail of the user. 
	 * @param user ID of the current user. 
	 * @param new mail.
	 * @throws Exception
	 */
	public void setMail(int id, String mail) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		userDAO.setMail(id, mail);
	}
	/**
	 * Set the visibility of the user. 
	 * @param user ID of the current user. 
	 * @param visibility.
	 * @throws Exception
	 */
	public void setVisibility(int userId, String visibility) throws Exception{
		UserDAO userDAO = new UserDAO();
		userDAO.setVisibility(userId, visibility);
	}
	/**
	 * Check if the user exists in the database
	 * @param a User name
	 * @return a Boolean true if exists. 
	 * @throws Exception
	 */
	public Boolean userExistsByName (String user) throws Exception{
		UserDAO userDAO = new UserDAO(); 
		return !userDAO.isValidUserName(user); 
	}
}
