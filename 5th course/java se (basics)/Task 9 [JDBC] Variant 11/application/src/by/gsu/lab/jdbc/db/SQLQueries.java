package by.gsu.lab.jdbc.db;

public class SQLQueries {

	/**
	 * Точка из множества, наиболее приближенная к заданной.
	 */
	public final static String SUBTASK1_SELECT_NEAR_POINT =
		"SELECT id, x, y, SQRT(POW(( ? - x),2) + POW(( ? - y),2)) "
		+ "AS distance "
		+ "FROM points GROUP BY id ORDER BY distance ASC LIMIT 1;";

	/**
	 * Точка из множества, наиболее удалённая от заданной.
	 */
	public final static String SUBTASK2_SELECT_FAR_POINT =
		"SELECT id, x, y, SQRT(POW(( ? - x),2) + POW(( ? - y),2)) "
		+ "AS distance "
		+ "FROM points GROUP BY id ORDER BY distance DESC LIMIT 1;";

	/**
	 * Точки из множества, лежащие на одной прямой с заданной прямой.
	 */
	public final static String SUBTASK3_SELECT_POINTS_ON_LINE =
		"SELECT points.id,  points.x,  points.y, "
		+ "? AS x1, ? AS y1, ? AS x2, ? AS y2 "
		+ "FROM points HAVING ((abs((y-y1)*(x2-x1)-(x-x1)*(y2-y1)) <= 0.00001)"
		+ "AND (((x-x1)*(x2-x1)-(y-y1)*(y2-y1)) >= 0) "
		+ "AND (((x-x1)*(x2-x1)-(y-y1)*(y2-y1)) <= "
		+ "((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))));";
}
