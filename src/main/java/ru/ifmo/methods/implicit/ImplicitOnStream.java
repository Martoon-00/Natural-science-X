package ru.ifmo.methods.implicit;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Pair;
import ru.ifmo.data.Parameters;
import ru.ifmo.methods.Solver;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Alex on 03.11.2015.
 */
public class ImplicitOnStream implements Solver {
	@Override
	public List<List<Double>> solve(InitialConditions init, int number, Parameters params) {
		double s = params.u * params.dt / params.dx;
		double r = params.kappa * params.dt / (params.dx * params.dx);

		double alpha = -r, beta = -(1 - s + 2 * r), gamma = s - r;

		return CommonImplicit.commonSolver(alpha, beta, gamma, init, number, params);
	}
}
