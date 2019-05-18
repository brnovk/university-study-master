package by.gsu.lab.controllers;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import by.gsu.lab.db.*;

@SuppressWarnings("serial")
public class InsertGalaxyController extends AbstractBaseController {
 
	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			String galaxy = request.getParameter("galaxyName");
			stringValidation(galaxy); 
			doInsertGalaxy(galaxy);
			jump("/ViewDataController", request, response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}

	private void doInsertGalaxy(String galaxy) 
			throws SQLException, ClassNotFoundException {
		Connection connection = null;
		try {
			connection = ConnectionControl.getConnection();
	    	new DBDataSetter().insertGalaxy(connection, galaxy.trim());
		} finally {
            ConnectionControl.close();
        }
	}
}
