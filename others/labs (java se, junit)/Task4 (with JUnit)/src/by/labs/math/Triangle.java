package by.labs.math;

/**
 * Class "triangle" to work with triangle set in plane
 * with sides with sides 'a', 'b', 'c'.
 */
public class Triangle {

	private final double a;
	private final double b;
	private final double c;
	
	public Triangle(double a, double b, double c) {
		
		// Check for possibility existence
		if (!isExists(a, b, c)) {
            throw new IllegalArgumentException("Triangle don't exist, as\n" 
            	+ "sum of any two sides must be greater than the third.\n");
        }
		this.a = a;
		this.b = b;
		this.c = c;
	}
	
	/**
	 * Check for possibility existence
	 */
	public static boolean isExists(double a, double b, double c) {
		return firstMore(c, a, b) && firstMore(b, a, c) && firstMore(a, b, c);
	}
	
	private static boolean firstMore(double a, double b, double c) {
		return 0 > Double.compare(a, (b + c));
	}
	
    public double getPerimeter() {
        return a + b + c;
    }

    public double getArea() {
        double semiPerimeter = getPerimeter()/2;
        double buffer = semiPerimeter * (semiPerimeter - a)
                                      * (semiPerimeter - b)
                                      * (semiPerimeter - c);
        return Math.sqrt(buffer);
    }

	@Override
	public String toString() {
		return "\nTriangle [a=" + a + ", b=" + b + ", c=" + c + "]";
	}
}
