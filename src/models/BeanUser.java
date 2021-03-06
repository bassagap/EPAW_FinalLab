package models;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class BeanUser implements Serializable  {

	private static final long serialVersionUID = 1L;
// User property is left!!!
	private String userName = "";
	private String mail = "";
	private String password = ""; 
	private Boolean tc = false; 
	private String gender = ""; 
	private ArrayList<String> sportsList = new ArrayList<String>(); 
	private Integer weight = null; 
	private Date dateOfBirth = new Date(0); 
	private String userType = ""; 
	private String visibility = "private"; 
	private Integer userId = -1; 
	/*  Control which parameters have been correctly filled */
	private int[] error = {0,0}; 
	private Boolean isSubscribed = false; 
	
	
	/* Getters */
	public String getUserName(){
		return userName;
	}
	
	public String getMail() {
		return mail;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	
	public int[] getError() {
		return error;
	}
	/**
	 * @return the weight
	 */
	public Integer getWeight() {
		return weight;
	}

	/**
	 * @return the tc
	 */
	public Boolean getTc() {
		return tc;
	}	

	/**
	 * @return the sportsList
	 */
	public ArrayList<String> getSportsList() {
		return sportsList;
	}
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * @return the userType
	 */
	public String getUserType() {
		return userType;
	}
	
	/**
	 * @return the dateOfBirth
	 */
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	
	/*Setters*/
	public void setUserName(String userName) throws Exception{
		this.userName = userName;
	}
	
	public void setErrorName(){
		this.error[0] = 1; 
	}
	
	/**
	 * @param tc the tc to set
	 */
	public void setTc(Boolean tc) {
		this.tc = tc;
	}
	
	public void setMail(String mail){
		this.mail = mail;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @param sportsList the sportsList to set
	 */
	public void setSportsList(ArrayList<String> sportsList) {
		this.sportsList = sportsList;
	}

	/**
	 * @param weight the weight to set
	 */
	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	/**
	 * @param dateOfBirth the dateOfBirth to set
	 */
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	/**
	 * @param userType the userType to set
	 */
	public void setUserType(String userType) {
		this.userType = userType;
	}

	/**
	 * @return the visibility
	 */
	public String getVisibility() {
		return visibility;
	}

	/**
	 * @param visibility the visibility to set
	 */
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}

	/**
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	/**
	 * @return the isSubscibed
	 */
	public Boolean getIsSubscribed() {
		return isSubscribed;
	}

	/**
	 * @param isSubscibed the isSubscibed to set
	 */
	public void setIsSubscribed(Boolean isSubscibed) {
		this.isSubscribed = isSubscibed;
	}


}