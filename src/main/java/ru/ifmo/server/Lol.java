package ru.ifmo.server;

import java.util.function.Function;

public class Lol {
    public static void main(String[] args) {
        Function<Integer, String> countAndWrite = make(
                (k) -> (double) k / 20,
                (r) -> "Counting result: " + r
        );

        System.out.println(countAndWrite.apply(10));
    }

    private static Function<Integer, String> make(
            Function<Integer, Double> counter,
            Function<Double, String> writer
    ) {
        // возвращаем функцию ожидающую k, на основе которого высчитываем ответ
        return k -> {
            Double countResult = counter.apply(k);
            return writer.apply(countResult);
        };
    }
}
