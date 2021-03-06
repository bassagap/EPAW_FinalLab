package models;

import java.io.Serializable;
import java.sql.Date;


public class BeanTweet implements Serializable{
	private static final long serialVersionUID = 1L;

	private String description = "";
	private String user = "";
	private String hashTag = ""; 
	private String visibility = "private";
	private int idTweet = 0; 
	private int user_id1 = 0;
	private int likes = 0; 
	private int parentTweet = -1; 
	private Date publicationDate = new Date(0); 
	private Boolean isLiked = false; 
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the user
	 */
	public String getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(String user) {
		this.user = user;
	}
	/**
	 * @return the hashTag
	 */
	public String getHashTag() {
		return hashTag;
	}
	/**
	 * @param hashTag the hashTag to set
	 */
	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
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
	 * @return the publicationDate
	 */
	public Date getPublicationDate() {
		return publicationDate;
	}
	/**
	 * @param publicationDate the publicationDate to set
	 */
	public void setPublicationDate(Date publicationDate) {
		this.publicationDate = publicationDate;
	}
	/**
	 * @return the idTweets
	 */
	public int getIdTweet() {
		return idTweet;
	}
	/**
	 * @param idTweets the idTweets to set
	 */
	public void setIdTweet(int idTweet) {
		this.idTweet = idTweet;
	}
	/**
	 * @return the user_id1
	 */
	public int getUser_id1() {
		return user_id1;
	}
	/**
	 * @param user_id1 the user_id1 to set
	 */
	public void setUser_id1(int user_id1) {
		this.user_id1 = user_id1;
	} 
	
	/**
	 * @return the likes
	 */
	public int getLikes() {
		return likes;
	}
	/**
	 * @param likes the likes to set
	 */
	public void setLikes(int likes) {
		this.likes = likes;
	}
	/**
	 * @return the isLiked
	 */
	public Boolean getIsLiked() {
		return isLiked;
	}
	/**
	 * @param isLiked the isLiked to set
	 */
	public void setIsLiked(Boolean isLiked) {
		this.isLiked = isLiked;
	}
	/**
	 * @return the parentTweet
	 */
	public int getParentTweet() {
		return parentTweet;
	}
	/**
	 * @param parentTweet the parentTweet to set
	 */
	public void setParentTweet(int parentTweet) {
		this.parentTweet = parentTweet;
	}
}
