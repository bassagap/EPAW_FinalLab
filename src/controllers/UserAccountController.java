package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import models.BeanTweet;
import models.BeanUser;
import service.UserService;

/**
 * Servlet implementation class UserAccountController
 */
@WebServlet("/UserAccountController")
public class UserAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserAccountController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserService(); 
		String sessionName =request.getParameter("sessionId");
		
		String userIdString = request.getParameter("userId");
		int userId = -1;
		if(userIdString!=null){
			try{
				userId = Integer.parseInt(userIdString);
			}
			catch(NumberFormatException nbe){
				nbe.printStackTrace();				
			}
		}	

		String callType = request.getParameter("callType");

		try {
			//System.out.println(callType);
			int sessionId = userService.getUserID(sessionName);
			String userName = userService.getUserName(userId);
			
			if(callType.equals("enterAccount")){
				String email = userService.getUserEmail(userId);
				
				ArrayList<String> resp = new ArrayList<String>();
				//Check if session user is anonymous
				if(userService.userExistsByName(sessionName))	resp.add("true");
				else	resp.add("false");
				//Personal info
				resp.add(String.valueOf(userName));
				
				if(userService.isPublicUser(userName) || userId == sessionId){
					resp.add(email);
				}
				
				String json = new Gson().toJson(resp);
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			}
			else if(callType.equals("getFriends")){
				
				ArrayList<Integer> SubscriptionsList = userService.getSubscriptionsList(userId);
				ArrayList<String> resp = new ArrayList<String>();
				
				for (int id: SubscriptionsList){
					resp.add(userService.getUserName(id));
				}
				
				String json = new Gson().toJson(resp);
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
