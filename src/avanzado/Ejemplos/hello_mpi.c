#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    int world_size, world_rank, name_len;
    char processor_name[MPI_MAX_PROCESSOR_NAME];

    // Inicializa el entorno MPI
    MPI_Init(&argc, &argv);

    // Obtiene el número total de procesos
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    // Obtiene el ID del proceso actual
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    // Obtiene el nombre del nodo donde se ejecuta
    MPI_Get_processor_name(processor_name, &name_len);

    printf("Hola desde el proceso %d de %d, ejecutándose en %s\n",
           world_rank, world_size, processor_name);

    // Finaliza el entorno MPI
    MPI_Finalize();
    return 0;
}
