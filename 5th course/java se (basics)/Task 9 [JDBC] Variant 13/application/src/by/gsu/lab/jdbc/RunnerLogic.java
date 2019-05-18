package by.gsu.lab.jdbc;

import java.sql.*;
import java.util.List;

import by.gsu.lab.jdbc.db.ConnectionControl;
import by.gsu.lab.jdbc.db.ResultsLoader;

/**
 * Класс бизнес-логики приложения:
 * 
 * В БД хранится англо-русский словарь, в котором для одного английского
 * слова может быть указано несколько его значений и наоборот.
 * Со стороны клиента вводятся последовательно английские (русские) слова.
 * Для каждого из них вывести на консоль все русские (английские)
 * значения слова.
 * 
 * @author Victor Baranov
 */
public class RunnerLogic {

	public void doLogic() throws ClassNotFoundException, SQLException {
		final String TRANSLATE_MISSING = "<translation missing>";
		final String FORMAT_LINE = "  %s: %s;\n";
		final String HELP_RUS = "Translation of Russian words in English:";
		final String HELP_ENG = "Translation of English words to Russian:";
		Connection connection;
		try {
			connection = ConnectionControl.getConnection();
			ResultsLoader loader = new ResultsLoader();

			{ // Перевод русских слов на английский
				String[] words = { "нарушение", "балкон", "водород" };
				System.out.println(HELP_RUS);
				for (String word : words) {
					List<String> translated = loader.translate(connection,
						TranslateType.RUS_TO_ENG, word);
					String message = translated.isEmpty() ? TRANSLATE_MISSING : translated.toString();
					System.out.printf(FORMAT_LINE, word, message);
				}
			}
			{ // Перевод английских слов на русский
				String[] words = { "pother", "exciting", "violation" };
				System.out.println(HELP_ENG);
				for (String word : words) {
					List<String> translated = loader.translate(connection,
						TranslateType.ENG_TO_RUS, word);
					String message = translated.isEmpty() ? TRANSLATE_MISSING : translated.toString();
					System.out.printf(FORMAT_LINE, word, message);
				}
			}
		} finally {
			ConnectionControl.close();
		}
	}
}
