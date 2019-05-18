package by.gsu.lab.jdbc.db;

public class SQLQueries {

	/**
	 * Сведения о погоде в заданном регионе.
	 */
	public final static String SUBTASK1_SELECT_WEATHER_IN_REGION = 
		"SELECT weather.`date`, weather.temperature, rainfall.type "
		+ "FROM weather, regions, rainfall "
		+ "WHERE weather.idRegion = regions.id AND "
		+ "regions.name = ? AND weather.IdRainfall = rainfall.id;";

	/**
	 * Даты, когда в заданном регионе шел снег и температура ниже заданной.
	 */
	public final static String SUBTASK2_SELECT_DATE_WITH_SNOW_IN_REGION =
		"SELECT weather.`date`, weather.temperature, rainfall.type "
		+ "FROM weather, regions, rainfall "
		+ "WHERE weather.idRegion = regions.id AND "
		+ "weather.IdRainfall = rainfall.id AND "
		+ "regions.name = ? AND "
		+ "weather.temperature < ? AND rainfall.type = "
		+ "(SELECT rainfall.type FROM rainfall WHERE rainfall.type = 'Снег');";

	/**
	 * Информация о погоде за прошедшую неделю в регионах, жители которых
	 * общаются на заданном языке.
	 */
	public final static String SUBTASK3_SELECT_WEATHER_LAST_WEEK_BY_LANG =
		"SELECT `weather`.`date`, `weather`.temperature, "
		+ "rainfall.type, regions.name "
		+ "FROM weather, regions, rainfall, population, language "
		+ "WHERE weather.idRegion = regions.id AND "
		+ "weather.IdRainfall = rainfall.id AND "
		+ "regions.idPopulation = population.id AND "
		+ "population.idLanguage = language.id AND "
		+ "language.title = ? AND date >= "
		+ "(CURDATE()-INTERVAL 1 WEEK - INTERVAL "
		+ "WEEKDAY(CURDATE() - INTERVAL 1 WEEK)DAY) AND "
		+ "date <= (CURDATE() - INTERVAL "
		+ "WEEKDAY(CURDATE())DAY - INTERVAL 1 DAY) "
		+ "ORDER BY weather.`date`; ";

	/**
	 * Средняя температура за прошедшую неделю в регионах с площадью больше
	 * заданной.
	 */
	public final static String SUBTASK4_SELECT_AVG_TEMP_IN_REGION =
		"SELECT AVG(weather.temperature) FROM weather, regions "
		+ "WHERE weather.idRegion = regions.id AND "
		+ "regions.area > ? AND date >= (CURDATE()-INTERVAL 1 WEEK - "
		+ "INTERVAL WEEKDAY(CURDATE() - INTERVAL 1 WEEK)DAY) AND "
		+ "date <= (CURDATE() - INTERVAL WEEKDAY(CURDATE())DAY - "
		+ "INTERVAL 1 DAY);";
}
