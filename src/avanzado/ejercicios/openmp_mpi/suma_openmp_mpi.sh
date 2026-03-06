#!/bin/bash
#SBATCH --job-name=suma_hibrida
#SBATCH --output=suma_hibrida_%j.out
#SBATCH --error=suma_hibrida_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=4
#SBATCH --time=00:05:00
#SBATCH --partition=q1

echo "----------------------------------------"
echo " Cargando entorno MPI y configurando OpenMP "
echo "----------------------------------------"

module load mpi
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

echo "Compilando el programa híbrido..."
mpicc -fopenmp -O2 -o hybrid_sum hybrid_sum.c

echo "----------------------------------------"
echo " Ejecutando con:"
echo " Nodos: $SLURM_JOB_NUM_NODES"
echo " Procesos MPI por nodo: $SLURM_NTASKS_PER_NODE"
echo " Hilos OpenMP por proceso: $OMP_NUM_THREADS"
echo "----------------------------------------"

srun ./hybrid_sum

echo "----------------------------------------"
echo "Ejecución completada"