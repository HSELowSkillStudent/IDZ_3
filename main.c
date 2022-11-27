#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double func(double x, int a, int sign);
double func1(double x, int a, int sign);
double fact(double a);

double get_normal_degree(double degree) {
    degree = fmod(degree, 2*M_PI);
    return degree;
}

void random_input() {
    double a = rand() % 360;
    a = get_normal_degree(a);
    printf("Сгенерированное число: %f радиан\nSin(%f) = %f\n", a, a, func(a, 1, 0));
}

void file_input(char input_name[], char output_name[]) {
    FILE *input_file, *output_file;
    input_file = fopen(input_name, "r");
    double x, a, result;
    fscanf(input_file, "%lf", &x);
    fclose(input_file);
    a = get_normal_degree(x);
    result = func(a, 1, 0);

    output_file = fopen(output_name, "w");
    fprintf(output_file, "Sin(%f) = Sin(%f) = %f\n", x, a, result);
}

void arg_input(char *argv[]) {
    double x, a, result;
    x = atof(argv[1]);
    a = get_normal_degree(x);
    result = func(a, 1, 0);
    printf("Sin(%f) = Sin(%f) = %f\n", x, a, result);
}

void def_input() {
    printf("Введите градус угла(в радианах):\n");
    double x, a, result;
    scanf("%lf", &x);
    a = get_normal_degree(x);
    result = func(a, 1, 0);
    printf("Sin(%f) = Sin(%f) = %f\n", x, a, result);
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    if (argc == 1) {
        // вызов функции, взаимодействей с консолью
        def_input();
    } else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
        printf("keys:\n-h (--help)  - displays a list of keys\n-r [int] (--random [int])  - sets a random data set. \n-f [string] [string] (--file [string] [string])  - the program works with files entered by the following two arguments\n");
    } else if (!strcmp(argv[1], "-r") || !strcmp(argv[1], "--random")) {
        // вызов функции, задающей массив, а через генератор случайных чисел. Размер задается после флага
        random_input();
    } else if (!strcmp(argv[1], "-f") || !strcmp(argv[1], "--file")) {
        // работа с файлами
        file_input(argv[2], argv[3]);
    } else {
        // работа с аргументами
        // file_input(argv[2], argv[3]);
        arg_input(argv);
    }
    return 0;
}

