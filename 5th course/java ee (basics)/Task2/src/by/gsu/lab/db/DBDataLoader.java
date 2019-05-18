package by.gsu.lab.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Class with methods to perform queries, according to tasks.
 */
public class DBDataLoader {

	/**
	 * Method of finding information on all planets where there is life, and
	 * their satellites in a given galaxy.
	 */
	public List<List<String>> planetsWithLife(Connection connection,
			String galaxy) throws SQLException {

		final int REQUEST_INDEX_GALAXY = 1;
		final int RESPONSE_INDEX_PLANET_NAME = 1;
		final int RESPONSE_INDEX_PLANETS_RADIUS = 2;
		final int RESPONSE_INDEX_PLANETS_CORE_TEMPERATURE = 3;
		final int RESPONSE_INDEX_PLANETS_ATMOSPHERE = 4;
		final int RESPONSE_INDEX_SATELLITES_NAME = 5;
		final int RESPONSE_INDEX_SATELLITES_RADIUS = 6;
		final int RESPONSE_INDEX_DISTANCE_TO_PLANET = 7;

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK1_SELECT_PLANETS_WITH_LIFE);
			preparedStatement.setString(REQUEST_INDEX_GALAXY, galaxy);
			resultSet = preparedStatement.executeQuery();

			List<List<String>> result = new ArrayList<>();
			while (resultSet.next()) {
				List<String> currentLine = new ArrayList<>();

				currentLine.add(resultSet.getString(RESPONSE_INDEX_PLANET_NAME));
				currentLine.add(Integer.toString(resultSet.getInt(RESPONSE_INDEX_PLANETS_RADIUS)));
				currentLine.add(Integer.toString(resultSet.getInt(RESPONSE_INDEX_PLANETS_CORE_TEMPERATURE)));
				currentLine.add(Boolean.toString(resultSet.getBoolean(RESPONSE_INDEX_PLANETS_ATMOSPHERE)));
				currentLine.add(resultSet.getString(RESPONSE_INDEX_SATELLITES_NAME));
				currentLine.add(Integer.toString(resultSet.getInt(RESPONSE_INDEX_SATELLITES_RADIUS)));
				currentLine.add(Integer.toString(resultSet.getInt(RESPONSE_INDEX_DISTANCE_TO_PLANET)));
				result.add(currentLine);
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * Method of finding information on the planet, the galaxy in which it is
	 * located, and satellites, with the maximum number of satellites, but with
	 * the least total volume of these satellites.
	 */
	public List<String> maxCountSatelite(Connection connection) throws SQLException {

		final int INDEX_PLANET_NAME = 1;
		final int INDEX_PLANETS_RADIUS = 2;
		final int INDEX_PLANETS_CORE_TEMPERATURE = 3;
		final int INDEX_PLANETS_ATMOSPHERE = 4;
		final int INDEX_PLANETS_LIFE = 5;
		final int INDEX_GALAXIES_NAME = 6;
		final int INDEX_COUNT_SATELLITES = 7;
		final int INDEX_MIN_SUM_RADIUS_SATELLITES = 8;

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK3_SELECT_MAX_COUNT_SATELITE);
			resultSet = preparedStatement.executeQuery();
			List<String> result = new ArrayList<>();
			if (resultSet.next()) {
				result.add(resultSet.getString(INDEX_PLANET_NAME));
				result.add(Integer.toString(resultSet.getInt(INDEX_PLANETS_RADIUS)));
				result.add(Integer.toString(resultSet.getInt(INDEX_PLANETS_CORE_TEMPERATURE)));
				result.add(Boolean.toString(resultSet.getBoolean(INDEX_PLANETS_ATMOSPHERE)));
				result.add(Boolean.toString(resultSet.getBoolean(INDEX_PLANETS_LIFE)));
				result.add(resultSet.getString(INDEX_GALAXIES_NAME));
				result.add(Integer.toString(resultSet.getInt(INDEX_COUNT_SATELLITES)));
				result.add(Integer.toString(resultSet.getInt(INDEX_MIN_SUM_RADIUS_SATELLITES)));
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * Method of finding information on galaxy, amount of nuclear temperatures
	 * of planets which are the greatest.
	 */
	public List<String> galaxyMaxCoreTemp(Connection connection) throws SQLException {

		final int RESPONSE_INDEX_GALAXIES_NAME = 1;
		final int RESPONSE_INDEX_SUM_CORE_TEMP = 2;

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK4_SELECT_GALAXY_MAX_CORE_TEMP);
			resultSet = preparedStatement.executeQuery();
			List<String> result = null;
			if (resultSet.next()) {
				result = new ArrayList<>();
				result.add(resultSet.getString(RESPONSE_INDEX_GALAXIES_NAME));
				result.add(Integer.toString(resultSet.getInt(RESPONSE_INDEX_SUM_CORE_TEMP)));
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public List<List<String>> getAllCalaxies(Connection connection) throws SQLException {
		final int INDEX_GALAXIES_ID = 1;
		final int INDEX_GALAXIES_NAME = 2;
		List<List<String>> result = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SQLQueries.PS_SELECT_GALAXY);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				List<String> currentList = new ArrayList<>();
				currentList.add(Integer.toString(resultSet.getInt(INDEX_GALAXIES_ID)));
				currentList.add(resultSet.getString(INDEX_GALAXIES_NAME));
				result.add(currentList);
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public List<List<String>> getAllPlanets(Connection connection) throws SQLException {
		final int INDEX_PLANET_ID = 1;
		final int INDEX_PLANET_NAME = 2;
		final int INDEX_PLANET_RADIUS = 3;
		final int INDEX_PLANET_CORE_TEMPERATURE = 4;
		final int INDEX_PLANET_ATMOSPHERE = 5;
		final int INDEX_PLANET_LIFE = 6;
		final int INDEX_PLANET_GALAXIES_NAME = 7;

		List<List<String>> result = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SQLQueries.PS_SELECT_PLANET);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				List<String> currentList = new ArrayList<>();
				currentList.add(Integer.toString(resultSet.getInt(INDEX_PLANET_ID)));
				currentList.add(resultSet.getString(INDEX_PLANET_NAME));
				currentList.add(Integer.toString(resultSet.getInt(INDEX_PLANET_RADIUS)));
				currentList.add(Integer.toString(resultSet.getInt(INDEX_PLANET_CORE_TEMPERATURE)));
				currentList.add(Boolean.toString(resultSet.getBoolean(INDEX_PLANET_ATMOSPHERE)));
				currentList.add(Boolean.toString(resultSet.getBoolean(INDEX_PLANET_LIFE)));
				currentList.add((resultSet.getString(INDEX_PLANET_GALAXIES_NAME) != null)
						? resultSet.getString(INDEX_PLANET_GALAXIES_NAME) : "<Not specified>");
				result.add(currentList);
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public List<List<String>> getAllSatellites(Connection connection) throws SQLException {
		final int INDEX_SATELLITE_ID = 1;
		final int INDEX_SATELLITE_NAME = 2;
		final int INDEX_SATELLITE_RADIUS = 3;
		final int INDEX_SATELLITE_DISTANCE_TO_PLANET = 4;
		final int INDEX_PLANET_NAME = 5;

		List<List<String>> result = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SQLQueries.PS_SELECT_SATELLITE);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				List<String> currentList = new ArrayList<>();
				currentList.add(Integer.toString(resultSet.getInt(INDEX_SATELLITE_ID)));
				currentList.add(resultSet.getString(INDEX_SATELLITE_NAME));
				currentList.add(Integer.toString(resultSet.getInt(INDEX_SATELLITE_RADIUS)));
				currentList.add(Integer.toString(resultSet.getInt(INDEX_SATELLITE_DISTANCE_TO_PLANET)));
				currentList.add((resultSet.getString(INDEX_PLANET_NAME) != null)
						? resultSet.getString(INDEX_PLANET_NAME) : "<Not specified>");
				result.add(currentList);
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public List<String> getIndexHelperCalaxies(Connection connection) throws SQLException {
		final int INDEX_CALAXY_NAME = 1;
		List<String> result = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SQLQueries.PS_HELPER_SELECT_GALAXY);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				result.add(resultSet.getString(INDEX_CALAXY_NAME));
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public List<String> getIndexHelperPlanets(Connection connection) throws SQLException {
		final int INDEX_PLANET_NAME = 1;
		List<String> result = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SQLQueries.PS_HELPER_SELECT_PLANET);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				result.add(resultSet.getString(INDEX_PLANET_NAME));
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}
}
