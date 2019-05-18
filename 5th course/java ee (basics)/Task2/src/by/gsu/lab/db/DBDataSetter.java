package by.gsu.lab.db;

import java.sql.*;

public class DBDataSetter {

	public void insertGalaxy(Connection connection, String name) throws SQLException {

		final int INDEX_NAME = 1;
		PreparedStatement psInsertGalaxy = null;
		try {
			psInsertGalaxy = connection.prepareStatement(SQLQueries.PS_INSERT_GALAXY);
			psInsertGalaxy.setString(INDEX_NAME, name);
			psInsertGalaxy.executeUpdate();
		} finally {
			ConnectionControl.close(psInsertGalaxy);
		}
	}

	public void insertPlanet(Connection connection, String planetName, int radius,
			int coreTemperature, boolean existAtmosphere, boolean existLife,
			String galaxiesName) throws SQLException {

		final int INDEX_PLANET_NAME = 1;
		final int INDEX_PLANET_RADIUS = 2;
		final int INDEX_CORE_TEMPERATURE = 3;
		final int INDEX_EXIST_ATMOSPHERE = 4;
		final int INDEX_EXIST_LIFE = 5;
		final int INDEX_GALAXIES_NAME = 6;

		PreparedStatement psInsertPlanet = null;
		try {
			psInsertPlanet = connection.prepareStatement(SQLQueries.PS_INSERT_PLANET);
			psInsertPlanet.setString(INDEX_PLANET_NAME, planetName);
			psInsertPlanet.setInt(INDEX_PLANET_RADIUS, radius);
			psInsertPlanet.setInt(INDEX_CORE_TEMPERATURE, coreTemperature);
			psInsertPlanet.setBoolean(INDEX_EXIST_ATMOSPHERE, existAtmosphere);
			psInsertPlanet.setBoolean(INDEX_EXIST_LIFE, existLife);
			psInsertPlanet.setString(INDEX_GALAXIES_NAME, galaxiesName);
			psInsertPlanet.executeUpdate();
		} finally {
			ConnectionControl.close(psInsertPlanet);
		}
	}

	public void insertSatellite(Connection connection, String satelliteName, int radius,
			int distanceToPlanet, String planetName) throws SQLException {

		final int INDEX_SATELLITE_NAME = 1;
		final int INDEX_SATELLITE_RADIUS = 2;
		final int INDEX_DISTANCE_TO_PLANET = 3;
		final int INDEX_PLANET_NAME = 4;

		PreparedStatement psInsertSatellite = null;
		try {
			psInsertSatellite = connection.prepareStatement(
				SQLQueries.PS_INSERT_SATELLITE);
			psInsertSatellite.setString(INDEX_SATELLITE_NAME, satelliteName);
			psInsertSatellite.setInt(INDEX_SATELLITE_RADIUS, radius);
			psInsertSatellite.setInt(INDEX_DISTANCE_TO_PLANET, distanceToPlanet);
			psInsertSatellite.setString(INDEX_PLANET_NAME, planetName);
			psInsertSatellite.executeUpdate();
		} finally {
			ConnectionControl.close(psInsertSatellite);
		}
	}
}
