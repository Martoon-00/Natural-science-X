package ru.ifmo.methods;

import ru.ifmo.methods.nonsence.LolAppriximator;

import java.util.Map;
import java.util.TreeMap;

public class RegisteredSolvers {
    public static Map<String, Solver> solvers = new TreeMap<>();

    static {
        solvers.put("Logarithm striver", new LolAppriximator(0.1, (a) -> Math.log(a + 1)));
        solvers.put("Logarithm striver (slow)", new LolAppriximator(0.02, (a) -> Math.log(a + 1)));
        solvers.put("Power 2", new LolAppriximator(0.1, a -> a * a));
        solvers.put("Square 2", new LolAppriximator(0.1, a -> Math.pow(a, 0.5)));
    }

}
