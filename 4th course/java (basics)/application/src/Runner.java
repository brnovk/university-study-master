import by.gsu.oop.RunnerLogic;

import java.io.IOException;
import java.sql.SQLException;

/**
 * @author Baranov Viktor
 */
public class Runner {

	public static void main(String[] args) {
		
		try {
			new RunnerLogic().run();
		} catch (IOException | SQLException | ClassNotFoundException e) {
			System.err.println(e);
		}
	}
}
