#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 100000000  // Tamaño del arreglo (100 millones)

int main() {
    double *array = (double*) malloc(N * sizeof(double));
    double sum = 0.0;
    double start_time, end_time;

    // Inicializa el arreglo
    for (long i = 0; i < N; i++) {
        array[i] = 1.0;  // Valor fijo para validar el resultado fácilmente
    }

    start_time = omp_get_wtime();

    // Región paralela con reducción
    #pragma omp parallel for reduction(+:sum)
    for (long i = 0; i < N; i++) {
        sum += array[i];
    }

    end_time = omp_get_wtime();

    printf("Suma total = %.2f\n", sum);
    printf("Tiempo de ejecución: %.4f segundos\n", end_time - start_time);
    printf("Número de hilos usados: %d\n", omp_get_max_threads());

    free(array);
    return 0;
}


