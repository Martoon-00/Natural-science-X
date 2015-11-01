package ru.ifmo.data;


import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

/**
 * Defines initial values of T.
 */
public class InitialConditions implements Iterable<Pair<Double, Double>> {
    private final List<Double> xs;
    private final List<Double> ys;

    /**
     * @param xs x's of initial vales. Expected to be members of arithmetic progression with difference of dx
     * @param ys initial values themselves
     */
    public InitialConditions(List<Double> xs, List<Double> ys) {
        if (xs.size() != ys.size())
            throw new IllegalArgumentException("x and y packs have different sizes");

        this.xs = xs;
        this.ys = ys;
    }

    public InitialConditions(double xStart, double xEnd, double xStep, List<Double> ys) {
        xs = Stream.iterate(xStart, a -> a + xStep)
                .limit(ys.size())
                .collect(Collectors.toList());

        Double xLast = xs.get(xs.size() - 1);
        if (Math.abs(xLast - xEnd) > xStep) {
            throw new IllegalStateException(String.format("Expected x end is near %f, but %f gained", xLast, xEnd));
        }
        this.ys = ys;
    }

    public Pair<Double, Double> get(int index) {
        return new Pair<>(xs.get(index), ys.get(index));
    }

    public Stream<Pair<Double, Double>> data() {
        return StreamSupport.stream(this.spliterator(), false);
    }

    public int size() {
        return xs.size();
    }

    @Override
    public Iterator<Pair<Double, Double>> iterator() {
        return new Iterator<Pair<Double, Double>>() {
            private int index = 0;

            @Override
            public boolean hasNext() {
                return index < xs.size();
            }

            @Override
            public Pair<Double, Double> next() {
                return get(index++);
            }
        };
    }
}
