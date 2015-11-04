package ru.ifmo.methods;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Pair;
import ru.ifmo.data.Parameters;

import java.util.ArrayList;
import java.util.List;

public class Chekharda implements Solver {
    /**
     * Counts T(t, x) for any (t, x), where
     * t = n * dt, n = 0..num-1
     * x from initial values
     * <p>
     * Boundary conditions:
     * T(t, 0) = T(0, 0)      (for all t)
     * T(t, x_n) = T(0, x_n)  (for all t)
     * <p>
     * Profile of initial T is given in <tt>init</tt> parameter
     *
     * @param init   keeps pairs (x, T(0, x))
     * @param number number of t for which T would be counted
     * @param params dx, dt, u, kappa
     * @return arraylist discrete representation of T(t, x)
     */
    @Override
    public List<List<Double>> solve(InitialConditions init, int number, Parameters params) {
        List<List<Double>> T = new ArrayList<>();
        List<Double> initial = new ArrayList<>();
        for (Pair<Double, Double> pair : init) {
            initial.add(pair.getValue());
        }
        T.add(initial);

        int xNum = init.size(); // number of columns

        double left = init.get(0).getValue();
        double right = init.get(xNum - 1).getValue();

        double s = params.u * params.dt / params.dx;
        double r = params.kappa * params.dt / (params.dx * params.dx);

        if (number >= 1) {
            // first iteration like in Explicit Central Scheme
            List<Double> secondRow = new ArrayList<>();
            secondRow.add(left);
            for (int i = 1; i < initial.size() - 1; ++i) {
                secondRow.add(initial.get(i) * (1 - 2 * r)
                        + initial.get(i - 1) * (r + s / 2)
                        + initial.get(i + 1) * (r - s / 2));
            }
            secondRow.add(right);
            T.add(secondRow);
        }

        for (int i = 1; i < number; ++i) {
            List<Double> nextRow = new ArrayList<>();
            nextRow.add(left);
            for (int j = 1; j < xNum - 1; ++j) {
                double v = T.get(i - 1).get(j)
                         - T.get(i).get(j) * 4 * r
                         + T.get(i).get(j) * (2 * r + s)
                         + T.get(i).get(j + 1) * (2 * r - s);
                nextRow.add(v);
            }
            nextRow.add(right);
            T.add(nextRow);
        }
        return T;
    }
}
