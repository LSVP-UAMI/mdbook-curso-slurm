#!/bin/bash
#SBATCH --job-name=array_data
#SBATCH --output=array_%A_%a.out
#SBATCH --error=array_%A_%a.err
#SBATCH --array=1-10                # Diez tareas (de 1 a 10)
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=1
#SBATCH --partition=q1

echo "----------------------------------------"
echo " Iniciando tarea del Job Array "
echo "----------------------------------------"

echo "Job ID: $SLURM_ARRAY_JOB_ID"
echo "Task ID: $SLURM_ARRAY_TASK_ID"

# Cargar entorno Python (ajustar según el clúster)
module load python

# Ejecutar el programa Python con el parámetro correspondiente
python process_data.py $SLURM_ARRAY_TASK_ID

echo "----------------------------------------"
echo " Tarea $SLURM_ARRAY_TASK_ID completada "
echo "----------------------------------------"