package ru.ifmo.methods.nonsence;

import javafx.util.Pair;
import ru.ifmo.data.InitialConditions;
import ru.ifmo.data.Parameters;
import ru.ifmo.methods.Solver;

import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * In the course of time x(t) is getting more similar to f
 */
public class NonMethod implements Solver {

    private final double speed;
    private final Function<Double, Double> f;

    public NonMethod(double speed, Function<Double, Double> f) {
        this.speed = speed;
        this.f = f;
    }

    @Override
    public List<List<Double>> solve(InitialConditions init, int number, Parameters params) {
        BiFunction<Double, Double, Double> strive = (was, striver) -> was + (striver - was) * params.dt * speed;

        UnaryOperator<List<Double>> next = values ->
                Stream.iterate(0, a -> a + 1)
                .limit(values.size())
                .map(k ->
                        strive.apply(values.get(k), f.apply(init.get(k).getKey())))
                .collect(Collectors.toList());

        List<Double> seed = init.data()
                .map(Pair::getValue)
                .collect(Collectors.toList());

        return Stream.iterate(seed, next)
                .limit(number)
                .collect(Collectors.toList());
    }

}
