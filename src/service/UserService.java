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
}
