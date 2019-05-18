package by.gsu.lab.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionControl {

	private static Connection connection;

	private ConnectionControl() {
	}

	public static Connection getConnection() throws ClassNotFoundException,
			SQLException {
		if ((connection == null) || connection.isClosed()) {
			initializeConnection();
		}
		return connection;
	}

	public static void close() {
		close(connection);
	}

	public static void close(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
	}

	public static void close(Statement... statements) {
		for (Statement currentStatement : statements) {
			try {
				if (currentStatement != null) {
					currentStatement.close();
				}
			} catch (SQLException e) {
				System.err.println(e);
			}
		}
	}

	public static void close(ResultSet... resultSets) {
		for (ResultSet currentResultSet : resultSets) {
			try {
				if (currentResultSet != null) {
					currentResultSet.close();
				}
			} catch (SQLException e) {
				System.err.println(e);
			}
		}
	}

	private static void initializeConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName(DBConstants.DB_CLASS);
		connection = DriverManager.getConnection(DBConstants.DB_URL, 
			DBConstants.DB_LOGIN, DBConstants.DB_PASSWORD);
	}
}
