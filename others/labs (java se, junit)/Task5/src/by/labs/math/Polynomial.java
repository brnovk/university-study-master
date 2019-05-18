package by.labs.math;

import java.util.Collections;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

/**
 * Class "polynomial" for working with polynomials in 1 variable.
 */
public class Polynomial {

	final static String EMPTY_STRING = "";
	final static String POSITIVE_SIGN = " + ";
	final static String NEGATIVE_SIGN = " - ";
	final static String DEGREE_MARK_1 = "x";
	final static String DEGREE_MARK_NTH = "x^";

	/**
	 * Container for storage of degrees and coefficients of polynomial members.
	 */
	private final Map<Integer, Integer> members = 
		new TreeMap<Integer, Integer>(Collections.reverseOrder());

	public Polynomial(Map<Integer, Integer> members) {
		this.members.putAll(members);
		deleteMembersWithZeroCoefficient();
	}

	public Polynomial add(Polynomial other) {
		Map<Integer, Integer> result = new TreeMap<Integer, Integer>();
		result.putAll(members);
		for (Integer currentKey : other.members.keySet()) {
			Integer resultValue = other.members.get(currentKey);
			Integer currentValue = result.get(currentKey);
			if (currentValue != null) {
				resultValue += currentValue;
			}
			result.put(currentKey, resultValue);
		}
		return new Polynomial(result);
	}

	public Polynomial subtract(Polynomial other) {
		Map<Integer, Integer> result = new TreeMap<Integer, Integer>();
		result.putAll(members);
		for (Integer currentKey : other.members.keySet()) {
			Integer currentValue = result.get(currentKey);
			if (currentValue != null) {
				Integer difference = currentValue - other.members.get(currentKey);
				result.put(currentKey, difference);
			} else {
				result.put(currentKey, other.members.get(currentKey));
			}
		}
		return new Polynomial(result);
	}

	public Polynomial multiply(Polynomial other) {
		Map<Integer, Integer> result = new TreeMap<Integer, Integer>();
		for (Entry<Integer, Integer> first : members.entrySet()) {
			for (Entry<Integer, Integer> second : other.members.entrySet()) {
				Integer amountKey = first.getKey() + second.getKey();
				Integer productValue = first.getValue() * second.getValue();
				if (result.containsKey(amountKey)) {
					productValue += result.get(amountKey);
				}
				result.put(amountKey, productValue);
			}
		}
		return new Polynomial(result);
	}

	/**
	 * Helper method to remove all members with zero coefficient.
	 */
	private void deleteMembersWithZeroCoefficient() {
		Iterator<Entry<Integer, Integer>> iterator = members.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<Integer, Integer> pair = iterator.next();
			if (pair.getValue() == 0) {
				iterator.remove();
			}
		}
	}

	/**
	 * Getting the string representation of monomial sign, depending on the sign
	 * of the coefficient and the place of accommodation monomial in polynomial.
	 * If monomial coefficient is negative - returns "-";
	 * If coefficient monomial positive and 
	 * monomial first in polynomial - return empty string. Otherwise - "+";
	 */
	private String viewSignMonomial(boolean isFirst, int coefficient) {
		final int MIN_POSITIVE_COEFFICIENT = 0;
		if (coefficient < MIN_POSITIVE_COEFFICIENT) {
			return NEGATIVE_SIGN;
		} else {
			return (isFirst) ? EMPTY_STRING : POSITIVE_SIGN;
		}
	}

	/**
	 * Getting string representation coefficient of monomial, depending on degree.
	 * If coefficient is equal to one or degree zero -
	 * returned empty string. Otherwise, it returns the coefficient.
	 */
	private String viewCoefficient(int coeff, int degree) {
		return ((coeff != 1) || (degree == 0)) 
			? String.valueOf(coeff) 
			: EMPTY_STRING;
	}

	/**
	 * Getting string representation of degree of monomial.
	 * If the degree of the zero - returns an empty string.
	 * If the degree of 1 - returns "x". Otherwise - returns "x^" + degree.
	 */
	private String viewDegree(int degree) {
		String result = EMPTY_STRING;
		if (degree != 0) {
			result = (degree == 1) ? DEGREE_MARK_1 : DEGREE_MARK_NTH + degree;
		}
		return result;
	}

	@Override
	public String toString() {
		boolean isFirstMember = true;
		StringBuilder builder = new StringBuilder();
		for (Map.Entry<Integer, Integer> current : members.entrySet()) {
			int currentCoeff = current.getValue();
			int currentDegree = current.getKey();
			builder.append(viewSignMonomial(isFirstMember, currentCoeff));
			builder.append(viewCoefficient(Math.abs(currentCoeff), currentDegree));
			builder.append(viewDegree(currentDegree));
			isFirstMember = false;
		}
		return builder.toString();
	}
}
