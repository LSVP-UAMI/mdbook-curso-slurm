#!/bin/bash
    
#SBATCH --job-name=sumlist
#SBATCH --partition=q1
#SBATCH --cpus-per-task=1
#SBATCH --output=salida_%j.out
#SBATCH --error=error_%j.out
#SBATCH --time=00:05:00

module purge
module load python/3.12

echo "iniciando trabajo en$(hostname)"
echo "Hora de inicio: $(date)"

python3 suma_lista.py

echo " "
echo "Hora de finalización: $(date)"