#!/bin/bash

#SBATCH --job-name=cpu_test
#SBATCH --partition=q1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=omar4jrz@gmail.com
#SBATCH --mail-type=BEGIN

#SBATCH --output=salida_%j.out
#SBATCH --error=error_%j.out
#SBATCH --time=03:00

echo "Inicio de la prueba en :$(hostname)"
echo "Hora de inicio: $(date)"

# Ejecuta una tarea que ocupa el 100% de CPU.
yes > /dev/null

echo "Hora de finalización: $(date)"