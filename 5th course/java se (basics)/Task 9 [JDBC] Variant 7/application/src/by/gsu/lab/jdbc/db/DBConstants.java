package by.gsu.lab.jdbc.db;

public class DBConstants {

	// The source data for the connection to the database.

	public final static String DB_CLASS = "com.mysql.jdbc.Driver";
	
	public final static String DB_URL = "jdbc:mysql://localhost:3306/db_weather"
		+ "?useUnicode=true&characterEncoding=UTF-8";

	public final static String DB_LOGIN = "root";
	public final static String DB_PASSWORD = "1234";
}
