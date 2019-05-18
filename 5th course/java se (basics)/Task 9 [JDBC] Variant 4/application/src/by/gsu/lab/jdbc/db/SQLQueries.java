package by.gsu.lab.jdbc.db;

public class SQLQueries {

	/**
	 * Выборка сувениров по заданному производителю.
	 */
	public final static String SELECT_SOUVENIRS_BY_MANUFACTURER = 
		"SELECT souvenirs.title, releaseDate, price "
		+ "FROM souvenirs, manufacturer " 
		+ "WHERE souvenirs.idManufacturer = manufacturer.id "
		+ "AND manufacturer.title = ? ;";

	/**
	 * Выборка сувениров, произведённых в заданной стране.
	 */
	public final static String SELECT_SOUVENIRS_BY_COUNTRY =
		"SELECT souvenirs.title, souvenirs.releaseDate, "
		+ "souvenirs.price, manufacturer.title "
		+ "FROM souvenirs, manufacturer "
		+ "WHERE souvenirs.idManufacturer = manufacturer.id "
		+ "AND manufacturer.country = ? ;";

	/**
	 * Выборка производителей, чьи цены на сувениры меньше заданной.
	 */
	public final static String SELECT_MANUFACTURERS_BY_COST = 
		"SELECT DISTINCT manufacturer.title, "
		+ "manufacturer.country, manufacturer.telephone "
		+ "FROM souvenirs, manufacturer "
		+ "WHERE souvenirs.idManufacturer = manufacturer.id "
		+ "AND souvenirs.price <= ? ;";

	/**
	 * Выборка производителей, чьи цены на сувениры меньше заданной.
	 */
	public final static String SELECT_MANUFACTURERS_BY_SOUVENIR_AND_YEAR =
		"SELECT DISTINCT manufacturer.title, "
		+ "manufacturer.country, manufacturer.telephone "
		+ "FROM souvenirs, manufacturer "
		+ "WHERE souvenirs.idManufacturer = manufacturer.id "
		+ "AND souvenirs.title = ? "
		+ "AND YEAR(souvenirs.releaseDate) = YEAR(?) ";

	/**
	 * Удаление производителя и его сувениров.
	 */
	public final static String DELETE_MANUFACTURER_AND_SOUVENIRS =
		"DELETE FROM manufacturer "
		+ "WHERE manufacturer.title = ? ;";
}
