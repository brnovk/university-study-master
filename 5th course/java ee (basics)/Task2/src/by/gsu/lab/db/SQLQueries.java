package by.gsu.lab.db;

public class SQLQueries {

	/**
	 * Query information on all planets where there is life, and their
	 * the satellites in a given galaxy.
	 */
	public final static String SUBTASK1_SELECT_PLANETS_WITH_LIFE =
		"SELECT planets.name, planets.radius, planets.coreTemperature, "
		+ "planets.existAtmosphere, satellites.name, satellites.radius, "
		+ "distanceToPlanet "
		+ "FROM satellites, planets, galaxies "
		+ "WHERE galaxies.name = ? "
		+ "AND galaxies.id = planets.galaxiesId "
		+ "AND planets.existLife = 1 "
		+ "AND satellites.planetsId = planets.id;";

	/**
	 * Query information about the planet, the galaxy in which it resides, and
	 * its satellites having a maximum number of satellites, but with lowest
	 * total volume of these satellites.
	 */
	public final static String SUBTASK3_SELECT_MAX_COUNT_SATELITE =
		"SELECT planets.name, planets.radius, planets.coreTemperature, "
		+ "planets.existAtmosphere, planets.existLife, galaxies.name, "
		+ "COUNT(satellites.planetsId) AS count_satellites, "
		+ "SUM(satellites.radius) AS min_sum_radius_satellites " 
		+ "FROM satellites, planets, galaxies "
		+ "WHERE galaxies.id = planets.galaxiesId " 
		+ "AND planets.id = satellites.planetsId "
		+ "GROUP BY satellites.planetsId " 
		+ "ORDER BY count_satellites DESC, " 
		+ "min_sum_radius_satellites ASC "
		+ "LIMIT 1;";

	/**
	 * Query information about the galaxy, the amount of nuclear temperatures of
	 * the planets which the greatest.
	 */
	public final static String SUBTASK4_SELECT_GALAXY_MAX_CORE_TEMP =
		"SELECT DISTINCT galaxies.name, "
		+ "SUM(planets.coreTemperature) AS sum_core_temp "
		+ "FROM planets, galaxies "
		+ "WHERE galaxies.id = planets.galaxiesId "
		+ "GROUP BY galaxies.id "
		+ "ORDER BY sum_core_temp DESC LIMIT 1;";

	public final static String PS_INSERT_GALAXY =
		"INSERT INTO galaxies (name) VALUES (?);";

	public final static String PS_INSERT_PLANET =
		"INSERT INTO planets (name, radius, coreTemperature, "
		+ "existAtmosphere, existLife, galaxiesId) " 
		+ "VALUES ( ?, ?, ?, ?, ?, " 
		+ "(SELECT galaxies.id "
		+ "FROM galaxies " 
		+ "WHERE galaxies.name = ?));";

	public final static String PS_INSERT_SATELLITE = 
		"INSERT INTO satellites (satellites.name, satellites.radius, "
		+ "satellites.distanceToPlanet, satellites.planetsId) " 
		+ "VALUES ( ?, ?, ?, " 
		+ "(SELECT planets.id "
		+ "FROM planets " 
		+ "WHERE planets.name = ?));";

	public final static String PS_SELECT_GALAXY = "SELECT * FROM galaxies;";

	public final static String PS_SELECT_PLANET = 
		"SELECT planets.id, planets.name, planets.radius, "
		+ "planets.coreTemperature, planets.existAtmosphere, " 
		+ "planets.existLife, galaxies.name "
		+ "FROM planets " 
		+ "LEFT OUTER JOIN galaxies " 
		+ "ON planets.galaxiesId = galaxies.id;";

	public final static String PS_SELECT_SATELLITE = 
		"SELECT satellites.id, satellites.name, satellites.radius, "
		+ "satellites.distanceToPlanet,  planets.name " 
		+ "FROM satellites " 
		+ "LEFT OUTER JOIN planets "
		+ "ON satellites.planetsId = planets.Id;";

	public final static String PS_HELPER_SELECT_GALAXY = "SELECT name FROM galaxies;";

	public final static String PS_HELPER_SELECT_PLANET = "SELECT name FROM planets;";
}
