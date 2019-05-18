package by.gsu.lab.jdbc;

import java.sql.*;
import java.util.Calendar;

import by.gsu.lab.jdbc.db.ConnectionControl;
import by.gsu.lab.jdbc.db.ResultsLoader;

/**
 * Класс бизнес-логики приложения.
 *
 * Tasks: 
 * 1.Вывести информацию о сувенирах заданного производителя.
 * 2.Вывести информацию о сувенирах, произведенных в заданной стране.
 * 3.Вывести информацию о производителях, чьи цены на сувениры меньше заданной.
 * 4.Вывести информацию о производителях заданного сувенира, произведенного 
 *   в заданном году.
 * 5.Удалить заданного производителя и его сувениры.
 * 
 * @author Victor Baranov
 */
public class RunnerLogic {

	public void doLogic() throws ClassNotFoundException, SQLException {

		final String SOUVENIRS_MISSING = "Сувениры отсутствуют.";
		final String MANUFACTURERS_MISSING = "Производители отсутствуют.";

		final String HINT_TASK1 = "1.Сувениры производителя \'%s\':\n";
		final String HINT_TASK2 = "2.Сувениры из страны \'%s\':\n";
		final String HINT_TASK3 = 
			"3.Производители с ценой на сувениры меньше %d:\n";
		final String HINT_TASK4 = 
			"4.Производители сувенира \'%s\',произведённого в \'%s\'г:\n";
		final String HINT_TASK5 = 
			"5.Удаление производителя \'%s\' и всех его сувениров.\n";

		Connection connection;
		try {
			connection = ConnectionControl.getConnection();
			ResultsLoader loader = new ResultsLoader();

			{ // Task 1
				String manufacturer = "OAO \"Сувениры в Москве\"";
				System.out.printf(HINT_TASK1, manufacturer);
				String information = loader.souvenirsByManufacturer(connection,
					manufacturer);
				String message = "".equals(information) ? SOUVENIRS_MISSING : information;
				System.out.println(message);
			}
			{ // Task 2
				String country = "Россия";
				System.out.printf(HINT_TASK2, country);
				String information = loader.souvenirsByCountry(connection, country);
				String message = "".equals(information) ? SOUVENIRS_MISSING : information;
				System.out.println(message);
			}
			{ // Task 3
				int cost = 45;
				System.out.printf(HINT_TASK3, cost);
				String information = loader.manufacturerByCost(connection, cost);
				String message = "".equals(information) ? MANUFACTURERS_MISSING : information;
				System.out.println(message);
			}
			{ // Task 4
				String souvenir = "Матрёшка \"Пучеглазый лемур\"";
				int rawDate = 2014;
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.YEAR, rawDate);
				System.out.printf(HINT_TASK4, souvenir, calendar.get(Calendar.YEAR));
				String information = loader.manufacturerBySouvenirAndYear(connection,
					souvenir, calendar.getTime());
				String message = "".equals(information) ? MANUFACTURERS_MISSING : information;
				System.out.println(message);
			}
			{ // Task 5
				String manufacturer = "OAO \"Воспоминания о Риге\"";
				System.out.printf(HINT_TASK5, manufacturer);
				loader.deleteManufacturer(connection, manufacturer);
			}
		} finally {
			ConnectionControl.close();
		}
	}
}
