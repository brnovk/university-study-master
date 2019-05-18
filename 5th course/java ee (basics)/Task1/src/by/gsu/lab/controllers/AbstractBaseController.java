package by.gsu.lab.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public abstract class AbstractBaseController extends HttpServlet {

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
        performTask(request, response);
	}
 
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		performTask(request, response);
	}

	abstract protected void performTask(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException;
	
    protected void jumpError(String url, String message, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    protected void jump(String url, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }
    
    protected void stringValidation(String... params) {
		for (String current : params) {
			if (current==null) {
				throw new IllegalArgumentException("Missing query parameter.");
			}
			if ("".equals(current.trim())) {
				throw new IllegalArgumentException("One fields of form is empty.");
			}
		}
	}
    
    protected void doubleValidation(String errorMessage, String... params) {
		for (String current : params) {
			try {
				Double.parseDouble(current);
			} catch (NumberFormatException ex) {
				throw new IllegalArgumentException(errorMessage, ex);
			}
		}
	}
}
