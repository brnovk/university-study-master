import by.gsu.lab.beans.Triangle;

/**
 * Develop a class "Triangle" to work with triangle, set on plane sides a, b, c.
 * Envisage the possibility of verifying the existence of the triangle, implement
 * function counting its area and perimeter.
 * 
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) {

		// Checking existence of triangle
		System.out.println(Triangle.isTriangleExists(45.0, 42.00001, 3.0));
		System.out.println(Triangle.isTriangleExists(45.0, 42.0, 3.0));
		
		Triangle triangle = new Triangle(4.0, 5.0, 6.00000000001);
		System.out.println(triangle);
		
		// Perimeter
		System.out.println("Perimeter: " + triangle.getPerimeter());
		
		// Area
		System.out.println("Area: " + triangle.getArea());
	}
}
