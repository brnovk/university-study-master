import by.gsu.lab.math.GeometricVector;

/**
 * To develop the class "vector" to work with three-dimensional vectors. 
 * Overloading for a class of operations that are permissible to work 
 * with three-dimensional vectors.
 * 
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) {

		GeometricVector first = new GeometricVector(1, 2, 3);
		GeometricVector second = new GeometricVector(2, 1, -2);
		GeometricVector third = new GeometricVector(1, 2, 1);

		// Checking the work methods of the class GeometricVector.

		System.out.println("Vector multiply: " 
			+ first.vectorMultiplication(second));

		System.out.println("Scalar multiply: " 
			+ first.scalarMultiplication(second));

		System.out.println("Mixed multiply: " 
			+ first.mixedMultiplication(second, third));

		System.out.println("Multiplying by the number: " 
			+ first.multipliedByNumber(42));

		System.out.println("Length (module): " + first.length());

		System.out.println("Angle (degrees): " + first.angle(third));

		System.out.println("Is collinear: " + first.isCollinear(third));

		System.out.println("Is orthogonal: " + first.isOrthogonal(third));

		System.out.println("is coplanar: " + first.isComplanar(second, third));

		System.out.println("Normalized vector: " + first.getNormalized());
	}
}
