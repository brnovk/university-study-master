package by.gsu.oop.db;

import by.gsu.oop.Constants;

import java.sql.*;

/**
 * @author Baranov Viktor
 */
public class DBControl {

    private static Connection connection;

    private DBControl() {
    }

    public static Connection getConnection() 
            throws ClassNotFoundException, SQLException {
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

    private static void initializeConnection() 
            throws ClassNotFoundException, SQLException {
        Class.forName(Constants.DB_CLASS);
        connection = DriverManager.getConnection(
            Constants.DB_URL, 
            Constants.DB_LOGIN, 
            Constants.DB_PASSWORD);
    }
}
