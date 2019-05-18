package by.gsu.lab.jdbc.db;

import java.sql.*;
import java.util.Formatter;

/**
 * Класс с методами выполнения запросов, согласно заданиям.
 * 
 * @author Victor Baranov
 */
public class ResultsLoader {

	final int RESPONSE_INDEX_ID = 1;
	final int RESPONSE_INDEX_X = 2;
	final int RESPONSE_INDEX_Y = 3;

	/**
	 * Метод нахождения ближашей или самой удалённой точки в задании 1 и 2.
	 * @throws SQLException
	 */
	private String mostNearOrFarPoint(Connection connection, int x, int y,
			String query) throws SQLException {

		final int REQUEST_INDEX_X = 1;
		final int REQUEST_INDEX_Y = 2;
		final int RESPONSE_INDEX_DISTANCE = 4;
		final String FORMAT_PATTERN_INT = "  %s: %d%s";
		final String FORMAT_PATTERN_FLOAT = "  %s: %f%s";
		final String HELP_OUT_ID = "ID записи";
		final String HELP_OUT_X = "X";
		final String HELP_OUT_Y = "Y";
		final String HELP_OUT_DISTANCE = "Расстояние";
		final String EMPTY_STRING = "";

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Formatter formatter = null;
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(REQUEST_INDEX_X, x);
			preparedStatement.setInt(REQUEST_INDEX_Y, y);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				formatter = new Formatter();
				formatter.format(FORMAT_PATTERN_INT, HELP_OUT_ID,
					resultSet.getInt(RESPONSE_INDEX_ID), System.lineSeparator());
				formatter.format(FORMAT_PATTERN_INT, HELP_OUT_X,
					resultSet.getInt(RESPONSE_INDEX_X), System.lineSeparator());
				formatter.format(FORMAT_PATTERN_INT, HELP_OUT_Y,
					resultSet.getInt(RESPONSE_INDEX_Y), System.lineSeparator());
				formatter.format(FORMAT_PATTERN_FLOAT, HELP_OUT_DISTANCE,
					resultSet.getDouble(RESPONSE_INDEX_DISTANCE),
					System.lineSeparator());
				return formatter.toString();
			}
			return EMPTY_STRING;
		} finally {
			formatterClose(formatter);
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}

	/**
	 * Вспомогательный метод для корректного закрытия Formatter'а
	 */
	private void formatterClose(Formatter formatter) {
		if (formatter != null) {
			formatter.close();
		}
	}

	/**
	 * Метод получения строки, содержащей точку множества, наиболее приближённую
	 * к заданной. Строка отформатирована для вывода на консоль или в logger.
	 * 
	 * @return Строку, содержащую id точки в бд, координату по x и y, и
	 *         расстояние до заданной точки.
	 */
	public String getNearPoint(Connection connection, int x, int y)
			throws SQLException {
		return mostNearOrFarPoint(connection, x, y,
			SQLQueries.SUBTASK1_SELECT_NEAR_POINT);
	}

	/**
	 * Метод получения строки, содержащей точку множества, наиболее отдалённую
	 * от заданной. Строка отформатирована для вывода на консоль или в logger.
	 * 
	 * @return Строку, содержащую id точки в бд, координату по x и y, и
	 *         расстояние до заданной точки.
	 */
	public String getFarPoint(Connection connection, int x, int y)
			throws SQLException {
		return mostNearOrFarPoint(connection, x, y,
			SQLQueries.SUBTASK2_SELECT_FAR_POINT);
	}

	/**
	 * Метод получения строки, содержащую точки множества, лежащие на одной
	 * прямой с заданными точками прямой. Строка отформатирована для вывода на
	 * консоль или в logger.
	 */
	public String getInLinePoints(Connection connection, int x1, int y1,
			int x2, int y2) throws SQLException {
		final int REQUEST_INDEX_X1 = 1;
		final int REQUEST_INDEX_Y1 = 2;
		final int REQUEST_INDEX_X2 = 3;
		final int REQUEST_INDEX_Y2 = 4;

		final String LINE_PATTERN = "ID:%4d,\tX:%4d,\t\tY:%4d;%s";

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Formatter formatter = null;
		try {
			preparedStatement = connection.prepareStatement(
				SQLQueries.SUBTASK3_SELECT_POINTS_ON_LINE);
			preparedStatement.setInt(REQUEST_INDEX_X1, x1);
			preparedStatement.setInt(REQUEST_INDEX_Y1, y1);
			preparedStatement.setInt(REQUEST_INDEX_X2, x2);
			preparedStatement.setInt(REQUEST_INDEX_Y2, y2);
			resultSet = preparedStatement.executeQuery();
			formatter = new Formatter();
			while (resultSet.next()) {
				formatter.format(LINE_PATTERN, resultSet.getInt(RESPONSE_INDEX_ID),
					resultSet.getInt(RESPONSE_INDEX_X),
					resultSet.getInt(RESPONSE_INDEX_Y), System.lineSeparator());
			}
			return formatter.toString();
		} finally {
			formatterClose(formatter);
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}
}
