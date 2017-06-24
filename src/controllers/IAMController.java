package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import models.BeanUser;
import service.UserService;

/**
 * Servlet implementation class IAMController
 */
@WebServlet("/IAMController")
public class IAMController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public IAMController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserService(); 
		BeanUser user = new BeanUser();
		try {	
			String callType = request.getParameter("callType"); 
			if("login".equals(callType)){
				user = userService.getUser(request.getParameter("userName"));
				if (userService.LoginUser(user)) {
					HttpSession session = request.getSession();
					session.setAttribute("user",user.getUserName());
					session.setAttribute("userType",user.getUserType());
				} 
				else if (!userService.LoginUser(user)){
					response.setStatus(400);
				}
			}
			if("register".equals(callType)){
				BeanUtils.populate(user, request.getParameterMap());
				if (!userService.userExists(user)) {
					userService.insertUser(user); 
					HttpSession session = request.getSession();
					session.setAttribute("user",user.getUserName());
					user = new BeanUser();
					request.setAttribute("user",user);
				} else {
					response.setStatus(400);
				}
			}
			if("logout".equals(callType)){
				HttpSession session = request.getSession();
				session.invalidate();	
			}
			if("anonymous".equals(callType)){
				HttpSession session = request.getSession();
				session.setAttribute("user", "anonymous");
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
