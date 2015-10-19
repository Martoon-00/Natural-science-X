package ru.ifmo.methods;

import ru.ifmo.methods.nonsence.LolAppriximator;

import java.util.Map;
import java.util.TreeMap;

public class RegisteredSolvers {
    public static Map<String, Solver> value = new TreeMap<>();

    static {
        value.put("Logarithm striver", new LolAppriximator(0.1, (a) -> Math.log(a + 1)));
        value.put("Logarithm striver (slow)", new LolAppriximator(0.02, (a) -> Math.log(a + 1)));
        value.put("Power 2", new LolAppriximator(0.1, a -> a * a));
        value.put("Power 7", new LolAppriximator(0.1, a -> Math.pow(a, 7)));
        value.put("Square 2", new LolAppriximator(0.1, a -> Math.pow(a, 0.5)));
    }

}
