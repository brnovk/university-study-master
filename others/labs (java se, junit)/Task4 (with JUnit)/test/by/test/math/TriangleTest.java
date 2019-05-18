package by.test.math;

import static org.junit.Assert.*;
import org.junit.Test;
import by.labs.math.Triangle;

/**
 * Unit-test to JUnit4 to test the class 'Triangle'.
 */
public class TriangleTest {

	/**
	 * Testing constructor
	 */
	@Test(expected = IllegalArgumentException.class)
	@SuppressWarnings("ResultOfObjectAllocationIgnored")
	public final void testTriangle() {
		System.out.println("testTriangle");
		// sides not allowed - thrown IllegalArgumentException
		new Triangle(45.0, 42.0, 3.0);
	}

	/**
	 * Testing method isExists
	 */
	@Test
	public final void testIsExists() {
		System.out.println("testIsExists");
		// Correct value - is expected 'true'
		assertTrue(Triangle.isExists(45.0, 42.00001, 3.0));

        // Incorrect value - is expected 'false'
		assertFalse(Triangle.isExists(45.0, 42.0, 3.0));
	}

	/**
	 * Testing method getPerimeter
	 */
	@Test
	public final void testGetPerimeter() {
		System.out.println("testGetPerimeter");
        double expected = 15.0;
        Triangle triangle = new Triangle(4.0, 5.0, 6.0);
        double actual = triangle.getPerimeter();
        // Accuracy for comparison of numbers of type 'double'
        double delta = 0.0000000001;
        assertEquals(expected, actual, delta);
	}

	/**
	 * Testing method getArea
	 */
	@Test
	public final void testGetArea() {
		System.out.println("testGetArea");
        double expected = 9.921567416496;
        Triangle triangle = new Triangle(4.0, 5.0, 6.00000000001);
        double actual = triangle.getArea();
        // Accuracy for comparison of numbers of type 'double'
        double delta = 0.0000000001;
        assertEquals(expected, actual, delta);
	}
}
