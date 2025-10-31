#!/bin/bash
#SBATCH --job-name=openmp_sum          # Nombre del trabajo
#SBATCH --output=openmp_sum_%j.out     # Archivo de salida (%j = ID del trabajo)
#SBATCH --error=openmp_sum_%j.err      # Archivo de error
#SBATCH --ntasks=1                     # Ejecutar una sola tarea
#SBATCH --cpus-per-task=8              # Número de hilos (CPU por tarea)
#SBATCH --time=00:03:00                # Tiempo máximo de ejecución
#SBATCH --partition=general            # Cola/partición del clúster
#SBATCH --mail-type=END,FAIL           # Notificación al terminar/fallar (opcional)
#SBATCH --mail-user=tu_correo@dominio.com  # Cambia por tu correo (opcional)

echo "-----------------------------------------"
echo " Cargando módulo de compilador GCC "
echo "-----------------------------------------"

# Cargar el módulo del compilador con soporte para OpenMP
module load gcc

echo "Compilando el programa..."
gcc -fopenmp -O2 -o sum_array sum_array.c

echo "-----------------------------------------"
echo " Ejecutando el programa con $SLURM_CPUS_PER_TASK hilos "
echo "-----------------------------------------"

# Exportar número de hilos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Ejecutar el programa
./sum_array

echo "-----------------------------------------"
echo "Ejecución finalizada"
