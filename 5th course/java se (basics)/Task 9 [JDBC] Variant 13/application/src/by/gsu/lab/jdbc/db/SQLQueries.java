package by.gsu.lab.jdbc.db;

public class SQLQueries {

	/**
	 * Выборка русских слов по заданному английскому.
	 */
	public final static String SELECT_RUS_FROM_ENG =
		"SELECT rus_worlds.word "
		+ "FROM rus_worlds, eng_worlds, map "
		+ "WHERE eng_worlds.word = ? AND "
		+ "eng_worlds.id = map.id_eng AND "
		+ "map.id_rus = rus_worlds.id;";

	/**
	 * Выборка английских слов по заданному русскому.
	 */
	public final static String SELECT_ENG_FROM_RUS = 
		"SELECT eng_worlds.word " 
		+ "FROM rus_worlds, eng_worlds, map "
		+ "WHERE rus_worlds.word = ? AND "
		+ "rus_worlds.id = map.id_rus AND "
		+ "map.id_eng = eng_worlds.id;";
}
