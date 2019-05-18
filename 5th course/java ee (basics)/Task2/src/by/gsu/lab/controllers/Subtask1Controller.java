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
public class Subtask1Controller extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection connection = null;

		try {
			request.setCharacterEncoding("UTF-8");
			String galaxy = request.getParameter("searchGalaxyName");
			stringValidation(galaxy);
			
			connection = ConnectionControl.getConnection();
			DBDataLoader loader = new DBDataLoader();
			
			List<List<String>> subtask1ResultList = loader.planetsWithLife(connection, galaxy);
			request.setAttribute("subtask1ResultList", subtask1ResultList);

			jump("/subtask1-result.jsp", request, response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			jumpError("/subtask1-preview.jsp", ex.getMessage(), request, response);
		} finally {
            ConnectionControl.close();
        }
	}
}
