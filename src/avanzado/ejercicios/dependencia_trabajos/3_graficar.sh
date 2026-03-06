#!/bin/bash
#SBATCH --job-name=graficar
#SBATCH --output=graficar_%j.out
#SBATCH --time=00:02:00
#SBATCH --partition=q1

echo "=== [Etapa 3] Generación de gráficas ==="
sleep 5
echo "Gráficas generadas exitosamente."