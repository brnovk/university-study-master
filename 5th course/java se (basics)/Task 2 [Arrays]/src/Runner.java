import java.util.Arrays;

/**
 * Task: Remove elements that are greater than 5.
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) {
		int[] numbers = new int[]{ 7,3,4,5,12,123,12,3,12,3,12,3,4 };
		System.out.println(Arrays.toString(numbers));
		
		int count = 0;
		for (int i = numbers.length - 1; i >= 0; i--) {
			if (numbers[i]>5) {
				numbers = removeElement(numbers, i);
				count++;
			}
		}
		System.out.println(Arrays.toString(numbers));
		System.out.println("Count elements greater than 5: " + count);
	}

	static int[] removeElement(int[] source, int index) {
		int[] copy = new int[source.length-1];
		System.arraycopy(source, 0, copy, 0, index);
		System.arraycopy(source,index+1,copy,index,source.length-1-index);
		return copy;
	}
}
