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
		String hashTag = request.getParameter("hashTag"); 
		String description = request.getParameter("description"); 
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("user"); 
		Calendar calendar = Calendar.getInstance();
		java.sql.Date date = new java.sql.Date(calendar.getTime().getTime());	
		String id_string = request.getParameter("id");	
		BeanTweet tweet = new BeanTweet(); 	
		try {
			if(hashTag != null && !user.equals("anonymous")){
				tweet.setDescription(description);
				tweet.setHashTag(hashTag); 
				tweet.setUser(user);
				tweet.setPublicationDate(date);
				System.out.println("User internal ID: " + userService.getUserID(user));
				tweet.setUser_id1(userService.getUserID(user));
				System.out.println("User internal ID: " + tweet.getUser_id1());
				if(userService.isPublicUser(user)){
					tweet.setVisibility("public");
				} else {
					tweet.setVisibility("private");
				}
				tweetService.insertTweet(tweet);
			}
			if(hashTag != null && user.equals("anonymous")){
				response.setStatus(400);
			}
			ArrayList<BeanTweet> tweetList = tweetService.getTweetsList(user);

		    String json = new Gson().toJson(tweetList);
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);


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
