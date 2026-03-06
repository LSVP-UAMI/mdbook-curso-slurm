#!/bin/bash

# Enviar el primer trabajo (preprocesar)
jid1=$(sbatch preprocesar.sh | awk '{print $4}')
echo "Job 1 (preprocesar) enviado con ID: $jid1"

# Enviar el segundo trabajo, depende de que el primero termine correctamente
jid2=$(sbatch --dependency=afterok:$jid1 analizar.sh | awk '{print $4}')
echo "Job 2 (analizar) enviado con ID: $jid2, depende de $jid1"

# Enviar el tercer trabajo, depende del segundo
jid3=$(sbatch --dependency=afterok:$jid2 graficar.sh | awk '{print $4}')
echo "Job 3 (graficar) enviado con ID: $jid3, depende de $jid2"