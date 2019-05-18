package by.gsu.lab.math;

/**
 * The vector class to work with three-dimensional vectors. 
 * Implemented methods:
 * - Calculation of the length;
 * - Angle calculation;
 * - Addition and subtraction;
 * - Vector, scalar and mixed multiply;
 * - Multiplying by the number;
 * - Check for orthogonality, collinearity and complanarity;
 * - Getting a normalized vector.
 * 
 * @author Victor Baranov
 */
public class GeometricVector {

	private final double x;
	private final double y;
	private final double z;

	public GeometricVector(double x, double y, double z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	// getters

	public double getX() {
		return x;
	}

	public double getY() {
		return y;
	}

	public double getZ() {
		return z;
	}

	/**
	 * Length (module).
	 */
	public double length() {
		double buffer = x * x + y * y + z * z;
		return Math.sqrt(buffer);
	}

	/**
	 * Angle (in degrees).
	 */
	public double angle(GeometricVector other) {
		double scalarProduct = scalarMultiplication(other);
		double firstModule = length();
		double secondModule = other.length();
		double radian = Math.acos(scalarProduct / (firstModule * secondModule));
		return Math.toDegrees(radian); // radians to degrees
	}

	public GeometricVector addition(GeometricVector other) {
		return new GeometricVector(x + other.x, y + other.y, z + other.z);
	}

	public GeometricVector subtraction(GeometricVector other) {
		return new GeometricVector(x - other.x, y - other.y, z - other.z);
	}

	/**
	 * Vector multiply.
	 */
	public GeometricVector vectorMultiplication(GeometricVector other) {
		double resultX = (y * other.z) - (z * other.y);
		double resultY = (z * other.x) - (x * other.z);
		double resultZ = (x * other.y) - (y * other.x);
		return new GeometricVector(resultX, resultY, resultZ);
	}

	/**
	 * Scalar multiply.
	 */
	public double scalarMultiplication(GeometricVector other) {
		return (x * other.x) + (y * other.y) + (z * other.z);
	}

	/**
	 * Mixed multiply.
	 */
	public double mixedMultiplication(GeometricVector firstOther,
			GeometricVector secondOther) {
		double result;
		result = (x * firstOther.y * secondOther.z);
		result += (y * firstOther.z * secondOther.x);
		result += (z * firstOther.x * secondOther.y);
		result -= (z * firstOther.y * secondOther.x);
		result -= (y * firstOther.x * secondOther.z);
		result -= (x * firstOther.z * secondOther.y);
		return result;
	}

	/**
	 * Multiplying by number.
	 */
	public GeometricVector multipliedByNumber(double multiplier) {
		return new GeometricVector(x * multiplier, y * multiplier, z * multiplier);
	}

	/**
	 * Checking for collinearity.
	 */
	public boolean isCollinear(GeometricVector other) {
		GeometricVector buffer = vectorMultiplication(other);
		return (Double.compare(buffer.x, 0D) == 0) 
			&& (Double.compare(buffer.y, 0D) == 0)
			&& (Double.compare(buffer.z, 0D) == 0);
	}

	/**
	 * Check for orthogonality.
	 */
	public boolean isOrthogonal(GeometricVector other) {
		double buffer = scalarMultiplication(other);
		return Double.compare(buffer, 0D) == 0;
	}

	/**
	 * Check complanarity.
	 */
	public boolean isComplanar(GeometricVector firstOther, 
			GeometricVector secondOther) {
		double buffer = mixedMultiplication(firstOther, secondOther);
		return Double.compare(buffer, 0D) == 0;
	}

	/**
	 * Getting a normalized vector (Length equal to one).
	 */
	public GeometricVector getNormalized() {
		double length = length();
		double resultX = x / length;
		double resultY = y / length;
		double resultZ = z / length;
		return new GeometricVector(resultX, resultY, resultZ);
	}

	/**
	 * Getting string representation of the object in csv-format.
	 */
	@Override
	public String toString() {
		final char DELIMETER = ',';
		return String.valueOf(x) + DELIMETER + y + DELIMETER + z;
	}
}
