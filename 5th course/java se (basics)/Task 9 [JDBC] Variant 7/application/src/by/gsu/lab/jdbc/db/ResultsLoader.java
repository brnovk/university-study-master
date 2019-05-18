package by.gsu.lab.jdbc.db;

import java.sql.*;

public class ResultsLoader {

	final int RESPONSE_INDEX_DATE = 1;
	final int RESPONSE_INDEX_TEMP = 2;
	final int RESPONSE_INDEX_RAINFALL = 3;
	final String OUT_DELIMETER = "\t| ";

	/**
	 * Вспомогательный метод формирования строкового представления таблицы для
	 * заданий 1, 2 и 3.
	 */
	private String draftingTableWeather(ResultSet resultSet) throws SQLException {
		StringBuilder builder = new StringBuilder();
		while (resultSet.next()) {
			builder.append(resultSet.getDate(RESPONSE_INDEX_DATE));
			builder.append(OUT_DELIMETER);
			builder.append(resultSet.getInt(RESPONSE_INDEX_TEMP));
			builder.append(OUT_DELIMETER);
			builder.append(resultSet.getString(RESPONSE_INDEX_RAINFALL));
			builder.append(System.lineSeparator());
		}
		return builder.toString();
	}

	/**
	 * (Task 1)
	 * Метод получения строки, содержащей сведения о погоде в заданном регионе.
	 * Строка отформатирована для вывода на консоль или в logger.
	 * @param region Регион.
	 */
	public String getWeatherRegion(Connection connection, String region)
			throws SQLException {
		final int REQUEST_INDEX_REGION = 1;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK1_SELECT_WEATHER_IN_REGION);
			preparedStatement.setString(REQUEST_INDEX_REGION, region);
			resultSet = preparedStatement.executeQuery();
			return draftingTableWeather(resultSet);
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * (Task 2)
	 * Метод получения строки, содержащей даты, когда в заданном регионе шел снег 
	 * и температура была ниже заданной отрицательной.
	 * Строка отформатирована для вывода на консоль или в logger.
	 * @param region Регион.
	 * @param temperature Температура.
	 */
	public String getDateSnowRegion(Connection connection, String region, 
			int temperature) throws SQLException {
		final int REQUEST_INDEX_REGION = 1;
		final int REQUEST_INDEX_TEMPERATURE = 2;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK2_SELECT_DATE_WITH_SNOW_IN_REGION);
			preparedStatement.setString(REQUEST_INDEX_REGION, region);
			preparedStatement.setInt(REQUEST_INDEX_TEMPERATURE, temperature);
			resultSet = preparedStatement.executeQuery();
			return draftingTableWeather(resultSet);
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * (Task 3)
	 * Метод получения строки, содержащей информацию о погоде за прошедшую неделю 
	 * в регионах, жители которых общаются на заданном языке.
	 * Строка отформатирована для вывода на консоль или в logger.
	 * @param language Язык.
	 */
	public String getWeatherLastWeekByLang(Connection connection, String language)
			throws SQLException {
		final int REQUEST_INDEX_LANGUAGE = 1;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK3_SELECT_WEATHER_LAST_WEEK_BY_LANG);
			preparedStatement.setString(REQUEST_INDEX_LANGUAGE, language);
			resultSet = preparedStatement.executeQuery();
			return draftingTableWeather(resultSet);
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * (Task 4)
	 * Метод получения строки, содержащей среднюю температуру за
	 * прошедшую неделю в регионах с площадью больше заданной.
	 * Строка отформатирована для вывода на консоль или в logger.
	 * @param area Площадь региона.
	 */
	public double getAvgTempRegion(Connection connection, int area)
			throws SQLException {
		final int REQUEST_INDEX_AREA = 1;
		final int RESPONSE_INDEX_AVG = 1;
		final double EMPTY_VALUE = 0D;

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK4_SELECT_AVG_TEMP_IN_REGION);
			preparedStatement.setInt(REQUEST_INDEX_AREA, area);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				return resultSet.getDouble(RESPONSE_INDEX_AVG);
			}
			return EMPTY_VALUE;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}
}
