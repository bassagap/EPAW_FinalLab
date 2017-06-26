package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.BeanUser;
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
		String subscriptionName =request.getParameter("subscriptionName");
		String callType =request.getParameter("callType");
		String userName =request.getParameter("userName");
		//id =Integer.parseInt(request.getParameter("id"));
		
		try {
			if(userService.userExistsByName(subscriptionName)){
				if(callType.equals("add"))
					userService.subscribe(userName, subscriptionName);
				else if(callType.equals("delete"))
					userService.unSubscribe(userName, subscriptionName);
			}
			
			ArrayList<String> resp = new ArrayList<String>();
			ArrayList<Integer> SubscriptionsList = userService.getSubscriptionsList(userService.getUser(userName).getUserId());
			for (int id: SubscriptionsList){
				resp.add(userService.getUserName(id));
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
