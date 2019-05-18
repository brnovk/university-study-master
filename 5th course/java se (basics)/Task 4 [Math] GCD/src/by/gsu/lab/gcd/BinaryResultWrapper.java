package by.gsu.lab.gcd;

import java.util.concurrent.TimeUnit;

/**
 * Class-wrapper for storing the results of binary Euclidean algorithm.
 * 
 * @author Victor Baranov
 */
public class BinaryResultWrapper {

	private final int gcd;

	/**
	 * Execution time of the algorithm in nanoseconds.
	 */
	private final long elapsedTime;

	public BinaryResultWrapper(int gcd, long elapsedTime) {
		this.gcd = gcd;
		this.elapsedTime = elapsedTime;
	}

	// getters

	public int getGCD() {
		return gcd;
	}

	/**
	 * Get time of the algorithm in nanoseconds.
	 */
	public long getElapsedTime() {
		return elapsedTime;
	}

	/**
	 * Get time of the algorithm in microseconds.
	 */
	public long getElapsedTimeMicroSeconds() {
		return TimeUnit.MICROSECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS);
	}

	/**
	 * Get time of the algorithm in milliseconds.
	 */
	public long getElapsedTimeMilliSeconds() {
		return TimeUnit.MILLISECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS);
	}

	/**
	 * Get time of the algorithm in seconds.
	 */
	public long getElapsedTimeSeconds() {
		return TimeUnit.SECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS);
	}

	@Override
	public String toString() {
		final String OUT_PATTERN = "Result binary GCD algorithm: \"gcd\" = %d," 
			+ " \"elapsed time\" = %d microseconds";
		return String.format(OUT_PATTERN, gcd, getElapsedTimeMicroSeconds());
	}
}
