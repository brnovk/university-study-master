package by.gsu.lab.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import by.gsu.lab.jdbc.db.ConnectionControl;
import by.gsu.lab.jdbc.db.ResultsLoader;

/**
 * Класс бизнес-логики приложения.
 * 
 * Tasks:
 * 1. Вывести точку из множества, наиболее приближенную к заданной.
 * 2. Вывести точку из множества, наиболее удаленную от заданной.
 * 3. Вывести точки из множества,лежащие на одной прямой с заданной прямой.
 * 
 * @author Victor Baranov
 */
public class RunnerLogic {

	final String HELP_TASK1 = "1. Точка, наиболее приближенная к точке " 
		+ "(%d, %d): " + System.lineSeparator() + "%s" + System.lineSeparator();

	final String HELP_TASK2 = "2. Точка, наиболее отдалённая от точки "
		+ "(%d, %d): " + System.lineSeparator() + "%s" + System.lineSeparator();

	final String HELP_TASK3 = "3. Точки, лежащие на одной прямой с прямой "
		+ "(%d, %d)(%d, %d): " + System.lineSeparator()
		+ "%s" + System.lineSeparator();

	public void doLogic() throws ClassNotFoundException, SQLException {

		Connection connection;
		try {
			connection = ConnectionControl.getConnection();
			ResultsLoader loader = new ResultsLoader();

			// Subtask 1
			final int TASK1_X = 1;
			final int TASK1_Y = 10;
			String resultTask1 = loader.getNearPoint(connection, TASK1_X, TASK1_Y);
			System.out.printf(HELP_TASK1, TASK1_X, TASK1_Y, resultTask1);

			// Subtask 2
			final int TASK2_X = -4;
			final int TASK2_Y = 6;
			String resultTask2 = loader.getFarPoint(connection, TASK2_X, TASK2_Y);
			System.out.printf(HELP_TASK2, TASK2_X, TASK2_Y, resultTask2);

			// Subtask 3
			final int TASK3_X1 = 1;
			final int TASK3_Y1 = 0;
			final int TASK3_X2 = 0;
			final int TASK3_Y2 = 1;
			String resultTask3 = loader.getInLinePoints(connection, TASK3_X1,
				TASK3_Y1, TASK3_X2, TASK3_Y2);
			System.out.printf(HELP_TASK3, TASK3_X1, TASK3_Y1, TASK3_X2, TASK3_Y2,
				resultTask3);

		} finally {
			ConnectionControl.close();
		}
	}
}
