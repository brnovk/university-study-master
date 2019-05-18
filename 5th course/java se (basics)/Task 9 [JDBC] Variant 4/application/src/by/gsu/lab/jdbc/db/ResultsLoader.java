package by.gsu.lab.jdbc.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * Класс с методами выполнения запросов, согласно заданий.
 */
public class ResultsLoader {

	final String DELIMETER = ", ";

	public String souvenirsByManufacturer(Connection connection, 
			String manufacturer) throws SQLException {
		final int REQUEST_INDEX_MANUFACTURER = 1;
		final int RESPONSE_INDEX_SOUVENIR = 1;
		final int RESPONSE_INDEX_DATE = 2;
		final int RESPONSE_INDEX_COST = 3;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SELECT_SOUVENIRS_BY_MANUFACTURER);
			preparedStatement.setString(REQUEST_INDEX_MANUFACTURER, manufacturer);
			resultSet = preparedStatement.executeQuery();
			StringBuilder bulder = new StringBuilder();
			while (resultSet.next()) {
				bulder.append(resultSet.getString(RESPONSE_INDEX_SOUVENIR));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getDate(RESPONSE_INDEX_DATE));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getInt(RESPONSE_INDEX_COST));
				bulder.append(System.lineSeparator());
			}
			return bulder.toString();
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public String souvenirsByCountry(Connection connection, String country)
			throws SQLException {
		final int REQUEST_INDEX_COUNTRY = 1;
		final int RESPONSE_INDEX_SOUVENIR = 1;
		final int RESPONSE_INDEX_DATE = 2;
		final int RESPONSE_INDEX_COST = 3;
		final int RESPONSE_INDEX_MANUFACTURER = 4;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SELECT_SOUVENIRS_BY_COUNTRY);
			preparedStatement.setString(REQUEST_INDEX_COUNTRY, country);
			resultSet = preparedStatement.executeQuery();
			StringBuilder bulder = new StringBuilder();
			while (resultSet.next()) {
				bulder.append(resultSet.getString(RESPONSE_INDEX_SOUVENIR));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getDate(RESPONSE_INDEX_DATE));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getInt(RESPONSE_INDEX_COST));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getString(RESPONSE_INDEX_MANUFACTURER));
				bulder.append(System.lineSeparator());
			}
			return bulder.toString();
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public String manufacturerByCost(Connection connection, int cost)
			throws SQLException {
		final int REQUEST_INDEX_COST = 1;
		final int RESPONSE_INDEX_MANUFACTURER = 1;
		final int RESPONSE_INDEX_COUNTRY = 2;
		final int RESPONSE_INDEX_TELEPHONE = 3;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SELECT_MANUFACTURERS_BY_COST);
			preparedStatement.setInt(REQUEST_INDEX_COST, cost);
			resultSet = preparedStatement.executeQuery();
			StringBuilder bulder = new StringBuilder();
			while (resultSet.next()) {
				bulder.append(resultSet.getString(RESPONSE_INDEX_MANUFACTURER));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getString(RESPONSE_INDEX_COUNTRY));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getString(RESPONSE_INDEX_TELEPHONE));
				bulder.append(System.lineSeparator());
			}
			return bulder.toString();
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public String manufacturerBySouvenirAndYear(Connection connection, 
			String souvenir, Date year) throws SQLException {
		final int REQUEST_INDEX_SOUVENIR = 1;
		final int REQUEST_INDEX_YEAR = 2;
		final int RESPONSE_INDEX_MANUFACTURER = 1;
		final int RESPONSE_INDEX_COUNTRY = 2;
		final int RESPONSE_INDEX_TELEPHONE = 3;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SELECT_MANUFACTURERS_BY_SOUVENIR_AND_YEAR);
			preparedStatement.setString(REQUEST_INDEX_SOUVENIR, souvenir);
			preparedStatement.setDate(REQUEST_INDEX_YEAR, 
				new java.sql.Date(year.getTime()));
			resultSet = preparedStatement.executeQuery();
			StringBuilder bulder = new StringBuilder();
			while (resultSet.next()) {
				bulder.append(resultSet.getString(RESPONSE_INDEX_MANUFACTURER));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getString(RESPONSE_INDEX_COUNTRY));
				bulder.append(DELIMETER);
				bulder.append(resultSet.getString(RESPONSE_INDEX_TELEPHONE));
				bulder.append(System.lineSeparator());
			}
			return bulder.toString();
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	public void deleteManufacturer(Connection connection, String manufacturer)
			throws SQLException {
		final int REQUEST_INDEX_MANUFACTURER = 1;
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.DELETE_MANUFACTURER_AND_SOUVENIRS);
			preparedStatement.setString(REQUEST_INDEX_MANUFACTURER, manufacturer);
			preparedStatement.executeUpdate();
		} finally {
			ConnectionControl.close(preparedStatement);
		}
	}
}
