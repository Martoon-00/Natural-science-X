package ru.ifmo.data;

public class Range {
    public final double left;
    public final double right;

    public Range(double left, double right) {
        if (left > right)
            throw new IllegalStateException(String.format("Left must be lesser than right, but %s > %s", left, right));

        this.left = left;
        this.right = right;
    }
}
