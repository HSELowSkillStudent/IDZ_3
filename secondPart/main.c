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

double random_input() {
    double a = rand() % 360;
    a = get_normal_degree(a);
    return a;
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    long long start, end;
    for (int i = 0; i < 10; i++) {
        printf("test %d\n", i);
        double input = random_input();
        start = time(NULL);
        for (int j = 0; j < 500000000; j++) {
            func(input, 1, 0);
        }
        end = time(NULL);
        
        printf("\tunoptimized function time:\t%lld\n", (end - start) % 1000);
        start = time(NULL);
        for (int j = 0; j < 500000000; j++) {
            func(input, 1, 0);
        }
        end = time(NULL);
        printf("\toptimized function time:  \t%lld\n\n", (end - start) % 1000);
        
    }
    
    return 0;
}

