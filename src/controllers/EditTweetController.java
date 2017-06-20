package controllers;

import java.io.IOException;
import java.util.ArrayList;

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
 * Servlet implementation class EditTweetController
 */
@WebServlet("/EditTweetController")
public class EditTweetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTweetController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserService(); 
		TweetService tweetService = new TweetService(); 
		BeanTweet tweet = new BeanTweet(); 	
		String tweet_id_string = request.getParameter("id");
		String hashTag = request.getParameter("hashTag");
		String personalized = request.getParameter("clicked"); 
		HttpSession session = request.getSession();
		String session_user = (String) session.getAttribute("user"); 
		System.out.println("Edit controller: " + session_user);
		System.out.println("Edit controller: " + hashTag);
		System.out.println("Edit controller: " + tweet_id_string);
		try {
			if(tweet_id_string != null){
				tweet.setIdTweet(Integer.parseInt(tweet_id_string));
				tweet.setDescription(request.getParameter("description"));
				tweet.setHashTag(request.getParameter("hashTag"));
				tweet.setUser_id1(userService.getUserID(session_user));
				String tweet_user = tweetService.getTweetUser(tweet.getIdTweet());
				ArrayList<Integer> subscriptorsID = userService.getSubscriptors(tweet.getUser_id1());
				
				if(session_user.equals(tweet_user) || userService.isAdminUser(session_user)){
					System.out.println("Edit Tweet Controller Edit:");
					tweetService.editTweet(tweet);
				}else{
					response.setStatus(400);
				}
				ArrayList<BeanTweet> tweetList = tweetService.getTweetsList(session_user, personalized);
			    String json = new Gson().toJson(tweetList);
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			}

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
