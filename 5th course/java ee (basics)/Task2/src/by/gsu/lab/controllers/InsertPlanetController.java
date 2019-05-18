package by.gsu.lab.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.db.ConnectionControl;
import by.gsu.lab.db.DBDataSetter;

@SuppressWarnings("serial")
public class InsertPlanetController extends AbstractBaseController {
	 
	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			String planetName = request.getParameter("planetName");
			String planetRadius = request.getParameter("planetRadius");
			String planetCoreTemperature = request.getParameter("planetCoreTemperature");
			String planetExistAtmosphere = request.getParameter("planetExistAtmosphere");
			String planetExistLife = request.getParameter("planetExistLife");
			String planetGalaxyName = request.getParameter("planetGalaxyName");
			stringValidation(planetName, planetRadius, planetCoreTemperature, 
				planetExistAtmosphere, planetExistLife);
			intValidation("Fields temperature and radius - are integers.",
					planetRadius, planetCoreTemperature);
			doInsertPlanet(planetName, planetRadius, planetCoreTemperature,
					planetExistAtmosphere, planetExistLife, planetGalaxyName);
			jump("/ViewDataController", request, response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}
	
	private void doInsertPlanet(String name, String rawRadius, String rawCoreTemperature,
			String rawExistAtmosphere, String rawExistLife, String rawGalaxyName) 
			throws SQLException, ClassNotFoundException {
		Connection connection = null;
		try {
			connection = ConnectionControl.getConnection();
			int radius = Integer.parseInt(rawRadius);
			int coreTemperature = Integer.parseInt(rawCoreTemperature);
			boolean existAtmosphere = Boolean.parseBoolean(rawExistAtmosphere);
			boolean existLife = Boolean.parseBoolean(rawExistLife);
			String galaxyName = null;
			if ((rawGalaxyName != null) && !"".equals(rawGalaxyName.trim())) {
				galaxyName = rawGalaxyName.trim();
			}
			new DBDataSetter().insertPlanet(connection, name.trim(), radius, coreTemperature, 
					existAtmosphere, existLife, galaxyName);
		} finally {
	        ConnectionControl.close();
	    }
	}
}
