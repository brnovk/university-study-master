package by.gsu.lab;

import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class RunnerLogic {

	public void doLogic(List<Set<Integer>> sets) {

		System.out.println("All sets of sets:");
		for (Set<Integer> set : sets) {
			System.out.println(set);
		}
		Set<Integer> firstSet = sets.get(0);
		Set<Integer> secondSet = sets.get(1);

		System.out.println("\nCrossing of the first two sets:");
		System.out.println(crossing(firstSet, secondSet));

		System.out.println("\nUnite of the first two sets:");
		System.out.println(unite(firstSet, secondSet));
	}

	private Set<Integer> crossing(Set<Integer> firstSet, Set<Integer> secondSet) {
		Set<Integer> result = new TreeSet<>();
		result.addAll(firstSet);
		result.retainAll(secondSet);
		return result;
	}

	private Set<Integer> unite(Set<Integer> firstSet, Set<Integer> secondSet) {
		Set<Integer> result = new TreeSet<>();
		result.addAll(firstSet);
		result.addAll(secondSet);
		return result;
	}
}
