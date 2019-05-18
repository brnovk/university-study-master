package by.gsu.lab.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import by.gsu.lab.jdbc.db.ConnectionControl;
import by.gsu.lab.jdbc.db.ResultsLoader;

/**
 * Класс бизнес-логики приложения.
 * 
 * Tasks:
 * 1. Вывести сведения о погоде в заданном регионе.
 * 2. Вывести даты, когда в заданном регионе шел снег и температура была 
 * ниже заданной отрицательной.
 * 3. Вывести информацию о погоде за прошедшую неделю в регионах, жители
 * которых общаются на заданном языке.
 * 4. Вывести среднюю температуру за прошедшую неделю в регионах с 
 * площадью больше заданной.
 * 
 * @author Victor Baranov
 */
public class RunnerLogic {

	final String HELP_TASK1 = "1. Сведения о погоде в регионе \"%s\":"
		+ System.lineSeparator() + "%s" + System.lineSeparator();

	final String HELP_TASK2 = "2. Даты, когда в регионе \"%s\" шел снег и "
		+ "температура была ниже %d градуса(ов):" + System.lineSeparator()
		+ "%s" + System.lineSeparator();

	final String HELP_TASK3 = "3. Погоде за прошедшую неделю в регионах, "
		+ "жители которых общаются на языке \"%s\": "
		+ System.lineSeparator() + "%s" + System.lineSeparator();

	final String HELP_TASK4 = "4. Средняя температура за прошедшую неделю "
		+ "в регионах с площадью больше %d кв.км: " + System.lineSeparator();

	public void doLogic() throws ClassNotFoundException, SQLException {

		Connection connection;
		try {
			connection = ConnectionControl.getConnection();
			ResultsLoader loader = new ResultsLoader();

			// Subtask 1
			final String TASK1_REGION = "Великобритания";
			String resultTask1 = loader.getWeatherRegion(connection, TASK1_REGION);
			System.out.printf(HELP_TASK1, TASK1_REGION, resultTask1);

			// Subtask 2
			final String TASK2_REGION = "Австрия";
			final int TASK2_TEMP = -1;
			String resultTask2 = loader.getDateSnowRegion(connection, TASK2_REGION,
				TASK2_TEMP);
			System.out.printf(HELP_TASK2, TASK2_REGION, TASK2_TEMP, resultTask2);

			// Subtask 3
			final String TASK3_LANG = "Английский";
			String resultTask3 = loader.getWeatherLastWeekByLang(connection,
				TASK3_LANG);
			System.out.printf(HELP_TASK3, TASK3_LANG, resultTask3);

			// Subtask 4
			final int TASK4_AREA = 10_000;
			double resultTask4 = loader.getAvgTempRegion(connection, TASK4_AREA);
			System.out.printf(HELP_TASK4, TASK4_AREA);
			System.out.println(resultTask4);

		} finally {
			ConnectionControl.close();
		}
	}
}
