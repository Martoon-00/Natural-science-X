package ru.ifmo.methods;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Parameters;

import java.util.List;

public interface Solver {
    List<List<Double>> solve(InitialConditions init, int number, Parameters params);
}
