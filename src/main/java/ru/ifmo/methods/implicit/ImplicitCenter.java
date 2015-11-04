package ru.ifmo.methods.implicit;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Parameters;
import ru.ifmo.methods.Solver;

import java.util.List;

/**
 * Created by Alex on 04.11.2015.
 */
public class ImplicitCenter implements Solver {
	@Override
	public List<List<Double>> solve(InitialConditions init, int number, Parameters params) {
		double s = params.u * params.dt / params.dx;
		double r = params.kappa * params.dt / (params.dx * params.dx);

		double alpha = -(r + (s/2)), beta = -(1 + 2 * r), gamma = -(r - (s / 2));

		return CommonImplicit.commonSolver(alpha,beta,gamma,init,number,params);
	}
}
