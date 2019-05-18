import by.gsu.lab.gcd.BinaryResultWrapper;
import by.gsu.lab.gcd.GCDHelper;

/**
 * Develop a type that implements the Euclidean algorithm to compute GCD 
 * of two integers.
 * 
 * Add to type additional functionality in the form of
 * overloaded methods gcd for three, four or five integers.
 * 
 * Add to the type of the method that implements the algorithm Stein
 * (the binary Euclidean algorithm) to calculate the GCD of two integers.
 * The method must take an output parameter that contains the value of 
 * the time required to perform calculations.
 * 
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) {

		GCDHelper helper = new GCDHelper();
		
		// Check the usual Euclidean algorithm for 2, 3, 4 and 5 numbers.
		System.out.println(helper.calculateGCDEuclid(6, 15));
		System.out.println(helper.calculateGCDEuclid(54, 18, 72));
		System.out.println(helper.calculateGCDEuclid(534, 114, 54, 12));
		System.out.println(helper.calculateGCDEuclid( 23, 920, 46, 368, 5888));
		
		
		// Check the binary Euclidean algorithm
		BinaryResultWrapper binaryResult = helper.calculateBinaryGCD(36, 6);
		System.out.println(binaryResult);
	}
}
