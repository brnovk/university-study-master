import by.gsu.lab.nthroot.NthRoot;
import by.gsu.lab.nthroot.NthRootType;

/**
 * Develop type, allows you to calculate the root n-degree from number using 
 * Newton's method with the specified accuracy.
 * Provide the ability to compare the result with a determinable value using java.
 * 
 * @author Victor Baranov
 */
public class Runner {
	
	public static void main(String[] args) {
		
		final String TOOLTIP_DISPLAY_NEWTON = "Newton method result:      ";
		final String TOOLTIP_DISPLAY_NATIVE = "Java native method result: ";
		
		double number = 27;       // number
		int degree = 3;           // degree
		double accuracy = 1.0e-9; // precision
		
		NthRoot helper = new NthRoot();
		
		// Calculation method of Newton
		double resultNewton = helper.rootCalculate(number, degree, accuracy,
			NthRootType.NEWTON_TYPE);
		System.out.println(TOOLTIP_DISPLAY_NEWTON + resultNewton);
		
		// Calculation of 'java' tools
		double resultNative = helper.rootCalculate(number, degree, accuracy,
			NthRootType.NATIVE_TYPE);
		System.out.println(TOOLTIP_DISPLAY_NATIVE + resultNative);
	}
}
