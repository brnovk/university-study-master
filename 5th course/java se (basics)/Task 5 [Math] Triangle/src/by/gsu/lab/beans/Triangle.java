package by.gsu.lab.beans;

public class Triangle {

	private final double firstSide;
	private final double secondSide;
	private final double thirdSide;

	public Triangle(double firstSide, double secondSide, double thirdSide) {
		if (!isTriangleExists(firstSide, secondSide, thirdSide)) {
			throw new IllegalArgumentException();
		}
		this.firstSide = firstSide;
		this.secondSide = secondSide;
		this.thirdSide = thirdSide;
	}

	/**
	 * Verifies the existence of a triangle.
	 */
	public static boolean isTriangleExists(double firstSide, double secondSide,
			double thirdSide) {
		return (0 > Double.compare(thirdSide, (firstSide + secondSide)))
			&& (0 > Double.compare(secondSide, (firstSide + thirdSide)))
			&& (0 > Double.compare(firstSide, (secondSide + thirdSide)));
	}

	public double getPerimeter() {
		return firstSide + secondSide + thirdSide;
	}

	/**
	 * Getting the area of a triangle
	 */
	public double getArea() {
		double semiPerimeter = getPerimeter() / 2;
		double buffer = semiPerimeter * (semiPerimeter - firstSide)
			* (semiPerimeter - secondSide) * (semiPerimeter - thirdSide);
		return Math.sqrt(buffer);
	}

	// getters

	public double getFirstSide() {
		return firstSide;
	}

	public double getSecondSide() {
		return secondSide;
	}

	public double getThirdSide() {
		return thirdSide;
	}

	@Override
	public String toString() {
		final String DELIMETER = ", ";
		return "Triangle: " + firstSide + DELIMETER + secondSide 
			+ DELIMETER + thirdSide;
	}
}
