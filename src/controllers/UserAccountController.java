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
		//String sessionName =request.getParameter("sessionId");
		String userName= request.getParameter("userId");
		HttpSession session = request.getSession();
		String callType = request.getParameter("callType");
		String sessionName = (String) session.getAttribute("user");
		try {
			int userId = userService.getUser(userName).getUserId();
			int sessionId = userService.getUser(sessionName).getUserId();
			
			ArrayList<String> resp = new ArrayList<String>();
			if(userId == sessionId || userService.getUser(sessionName).getUserType().equals("admin"))
				resp.add("true");
			else resp.add("false");
			if("deleteUser".equals(callType)){
				int userID = userService.getUser(sessionName).getUserId();
				userService.deletetUser(userID);
			}
			if(callType.equals("enterAccount")){
				String email = userService.getUser(sessionName).getMail();
				
				//Check if session user is anonymous
				if("anonymous".equals(session.getAttribute("user"))){
					resp.add("false");
				}else{
					resp.add("true");
				}
				
				//Personal info
				resp.add(String.valueOf(sessionName));
				
				if("public".equals(userService.getUser(userName).getVisibility()) || userId == sessionId || "admin".equals(userService.getUser(sessionName).getUserType())){
					resp.add(email);
				}
				else resp.add("");
				String json = new Gson().toJson(resp);
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			}
			if(callType.equals("navigate")){
				userName = userService.getUserName(Integer.parseInt(userName));
				String email = userService.getUser(userName).getMail();
				
				//Check if session user is anonymous
				if("anonymous".equals(session.getAttribute("user"))){
					resp.add("false");
				}else{
					resp.add("true");
				}
				
				//Personal info
				resp.add(String.valueOf(userName));
				
				if("public".equals(userService.getUser(userName).getVisibility()) || userId == sessionId || "admin".equals(userService.getUser(sessionName).getUserType())){
					resp.add(email);
				}
				else resp.add("");
				String json = new Gson().toJson(resp);
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(json);
			}
			else if(callType.equals("getFriends")){				
				ArrayList<Integer> SubscriptionsList = userService.getSubscriptionsList(userId);
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
