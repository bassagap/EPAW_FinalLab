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

/**
 * Servlet implementation class DeleteTweetsController
 */
@WebServlet("/DeleteTweetsController")
public class DeleteTweetsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTweetsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		TweetService tweetService = new TweetService(); 
		String id_string = request.getParameter("id");
		HttpSession session = request.getSession();
		String session_user = (String) session.getAttribute("user"); 
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			if(id_string != null){
				System.out.println("I am Delete tweet Controller ");
				System.out.println("Test to be deleted: " + id_string);
				int idTweet = Integer.parseInt(id_string);
				String tweet_user = tweetService.getTweetUser(idTweet);
				System.out.println("session_user: " + session_user + " session_user: " + tweet_user);
				if(session_user.equals(tweet_user)){
					tweetService.deleteTweet(idTweet);
				}else{
					response.setStatus(400);
				}
				ArrayList<BeanTweet> tweetList = tweetService.getTweetsList();
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
