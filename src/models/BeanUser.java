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
	/*  Control which parameters have been correctly filled */
	private int[] error = {0,0}; 
	
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
	 * @return the dateOfBirth
	 */
	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	/**
	 * @param dateOfBirth the dateOfBirth to set
	 */
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}


}