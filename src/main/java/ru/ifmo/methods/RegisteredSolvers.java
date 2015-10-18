package ru.ifmo.methods;

import ru.ifmo.methods.nonsence.NonMethod;

import java.util.HashMap;
import java.util.Map;

public class RegisteredSolvers {
    public static Map<String, Solver> value = new HashMap<>();

    static {
        value.put("Logarithm striver", new NonMethod(0.1, (a) -> Math.log(a + 1)));
        value.put("Logarithm striver (slow)", new NonMethod(0.02, (a) -> Math.log(a + 1)));
    }

}
