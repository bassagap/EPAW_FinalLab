package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.sql.*;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import models.BeanTweet;
import service.TweetService;
import service.UserService;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/TweetController")
public class TweetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TweetController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TweetService tweetService = new TweetService(); 
		UserService userService = new UserService(); 
		BeanTweet tweet = new BeanTweet(); 
		
		// Get information
		String hashTag = request.getParameter("hashTag"); 
		String personalized = request.getParameter("clicked"); 
		String description = request.getParameter("description"); 
		String callType = request.getParameter("callType"); 
		String tweet_id_string = request.getParameter("id");
		HttpSession session = request.getSession();
		String session_user = (String) session.getAttribute("user"); 
		Calendar calendar = Calendar.getInstance();
		java.sql.Date date = new java.sql.Date(calendar.getTime().getTime());	
	
		try {
			//Manage tweet acctions: 
			
			if("add".equals(callType) && !session_user.equals("anonymous")){
				tweet.setDescription(description);
				tweet.setHashTag(hashTag); 
				tweet.setUser(session_user);
				tweet.setPublicationDate(date);
				tweet.setUser_id1(userService.getUserID(session_user));
				tweet.setPopularity(tweetService.getTweetPopularity(tweet)); 
				if(userService.isPublicUser(session_user)){
					tweet.setVisibility("public");
				} else {
					tweet.setVisibility("private");
				}
				tweetService.insertTweet(tweet);
				tweetService.disconectBD();
			}
			if("add".equals(callType) && session_user.equals("anonymous")){
				response.setStatus(400);
			}
			if("edit".equals(callType)){
				tweet.setIdTweet(Integer.parseInt(tweet_id_string));
				tweet.setDescription(request.getParameter("description"));
				tweet.setHashTag(request.getParameter("hashTag"));
				tweet.setUser_id1(userService.getUserID(session_user));
				String tweet_user = tweetService.getTweetUser(tweet.getIdTweet());
				if(session_user.equals(tweet_user) || userService.isAdminUser(session_user)){
					System.out.println("Edit Tweet Controller Edit:");
					tweetService.editTweet(tweet);
					tweetService.disconectBD();
				}else{
					response.setStatus(400);
				}
			}
			if("delete".equals(callType)){
				int idTweet = Integer.parseInt(tweet_id_string);
				String tweet_user = tweetService.getTweetUser(idTweet);
				if(session_user.equals(tweet_user) || userService.isAdminUser(session_user)){
					tweetService.deleteTweet(idTweet);
					tweetService.disconectBD();
				}else{
					response.setStatus(400);
				}
			}
			if("retweet".equals(callType)){
				System.out.println("Edit Tweet Controller Retweet:" + tweet_id_string );
				int idTweet = Integer.parseInt(tweet_id_string);
				tweetService.retweet(userService.getUserID(session_user), idTweet, date); 
				tweetService.disconectBD();
			}
			if("verify".equals(callType)){
				int idTweet = Integer.parseInt(tweet_id_string);
				if(session_user.equals(tweetService.getTweetUser(idTweet))){
					response.setStatus(200);
				}else{
					response.setStatus(400);
				}	
			}
			if("like".equals(callType)){
				int idTweet = Integer.parseInt(tweet_id_string);
				int userID = userService.getUserID(session_user); 
				if(tweetService.userHasLiked(idTweet, userID)){
					tweetService.deleteLike(userID, idTweet);
					tweet = tweetService.getTweet(idTweet);
					tweet.setLikes(tweetService.countTweetLikes(idTweet));
					tweetService.updateLike(tweet);	
					tweetService.disconectBD();
					
				} else if(!tweetService.userHasLiked(idTweet, userID)){
					tweet = tweetService.getTweet(idTweet);
					tweetService.addLike(userID, idTweet);
					tweet.setLikes(tweetService.countTweetLikes(idTweet));
					tweetService.updateLike(tweet);
					tweetService.disconectBD();
				}
			}
			ArrayList<BeanTweet> tweetList = tweetService.getTweetsList(session_user, personalized);
		    String json = new Gson().toJson(tweetList);
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
		    tweetService.disconectBD();


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
