#!/bin/bash
#SBATCH --job-name=procesar
#SBATCH --output=preprocesar_%j.out
#SBATCH --time=00:02:00
#SBATCH --partition=q1

echo "=== [Etapa 1] Preprocesamiento de datos ==="
sleep 5
echo "Datos preprocesados correctamente."