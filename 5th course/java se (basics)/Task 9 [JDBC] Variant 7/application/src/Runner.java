import java.sql.SQLException;
import by.gsu.lab.jdbc.RunnerLogic;

public class Runner {

	public static void main(String[] args) {
        try {
            new RunnerLogic().doLogic();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println(ex);
        }
	}
}
