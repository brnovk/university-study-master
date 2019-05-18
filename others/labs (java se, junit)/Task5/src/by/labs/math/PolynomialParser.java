package by.labs.math;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PolynomialParser {

	private final static int INDEX_SIGN_COEFF = 1;
	private final static int INDEX_COEFF = 2;
	private final static int INDEX_VARIABLE = 3;
	private final static int INDEX_DEGREE = 4;

	private final static String NEGATIVE_SIGN = "-";
	private final static String MONOMIAL_TEMPLATE = "([+-])?(\\d+)?(x)?(?:\\^(\\d+))?";

	/**
	 * Getting a polynomial of one variable from a string written in standard
	 * mathematical form. Variable of the polynomial must be "x".
	 */
	public Polynomial parse(String rawPolynomial) {
		String source = normalizeSourceString(rawPolynomial);
		validation(source);
		Map<Integer, Integer> result = new HashMap<Integer, Integer>();
		Pattern monomial = Pattern.compile(MONOMIAL_TEMPLATE);
		Matcher m = monomial.matcher(source);
		while ((!m.hitEnd() && (m.find()))) {
			boolean isNegative = NEGATIVE_SIGN.equals(m.group(INDEX_SIGN_COEFF));
			int currentDegree = calcDegree(m.group(INDEX_DEGREE), 
				m.group(INDEX_VARIABLE));
			int currentCoeff = calcCoeff(isNegative, m.group(INDEX_COEFF));
			result.put(currentDegree, currentCoeff);
		}
		return new Polynomial(result);
	}

	/**
	 * Calculation of coefficient of monomial
	 */
	private int calcCoeff(boolean isNegative, String coefficient) {
		int result = (coefficient != null) ? Integer.parseInt(coefficient) : 1;
		return (isNegative) ? -result : result;
	}

	/**
	 * Calculation of degree of monomial
	 */
	private int calcDegree(String degree, String symbolVarialble) {
		int result = (symbolVarialble != null) ? 1 : 0;
		return (degree != null) ? Integer.parseInt(degree) : result;
	}

	/**
	 * Removing all spaces from the string and converting all characters to
	 * lowercase.
	 */
	private String normalizeSourceString(String source) {
		final String EMPTY_STRING = "";
		final String WHITESPACE_TEMPLATE = "\\s+";
		String result = source.replaceAll(WHITESPACE_TEMPLATE, EMPTY_STRING);
		return result.toLowerCase();
	}
	
    /**
     * Check the input string. 
     * If in string is something other than
     * integers, characters -+^ or the 'x' variable - an exception is thrown.
     */
    private void validation(final String source) throws IllegalArgumentException {
    	final char[] valids = {'0','1','2','3','4','5','6','7','8','9','x','-','+','^'};
    	NEXT:for (char current : source.toCharArray()) {
    		for (char valid : valids) {
    			if (valid == current) {
    				continue NEXT;
    			}
    		}
    		throw new IllegalArgumentException(
				"An invalid character '" + current 
				+ "'\nValid entries are integers, +-^ and 'x' variable!");
    	}
    }
}
