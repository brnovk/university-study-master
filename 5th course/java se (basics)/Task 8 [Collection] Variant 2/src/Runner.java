import java.io.IOException;
import java.util.List;
import java.util.Stack;

import by.gsu.lab.FileHandler;

public class Runner {

	public static void main(String[] args) {
		
		String fileName = "numbers.txt";
		try {
			FileHandler fileHandler = new FileHandler(fileName);
			List<Stack<Integer>> stacks = fileHandler.readListStacks();

			System.out.println("All numbers from file:");
			for (Stack<Integer> current : stacks) {
				System.out.println(current);
			}

			System.out.println("Only numbers with numbers descending order:");
			for (Stack<Integer> current : stacks) {
				if (isReverseOrderNumber(current)) {
					System.out.println(current);
				}
			}
		} catch (IOException ex) {
			System.err.println(ex);
		}
	}

	public static boolean isReverseOrderNumber(Stack<Integer> number) {
		int previous = number.get(0);
		for (Integer current : number) {
			if (current > previous) {
				return false;
			}
			previous = current;
		}
		return true;
	}
}
