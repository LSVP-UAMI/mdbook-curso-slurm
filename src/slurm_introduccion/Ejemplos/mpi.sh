#!/bin/bash
#SBATCH --job-name=mpi_hello           # Nombre del trabajo
#SBATCH --output=mpi_hello_%j.out      # Archivo de salida (%j = ID del job)
#SBATCH --error=mpi_hello_%j.err       # Archivo de errores
#SBATCH --ntasks=4                     # Número total de procesos MPI
#SBATCH --cpus-per-task=1              # CPUs por proceso (1 en este caso)
#SBATCH --time=00:02:00                # Tiempo máximo
#SBATCH --partition=general            # Cola/partición (ajustar según el clúster)
#SBATCH --mail-type=END,FAIL           # Notificar al terminar o fallar (opcional)
#SBATCH --mail-user=tu_correo@dominio.com  # Cambia por tu correo (opcional)

echo "----------------------------------------"
echo " Cargando módulo de entorno MPI "
echo "----------------------------------------"

# Cargar el módulo MPI disponible en el sistema
module load mpi

echo "Compilando el programa..."
mpicc -O2 -o hello_mpi hello_mpi.c

echo "----------------------------------------"
echo " Ejecutando el programa con $SLURM_NTASKS procesos MPI "
echo "----------------------------------------"

srun ./hello_mpi

echo "----------------------------------------"
echo "Ejecución completada"
