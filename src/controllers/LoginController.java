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
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		BeanUser user = new BeanUser();
	    try {
			
	    	BeanUtils.populate(user, request.getParameterMap());
	    	UserService userService = new UserService(); 
	    	
	    	try {
				if (userService.LoginUser(user)) {
					HttpSession session = request.getSession();
					session.setAttribute("user",user.getUserName());
					session.setAttribute("userType",user.getUserType());
					System.out.println("Login user Typ is:" + user.getUserType());
					RequestDispatcher dispatcher = request.getRequestDispatcher("views/ViewMenuLogged.jsp");
				    dispatcher.forward(request, response);
				} 
				if(request.getParameter("userType") != null && request.getParameter("userType").equals("anonymous")){
					HttpSession session = request.getSession();
					session.setAttribute("user", "anonymous");
					System.out.println("Login user Type is:" + "anonymous");
					System.out.println("anonymous user");
					RequestDispatcher dispatcher = request.getRequestDispatcher("views/ViewMenuLogged.jsp");
				    dispatcher.forward(request, response);
				}
				else if (!userService.LoginUser(user)){
					user.setErrorName();
					request.setAttribute("user", user);
					System.out.println("wronguser");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/index.jsp");				    
				    dispatcher.forward(request, response);
					
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
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
