package ru.ifmo.methods;

import ru.ifmo.methods.implicit.ImplicitCenter;
import ru.ifmo.methods.implicit.ImplicitFromStream;
import ru.ifmo.methods.implicit.ImplicitOnStream;
import ru.ifmo.methods.nonsence.LolApproximator;

import java.util.Map;
import java.util.TreeMap;

public class RegisteredSolvers {
    public static Map<String, Solver> solvers = new TreeMap<>();

    static {
        solvers.put("Fluctuations", new LolApproximator(1e-3, a -> Math.exp(a * 5) * 10000 * Math.sin(a * 20)));
        solvers.put("Explicit up stream", new ExplicitUpStream());
        solvers.put("Explicit down stream", new ExplicitDownStream());
        solvers.put("Chekharda", new Chekharda());
        solvers.put("ImplicitFromStream", new ImplicitFromStream());
        solvers.put("ImplicitOnStream", new ImplicitOnStream());
        solvers.put("ImplicitCentral", new ImplicitCenter());
    }

}
