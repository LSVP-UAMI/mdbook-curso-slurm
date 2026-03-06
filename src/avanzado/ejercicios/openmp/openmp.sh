#!/bin/bash
#SBATCH --job-name=suma_openmp        # Nombre del trabajo
#SBATCH --output=suma_openmp_%j.out   # Archivo de salida (%j = ID del trabajo)
#SBATCH --error=suma_openmp_%j.err    # Archivo de error
#SBATCH --ntasks=1                    # Ejecutar una sola tarea
#SBATCH --cpus-per-task=8             # Número de hilos (CPU por tarea)
#SBATCH --time=00:03:00               # Tiempo máximo de ejecución
#SBATCH --partition=q1                # Cola/partición del clúster


echo "-----------------------------------------"
echo " Cargando módulo de compilador GCC "
echo "-----------------------------------------"

# Cargar el módulo del compilador con soporte para OpenMP
module load gcc/12.1.0

echo "Compilando el programa..."
gcc -fopenmp array_openmp.c -o array_openmp

echo "-----------------------------------------"
echo " Ejecutando el programa con $SLURM_CPUS_PER_TASK hilos "
echo "-----------------------------------------"

# Exportar número de hilos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Ejecutar el programa
./array_openmp

echo "-----------------------------------------"
echo "Ejecución finalizada"
