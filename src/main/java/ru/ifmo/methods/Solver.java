package ru.ifmo.methods;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Parameters;

import java.util.List;

/**
 * Approximates T(t, x) function
 */
public interface Solver {
    /**
     * Counts T(t, x) for any (t, x), where
     * t = n * dt, n = 0..num-1
     * x from initial values
     *
     * @param init keeps pairs (x, T(0, x))
     * @param number number of t for which T would be counted
     * @param params dx, dt, u, kappa
     * @return discrete arraylist representation of T(t, x)
     */
    List<List<Double>> solve(InitialConditions init, int number, Parameters params);
}
