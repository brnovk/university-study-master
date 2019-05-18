package by.gsu.oop;

/**
 * @author Baranov Viktor
 */
public class Constants {

	// The source data for the connection to the database.
	
	public final static int DB_PORT = 3306;
	public final static String DB_LOGIN = "root";
	public final static String DB_PASSWORD = "1234";
	public final static String DB_CLASS = "com.mysql.jdbc.Driver";
	public final static String DB_HOST = "localhost";
	public final static String DB_NAME = "stud_db";
	public final static String DB_URL =
		String.format("jdbc:mysql://%s:%d/%s?useUnicode=true&characterEncoding=UTF-8",
		DB_HOST, DB_PORT, DB_NAME);

	// Output formatting of tables.

	public final static String LABEL_STUD = "%1$8s|%2$13s|%3$13s|%4$9s|%5$9s|%6$13s|%7$8s|\n";
	public final static String VALUE_STUD = "%8d|%13s|%13s|%9d|%9d|%13d|%8d|\n";
	public final static int COLUMN_COUNT_STUD = 7;

	public final static String LABEL_MOTHER = "%1$10s|%2$9s|%3$21s|%4$18s|%5$17s|\n";
	public final static String VALUE_MOTHER = "%10d|%9d|%21s|%18s|%17d|\n";
	public final static int COLUMN_COUNT_MOTHER = 5;

	public final static String LABEL_FATHER = "%1$10s|%2$9s|%3$21s|%4$18s|%5$17s|\n";
	public final static String VALUE_FATHER = "%10d|%9d|%21s|%18s|%17d|\n";
	public final static int COLUMN_COUNT_FATHER = 5;

	public final static String LABEL_GROUP = "%1$10s|%2$14s|%3$10s|%4$15s|%5$14s|%6$11s|\n";
	public final static String VALUE_GROUP = "%10d|%14s|%10d|%15d|%14d|%11d|\n";
	public final static int COLUMN_COUNT_GROUP = 6;

	public final static String LABEL_CURATOR = "%1$13s|%2$18s|%3$15s|%4$14s|%5$15s|\n";
	public final static String VALUE_CURATOR = "%13d|%18s|%15s|%14d|%15s|\n";
	public final static int COLUMN_COUNT_CURATOR = 5;

	public final static String LABEL_FACULTET = "%1$16s|%2$34s|%3$27s|\n";
	public final static String VALUE_FACULTET = "%16d|%34s|%27s|\n";
	public final static int COLUMN_COUNT_FACULTET = 3;

	public final static String LABEL_COST = "%1$39s|%2$39s|\n";
	public final static String VALUE_COST = "%39d|%39d|\n";
	public final static int COLUMN_COUNT_COST = 2;

	public final static String LABEL_COMMUNITY = "%1$16s|%2$34s|%3$27s|\n";
	public final static String VALUE_COMMUNITY = "%16d|%34s|%27s|\n";
	public final static int COLUMN_COUNT_COMMUNITY = 3;

	public final static String TABLE_SEPARATOR1 = 
			"________________________________________________________________________________\n";
	public final static String TABLE_SEPARATOR2 = 
			"--------------------------------------------------------------------------------\n";
}
