#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

#define N 100000000  // Tamaño total del arreglo (100 millones)

int main(int argc, char *argv[]) {
    int rank, size;
    double local_sum = 0.0, global_sum = 0.0;
    double start_time, end_time;

    // Inicialización MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Dividir el trabajo entre procesos
    long chunk_size = N / size;
    long start = rank * chunk_size;
    long end = (rank == size - 1) ? N : start + chunk_size;

    double *array = (double*) malloc(chunk_size * sizeof(double));

    // Inicializar los valores del arreglo local
    for (long i = 0; i < chunk_size; i++) {
        array[i] = 1.0;  // Valor fijo para validar fácilmente la suma
    }

    MPI_Barrier(MPI_COMM_WORLD); // Sincronizar antes de medir el tiempo
    start_time = MPI_Wtime();

    // Calcular suma local con OpenMP (memoria compartida)
    #pragma omp parallel for reduction(+:local_sum)
    for (long i = 0; i < chunk_size; i++) {
        local_sum += array[i];
    }

    // Combinar los resultados de todos los procesos (memoria distribuida)
    MPI_Reduce(&local_sum, &global_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    end_time = MPI_Wtime();

    // Solo el proceso 0 imprime el resultado final
    if (rank == 0) {
        printf("Suma total = %.2f\n", global_sum);
        printf("Tiempo total: %.4f segundos\n", end_time - start_time);
        printf("Procesos MPI: %d | Hilos OpenMP por proceso: %d\n",
               size, omp_get_max_threads());
    }

    free(array);
    MPI_Finalize();
    return 0;
}