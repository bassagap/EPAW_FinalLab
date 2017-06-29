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
		HttpSession session = request.getSession();
		String callType = request.getParameter("callType");
		String userName = request.getParameter("userName");
		String subscriptionName = request.getParameter("subscriptionName");
		String sessionName = (String) session.getAttribute("user");
		
		try {
			BeanUser user = userService.getUser(sessionName);
			ArrayList<BeanUser> usersList = new ArrayList<BeanUser>();
			if("deleteUser".equals(callType) && (userName.equals(user.getUserName()) || "admin".equals(user.getUserType()))){
				int userID = userService.getUser(sessionName).getUserId();
				userService.deletetUser(userID);
				userService.disconectBD();
			}
			System.out.println("navigateAdmin" + "navigateAdmin".equals(callType));
			if("navigateAdmin".equals(callType)){
				System.out.println("navigateAdmin");
				user = userService.getUser(userName);			
			}
			else if(callType.equals("navigateFromTweet")){		
				if(userName.equals(sessionName)){
					 user = userService.getUser(sessionName);
				}else{
					 user = userService.getUser(userName);
				}
			}
			else if(callType.equals("changeConfig") && (sessionName.equals(userName) || "admin".equals(userService.getUser(sessionName).getUserType()))){				
				
				String mail= request.getParameter("mail");
				userService.setMail(user.getUserId(), mail);

				String privacy= request.getParameter("privacy");
				if(privacy.equals("true")){
					userService.setVisibility(user.getUserId(),"private");
				}
				else	userService.setVisibility(user.getUserId(),"public");	
				
				userService.disconectBD();
			}

			if(userService.userExistsByName(userName)){
					if(callType.equals("addSubscriptions"))
						userService.subscribe(userName, subscriptionName);
					else if(callType.equals("deleteSubscription"))
						userService.unSubscribe(userName, subscriptionName);
					//All users
					if(callType.equals("addSubscriptionsAll")){
						subscriptionName = userService.getUserName(Integer.parseInt(subscriptionName));
						userService.subscribe(userName, subscriptionName);
					}
					else if(callType.equals("deleteSubscriptionAll")){
						subscriptionName = userService.getUserName(Integer.parseInt(subscriptionName));
						userService.unSubscribe(userName, subscriptionName);
					}
			}
			if(userService.userExistsByName(subscriptionName)){
				if(callType.equals("addSubscription"))
					userService.subscribe(userName, subscriptionName);
				else if(callType.equals("deleteSubscription"))
					userService.unSubscribe(userName, subscriptionName);
			}
			
			
			usersList =  userService.getUsersList(user.getUserId());
			String json = new Gson().toJson(usersList);
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
		    userService.disconectBD();

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
