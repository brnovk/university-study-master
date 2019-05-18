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
public class InsertSatelliteController extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			String satelliteName = request.getParameter("satelliteName");
			String satelliteRadius = request.getParameter("satelliteRadius");
			String satelliteDistanceToPlanet = 
				request.getParameter("satelliteDistanceToPlanet");
			String satellitePlanetName = request.getParameter("satellitePlanetName");
			stringValidation(satelliteName, satelliteRadius, satelliteDistanceToPlanet);
			intValidation("Fields radius and distances - are integers.", satelliteRadius,
				satelliteDistanceToPlanet);
			doInsertSatellite(satelliteName, satelliteRadius, satelliteDistanceToPlanet,
				satellitePlanetName);
			jump("/ViewDataController", request, response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}

	private void doInsertSatellite(String name, String rawRadius, String rawDistanceToPlanet,
			String rawPlanetName) throws SQLException, ClassNotFoundException {
		Connection connection = null;
		try {
			connection = ConnectionControl.getConnection();
			int radius = Integer.parseInt(rawRadius);
			int distanceToPlanet = Integer.parseInt(rawDistanceToPlanet);
			String planetName = null;
			if ((rawPlanetName != null) && !"".equals(rawPlanetName.trim())) {
				planetName = rawPlanetName.trim();
			}
			new DBDataSetter().insertSatellite(connection, name.trim(), radius, 
				distanceToPlanet, planetName);
		} finally {
			ConnectionControl.close();
		}
	}
}
