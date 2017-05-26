package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import models.BeanUser;
import service.UserService;

/**
 * Servlet implementation class FormController
 */
@WebServlet("/FormController")
public class FormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FormController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BeanUser user = new BeanUser();
		
		try {
		
		   // Fill the bean with the request parmeters
		   BeanUtils.populate(user, request.getParameterMap());
		   UserService userService = new UserService(); 
		   if (!userService.userExists(user)) {
			   userService.insertUser(user); 
			   user = new BeanUser();
			   request.setAttribute("user",user);
			   RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewMenuLogged.jsp");
			   dispatcher.forward(request, response);
		   } else {
			   user.setErrorName();	  
			   request.setAttribute("user",user);
			   RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			   dispatcher.forward(request, response);
		   }
	    } 
		catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
	    } catch (Exception e) {
			e.printStackTrace();
		}
		    
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
