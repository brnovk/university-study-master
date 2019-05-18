import java.util.HashMap;
import java.util.Map;

import by.gsu.lab.math.Polynomial;
import by.gsu.lab.math.PolynomialParser;

/**
 * 
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) {

		PolynomialParser parser = new PolynomialParser();

		// Create a polynomial with the help of the parser.
		Polynomial firstPolynom = parser.parse(" 32x^5 - 5x^2 + 4x + 3");
		System.out.println("First polynomial: " + firstPolynom);

		// - 3x^5 - x + 2
		Map<Integer, Integer> members = new HashMap<>();
		members.put(5, -3);
		members.put(1, -1);
		members.put(0, 2);

		// Create a polynomial using the constructor and the container Map
		Polynomial secondPolynom = new Polynomial(members);
		System.out.println("Second polynomial: " + secondPolynom);

		System.out.println("\nAddition: " + firstPolynom.addition(secondPolynom));

		System.out.println("Subtraction: " + firstPolynom.subtraction(secondPolynom));

		System.out.println("Multiplication: " 
			+ firstPolynom.multiplication(secondPolynom));
	}
}
