package ru.ifmo.methods;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Pair;
import ru.ifmo.data.Parameters;
import java.util.ArrayList;
import java.util.List;


public class ExplicitDownStream implements Solver {
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

        int xNum = init.size();

        double t00 = init.get(0).getValue();
        double t0x_n = init.get(xNum - 1).getValue();

        double s = params.u * params.dt / params.dx;
        double r = params.kappa * params.dt / (params.dx * params.dx);

        for (int i = 0; i < number; i++) {
            List<Double> nt = new ArrayList<>();
            nt.add(t00);
            List<Double> prevT = T.get(i);
            for (int j = 1; j <= xNum - 2; j++) {
                double v = prevT.get(j) - s * (prevT.get(j + 1) - prevT.get(j))
                        + r * (prevT.get(j - 1) - 2 * prevT.get(j) + prevT.get(j + 1));
                nt.add(v);
            }
            nt.add(t0x_n);
            T.add(nt);
        }
        return T;
    }
}
