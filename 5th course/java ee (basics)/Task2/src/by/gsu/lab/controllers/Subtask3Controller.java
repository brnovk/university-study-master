package by.gsu.lab.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.db.ConnectionControl;
import by.gsu.lab.db.DBDataLoader;

@SuppressWarnings("serial")
public class Subtask3Controller extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection connection = null;
		try {
			connection = ConnectionControl.getConnection();
			DBDataLoader loader = new DBDataLoader();

			List<String> subtask3List = loader.maxCountSatelite(connection);
			request.setAttribute("subtask3List", subtask3List);
			
			jump("/subtask3.jsp", request, response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		} finally {
            ConnectionControl.close();
        }
	}
}
