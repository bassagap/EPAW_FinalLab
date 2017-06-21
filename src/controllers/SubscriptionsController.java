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
import service.UserService;

/**
 * Servlet implementation class UserAccountController
 */
@WebServlet("/SubscriptionsController")
public class SubscriptionsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubscriptionsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserService(); 
		String user =request.getParameter("id");
		System.out.println("User: "+user);
		//id =Integer.parseInt(request.getParameter("id"));

		try {
			int userId = userService.getUserID(user);
			String userName = userService.getUserName(userId);
			
			ArrayList<Integer> SubscriptionsList = userService.getSubscriptionsList(userId);
			ArrayList<String> resp = new ArrayList<String>();
			
			for (int id: SubscriptionsList){
				resp.add(userService.getUserName(id));
				System.out.println(userService.getUserName(id));
			}
			
			String json = new Gson().toJson(resp);
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
