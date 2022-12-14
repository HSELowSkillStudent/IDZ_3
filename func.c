#define ACCURACY 0.0005

double func(double x, double a, double sign) {
    double result = x;
    double x_i = x; // i-й член последовательности
    double i = 0;

    while (x_i > ACCURACY || x_i < -ACCURACY) {  // пока i-й член последовательности по модулю больше точности
        // это магия оптимизаций, чтобы не было переполнений во время
        // вычисления факториала(потому что его тут не будет)
        // i-й член последовательности отличается от предыдущего
        // следующим образом: x_i = x_(i-1) * (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
        x_i *= (-1) * x * x / ((2 * i + 2) * (2 * i + 3));
        result += x_i;
        i++;
    }

    return result;
}
