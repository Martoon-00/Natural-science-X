package ru.ifmo.methods.implicit;

import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Pair;
import ru.ifmo.data.Parameters;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Alex on 04.11.2015.
 * http://mathhelpplanet.com/static.php?p=chislennyye-metody-resheniya-slau
 * Метод прогонки
 * Alpha, Beta, Gamma - одинаковые
 */
public class CommonImplicit {
	static List<List<Double>> commonSolver(double alpha, double beta, double gamma, InitialConditions init, int number, Parameters params) {
		List<List<Double>> T = new ArrayList<>();
		List<Double> initial = new ArrayList<>();
		for (Pair<Double, Double> pair : init) {
			initial.add(pair.getValue());
		}
		T.add(initial);
		int size = init.size();
		double s = params.u * params.dt / params.dx;
		double r = params.kappa * params.dt / (params.dx * params.dx);

		for (int n = 0; n < number; n++) {
			List<Double> ts = new ArrayList<>();
			double[] p = new double[size - 1], q = new double[size - 2];
			p[0] = gamma / beta;
			q[0] = -T.get(n).get(0) / beta;
			for (int i = 1; i < size - 1; i++) {
				p[i] = gamma / (beta - alpha * p[i-1]);
				q[i] = (alpha * q[i-1] - T.get(n).get(i)) / (beta - alpha * p[i-1]);
			}
			double x = (alpha * q[size-2] - T.get(n).get(size -1))/(beta - alpha * p[size-2]);

			ts.add(0,x);
			for (int i = size - 2; i >= 0; i--) {
				x = p[i]*x + q[i];
				ts.add(0,x);
			}

			T.add(ts);
		}

		return T;
	}
}
