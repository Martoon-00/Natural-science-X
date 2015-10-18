package ru.ifmo.data;

import javafx.util.Pair;

import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class InitialConditions implements Iterable<Pair<Double, Double>> {
    private final List<Double> xs;
    private final List<Double> ys;

    public InitialConditions(List<Double> xs, List<Double> ys) {
        if (xs.size() != ys.size())
            throw new IllegalArgumentException("x and y packs have different sizes");

        this.xs = xs;
        this.ys = ys;
    }

    public Pair<Double, Double> get(int index) {
        return new Pair<>(xs.get(index), ys.get(index));
    }

    public Stream<Pair<Double, Double>> data() {
        return StreamSupport.stream(this.spliterator(), false);
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
