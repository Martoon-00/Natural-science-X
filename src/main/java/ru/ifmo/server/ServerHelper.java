package ru.ifmo.server;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class ServerHelper {
    public static String solutionToString(List<List<Double>> solution) {
        return solution.stream()
                .map(xr -> xr.stream()
                                .map(String::valueOf)
                                .collect(Collectors.joining(" "))
                ).collect(Collectors.joining("\n"));
    }

    public static List<Double> parseDoubles(String s) {
        return Arrays.stream(s.split(","))
                .map(Double::parseDouble)
                .collect(Collectors.toList());
    }

}
