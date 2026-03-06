#!/bin/bash
#SBATCH --job-name=analizar
#SBATCH --output=analizar_%j.out
#SBATCH --time=00:02:00
#SBATCH --partition=q1

echo "=== [Etapa 2] Análisis de datos ==="
sleep 5
echo "Análisis completado con éxito."