import java.util.Scanner;
import by.labs.math.*;

/**
 * Develop a class "polynomial" to work with polynomials of one variable.
 * Overloading for a class of operations that are permissible for working
 * with polynomials.
 * 
 * As a UI interface to use console application with command line interface.
 * Additionally: need to add a manual user input.
 */
public class Runner {

	public static void main(String[] args) {

		Scanner scanner = null;
		try {
			scanner = new Scanner(System.in);
			menu(scanner);						// Startup application menu
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
		final String menuLabel = "\nPress:\n"
			+ "0 - to exit\n"
			+ "1 - to input 2 polynomials and perform operations";
		final String menuError = "Invalid data - is only valid numbers are 0 or 1.";

		while (true) {

			// Getting input from the user number (0 or 1)
			int choise = getInputInt(scanner, menuLabel, menuError, 0, 1);
			switch (choise) {
				case 0:
					return;		// Exit from menu (and application)
				case 1: 
					scanner.nextLine();							    // Cleaning scanner buffer
					Polynomial first = inputPolynom(scanner, 1);	// Input 1 and 2 polynomial
					Polynomial second = inputPolynom(scanner, 2);

					System.out.printf("\n1st polynomial:         %s\n", first);
					System.out.printf("2nd polynomial:         %s\n", second);

					System.out.printf("Sum of polynomials:     %s\n", first.add(second));
					System.out.printf("Difference polynomials: %s\n", first.subtract(second));
					System.out.printf("Multiply polynomials:   %s\n", first.multiply(second));
				default:
					break;
			}
		}
	}

	/**
	 * Enter polynomial by user.
	 * @param order	Tip polynomial of a sequence number (1 or 2)
	 */
	static Polynomial inputPolynom(Scanner scanner, int order) {
		final String labelPolynom = String.format(
			"\nEnter %d-%s polynomial in one variable\n"
			+ "- variable polynomial 'x';\n"
			+ "- degrees and coefficients - integers;\n"
			+ "- degree of polynomial is denoted by '^';\n"
			+ "- symbols of multiplication (*) and division (/) are not supported;\n"
			+ "- coefficients of monomials need not be repeated in polynomial;\n"
			+ "- example of correct polynomial: 32x^5 - 5x^2 + 4x + 3.", 
			order, (order == 1) ? "st" : "nd");
		System.out.println(labelPolynom);
		do {
			try {
				System.out.print(">> ");
				if (scanner.hasNextLine()) {
					String rawPolynom = scanner.nextLine();
					return new PolynomialParser().parse(rawPolynom);
				}
			} catch (IllegalArgumentException ex) {
				System.out.println(ex);
				System.out.println("Repeat input of polynomial!");
			}
		} while (true);
	}

	/**
	 * Getting the user entered integer number.
	 * @param comment Tip before entering
	 * @param errMessage Tips in case of wrong entry
	 */
	static int getInputInt(Scanner scanner, String comment, String errMessage,
			int minValue, int maxValue) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextInt()) {			// If an integer is entered
				int number = scanner.nextInt();

				if (number >= minValue && number <= maxValue) {
					return number;
				}
			} else {
				scanner.next();	                // cleaning input buffer
			}
			System.out.println(errMessage);
		} while (true);
	}
}
