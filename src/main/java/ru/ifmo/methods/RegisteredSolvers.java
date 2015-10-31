package ru.ifmo.methods;

import ru.ifmo.methods.nonsence.LolApproximator;

import java.util.Map;
import java.util.TreeMap;

public class RegisteredSolvers {
    public static Map<String, Solver> solvers = new TreeMap<>();

    static {
        solvers.put("Logarithm striver", new LolApproximator(0.1, (a) -> Math.log(a + 1)));
        solvers.put("Logarithm striver (slow)", new LolApproximator(0.02, (a) -> Math.log(a + 1)));
        solvers.put("Power 2", new LolApproximator(0.1, a -> a * a));
        solvers.put("Square 2", new LolApproximator(0.1, a -> Math.pow(a, 0.5)));
        solvers.put("Tan", new LolApproximator(0.1, Math::tan));
        solvers.put("Fluctuations", new LolApproximator(1e-3, a -> Math.exp(a * 5) * 10000 * Math.sin(a * 20)));
        solvers.put("Explicit up stream", new ExplicitUpStream());
        solvers.put("Explicit down stream", new ExplicitDownStream());
    }

}
