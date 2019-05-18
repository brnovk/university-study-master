package by.gsu.lab.jdbc.db;

import java.sql.*;
import java.util.*;
import by.gsu.lab.jdbc.TranslateType;

/**
 * Класс с методом выполнения запроса
 * @author Victor Baranov
 */
public class ResultsLoader {

	/**
     * Метод перевода слова.
     * @param connection
     * @param translateType Тип перевода {@link TranslateType}
     * @param word Слово для перевода.
     * @return Коллекция слов перевода.
     * @throws java.sql.SQLException 
	 */
	public List<String> translate(Connection connection,
			TranslateType translateType, String word) throws SQLException {

		final int REQUEST_INDEX_WORD = 1;
		final int RESPONSE_INDEX_WORD = 1;

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			switch (translateType) {
			case ENG_TO_RUS:
				preparedStatement = connection.prepareStatement(
					SQLQueries.SELECT_RUS_FROM_ENG);
				break;
			case RUS_TO_ENG:
				preparedStatement = connection.prepareStatement(
					SQLQueries.SELECT_ENG_FROM_RUS);
				break;
			default:
				throw new IllegalStateException(translateType.name());
			}
			preparedStatement.setString(REQUEST_INDEX_WORD, word);
			resultSet = preparedStatement.executeQuery();
			List<String> result = new ArrayList<>();
			while (resultSet.next()) {
				result.add(resultSet.getString(RESPONSE_INDEX_WORD));
			}
			return result;
		} finally {
			ConnectionControl.close(resultSet);
			ConnectionControl.close(preparedStatement);
		}
	}
}
