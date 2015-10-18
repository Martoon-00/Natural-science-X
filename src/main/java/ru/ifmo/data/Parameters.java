package ru.ifmo.data;

public class Parameters {
    public final double dt;
    public final double dx;
    public final double u;
    public final double kappa;

    public Parameters(double dt, double dx, double u, double kappa) {
        this.dt = dt;
        this.dx = dx;
        this.u = u;
        this.kappa = kappa;
    }
}
