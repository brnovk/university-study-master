import java.util.Scanner;
import by.labs.math.Triangle;

/**
 * To develop the class "triangle" to work with the triangle set in the plane
 * with sides with sides a, b, c.
 * 
 * To provide the possibility to check the existence of a triangle,
 * to implement the counting function of its area and perimeter.
 * 
 * As the interface UI-use console application with command line interface.
 * Create a unit-tests to test methods developed by type.
 * 
 * Additionally: need to add a manual user input.
 */
public class Runner {

	public static void main(String[] args) {

		Scanner scanner = null;
		try {
			scanner = new Scanner(System.in);
			menu(scanner);						// Start application menu
		} finally {
			if (scanner != null) {
				scanner.close();
			}
			System.out.println("Program completed.");
		}
	}

	/**
	 * Application menu.
	 */
	static void menu(Scanner scanner) {
		final String menuLabel = "\nPress:"
			+ "\n0 - to exit"
			+ "\n1 - to test for existence of triangle"
			+ "\n2 - to enter data and create a triangle";
		
		while (true) {
			
			// Getting input from the user number (0, 1 or 2)
			int choise = getUserChoiseInt(scanner, menuLabel, 0, 2);
			switch (choise) {
				case 0:
					return;		// Exit from method (and programs)
				case 1: 
					{
						String formatMessage = "\nTriangle (%.2f, %.2f, %.2f) %s.\n";
						double a = inputSide(scanner, "a");	// User input sides A, B, and c
						double b = inputSide(scanner, "b");
						double c = inputSide(scanner, "c");

						String exists = Triangle.isExists(a, b, c) ? "exist" : "don't exist";
						System.out.printf(formatMessage, a, b, c, exists);
					}
					continue;
				case 2:
					{
						try {
							double a = inputSide(scanner, "a");	// User input sides A, B, and c
							double b = inputSide(scanner, "b");
							double c = inputSide(scanner, "c");
							Triangle tringon = new Triangle(a ,b, c);	// Creating triangle
							System.out.println(tringon);
							System.out.println("Perimeter: " + tringon.getPerimeter());
							System.out.println("Area: " + tringon.getArea());

						// If invalid data when creating
						} catch (IllegalArgumentException ex) {		
							System.out.println(ex);
						}
					}
				default:
					break;
			}
		}
	}

	/**
	 * Getting the user entered integer number (menu item)
	 * @param comment Tip before entering
	 * @param minValue Minimum value (in this case 0)
	 * @param maxValue Maximum value (in this case 2)
	 */
	static int getUserChoiseInt(Scanner scanner, String comment, int minValue, int maxValue) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextInt()) {			// If entered integer
				int number = scanner.nextInt();

				if (number >= minValue && number <= maxValue) {
					return number;
				}
			} else {
				scanner.next();	                // clean the input buffer
			}
			System.out.printf("Invalid data - only integers are allowed from %d to %d.\n", 
					minValue, maxValue);
		} while (true);
	}
	
	/**
	 * Getting input from the user float numbers (Sides A, B or C of a triangle)
	 * @param label	Tip for input (A, B or C)
	 */
	static double inputSide(Scanner scanner, String label) {
		System.out.printf("Enter side %s (integer or real number):\n", label.toUpperCase());
		do {
			System.out.print(">> ");
			if (scanner.hasNextDouble()) {		// If float number is entered
				return scanner.nextDouble();
			} else {
				scanner.next();	                // cleaning input buffer
			}
			System.out.println("Invalid data - only numbers allowed.");
		} while (true);
	}
}
