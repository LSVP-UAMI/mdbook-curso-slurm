#!/usr/bin/env python3
import sys
import time
import random

# Obtener el parámetro de entrada
if len(sys.argv) != 2:
    print("Uso: python process_data.py <valor>")
    sys.exit(1)

valor = int(sys.argv[1])

# Simular un cálculo o procesamiento
print(f"[Inicio] Ejecutando tarea con valor = {valor}")
time.sleep(random.uniform(1, 3))  # Simula un tiempo de cómputo variable
resultado = valor ** 2  # Ejemplo simple: calcular el cuadrado del valor
print(f"[Fin] Resultado de {valor}^2 = {resultado}")