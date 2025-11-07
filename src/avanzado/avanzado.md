# High Performance Computing (HPC)

El objetivo principal del HPC es procesar grandes volúmenes de datos o ejecutar
simulaciones intensivas (como modelos climáticos, simulaciones físicas, genómica 
o inteligencia artificial).

**Sistema HPC:**

* Múltiples nodos trabajan en paralelo, comunicándose mediante una red 
de alta velocidad.

* Sistema de gestión de trabajos, como Slurm, para asignar tareas y recursos.

* Técnicas de computación paralela para dividir los problemas en partes 
más pequeñas que se ejecutan simultáneamente.
****************************************************************************************************


# Ley de Moore

La Ley de Moore es una observación hecha por Gordon Moore (cofundador de Intel) 
en 1965, que establece que el número de transistores en un chip se duplica 
aproximadamente cada dos años.

![Ley de Moore](./images/ley_moore.jpg)

Aunque esta tendencia se mantuvo durante varias décadas, en los últimos años ha 
comenzado a desacelerarse debido a límites físicos en el tamaño de los transistores 
y problemas de consumo energético y calor.
****************************************************************************************************


# Computación Paralela

Es un modelo de procesamiento en el que varias tareas o cálculos se ejecutan 
simultáneamente, en lugar de hacerlo uno tras otro (como en la computación 
secuencial/serial).

Su objetivo principal es acelerar la ejecución de programas y aprovechar mejor 
los recursos del hardware, especialmente en sistemas con múltiples núcleos o 
procesadores.

El principio básico es: `Un problema grande se divide en partes más pequeñas que 
pueden resolverse al mismo tiempo en diferentes unidades de procesamiento 
(CPU, GPU, nodos de un clúster, etc.).`
	
<center>

**IMAGEN**</center>
	

**Tipos de paralelismo**

* **Paralelismo de datos:** El mismo conjunto de instrucciones se aplica a distintos 
    fragmentos de datos (procesamiento de imágenes o simulaciones).

* **Paralelismo de tareas:** Diferentes tareas o funciones se ejecutan en paralelo 
    (servidores o pipelines).

* **Paralelismo híbrido:** Combina ambos enfoques para aprovechar al máximo los 
    recursos (MPI + OpenMP).

**Ventajas**

- Reduce significativamente el tiempo de ejecución.
- Permite resolver problemas complejos o de gran escala.
- Mejora el aprovechamiento del hardware disponible.

**Desafíos**

- Sincronización y comunicación entre procesos.
- División eficiente del trabajo (no todas las tareas se paralelizan bien).
- 
Sobrecarga de coordinación, que puede limitar el rendimiento.

# Computación Paralela VS Computación Serial

| **Aspecto** | **Serial** | **Paralela** |
|:-----------:|:----------:|:------------:|
| **Definición** | Ejecuta una instrucción a la vez, de forma lineal. | Ejecuta varias instrucciones simultáneamente en diferentes unidades de procesamiento. |
| **Ejecución de tareas** | Cada tarea se completa antes de iniciar la siguiente. | El problema se divide en sub-tareas que se procesan al mismo tiempo. |
| **Velocidad** | Más lenta para problemas grandes o complejos. | Mucho más rápida en tareas que pueden dividirse eficientemente. |
| **Uso de procesadores** | Utiliza un solo procesador o núcleo. | Utiliza múltiples núcleos, procesadores o nodos. |
| **Comunicación entre procesos** | No es necesaria. | Es esencial para coordinar tareas y compartir resultados. |
| **Escalabilidad** | Limitada: mejorar el rendimiento depende de un procesador más rápido. | Alta: el rendimiento puede aumentar añadiendo más procesadores. |
****************************************************************************************************


# Paralelismo Implícito y Explícito

El paralelismo implícito y el paralelismo explícito se refieren a cómo se gestiona la 
ejecución paralela dentro de un programa, es decir, quién decide qué partes del código 
se ejecutan al mismo tiempo: el programador o el sistema (compilador/runtime).

**Paralelismo implícito**

En el paralelismo implícito, el compilador o el sistema se encarga automáticamente de 
detectar las partes del programa que pueden ejecutarse en paralelo.

- El programador no necesita especificar la división de tareas.

- Más fácil de implementar y mantener.

- Reduce errores de sincronización.

- Depende de la capacidad del compilador para identificar paralelismo.


**Paralelismo explícito**

En el paralelismo explícito, el programador define directamente qué partes 
del programa se ejecutan en paralelo y cómo se comunican entre sí.

- Mayor control sobre el rendimiento.

- Requiere más esfuerzo y conocimiento del hardware.

- El programador maneja la sincronización, comunicación y división de tareas.


| **Aspecto** | **Paralelismo Implícito** | **Paralelismo Explícito** |
|-------------|---------------------------|---------------------------|
| **Control** | Lo gestiona el compilador o sistema. | Lo gestiona el programador. |
| **Facilidad de uso** | Más sencillo, automático. | Más complejo, requiere experiencia. |
| **Optimización** | Limitada al análisis del compilador. | Puede alcanzar mayor rendimiento. |
| **Flexibilidad** |Menor. | Mayor (control detallado de recursos). |
****************************************************************************************************


# Memoria Compartida (Paralelismo Implícito?)

Es un modelo de programación paralela en el que varios procesadores o hilos 
acceden al mismo espacio de memoria para leer y escribir datos.
Todos los procesos comparten una única copia de las variables, lo que 
facilita la comunicación y el intercambio de información entre ellos.

- Todos los hilos o procesadores ven el mismo contenido de memoria.

- La comunicación entre tareas se realiza mediante variables compartidas, 
no por paso de mensajes.

- Requiere mecanismos de sincronización (como mutex, semaforos o barreras) 
para evitar conflictos cuando varios hilos modifican los mismos datos.

**Ventajas**

- Comunicación rápida y directa entre tareas.

- Modelo más sencillo de programar en comparación con el paso de mensajes.

- Ideal para sistemas multinúcleo o multiprocesador con memoria común.

**Desventajas**

- Difícil de escalar a muchos procesadores (por problemas de coherencia de caché).

- Riesgo de condiciones de carrera si no se sincroniza correctamente el acceso a los datos.

- Menor portabilidad a sistemas distribuidos (donde cada nodo tiene su propia memoria).

************************************************************************************************


# OpenMP

OpenMP (Open Multi-Processing) es una API que permite escribir programas 
paralelos de memoria compartida de forma sencilla, principalmente en 
C, C++ y Fortran.

Diseñada para aprovechar los procesadores multinúcleo y facilitar la programación 
paralela sin necesidad de manejar directamente hilos o sincronización compleja.

* Basada en directivas del compilador (comentarios especiales que indican qué 
partes del código deben ejecutarse en paralelo).

* Utiliza threads (hilos) para dividir el trabajo entre los núcleos disponibles.

* Permite controlar fácilmente la creación de hilos, la distribución de trabajo 
y la sincronización.


**Ventajas**

* Fácil de usar: se agregan pocas líneas de código al programa secuencial.

* Portátil: funciona en distintos sistemas y compiladores compatibles.

* Escalable: permite ajustar el número de hilos según los recursos disponibles.


**Usos comunes**

* Simulaciones científicas.

* Procesamiento de datos o imágenes.

* Aplicaciones de ingeniería y física.

****************************************************************************************************


## **ACTIVIDAD**

****************************************************************************************************


# Memoria Distribuida (Paralelismo Explícito?)

La memoria distribuida es un modelo de computación paralela en el que cada 
procesador o nodo tiene su propia memoria local, en lugar de compartir un 
espacio de memoria común.

En este enfoque, los procesos deben comunicarse explícitamente entre sí 
para intercambiar datos, normalmente usando mensajes a través de la red 
que conecta los nodos.

* Cada nodo tiene su propia memoria privada; no hay acceso directo a la 
memoria de otros nodos.

* La comunicación entre procesos se realiza mediante mensaje-paso (MPI).

* Escala fácilmente a muchos nodos porque cada uno maneja su memoria de 
forma independiente.


**Ventajas**

* Permite construir sistemas muy grandes y escalables (clústeres con cientos 
o miles de nodos).

* Reduce problemas de coherencia de caché presentes en memoria compartida.

* Cada nodo puede trabajar de manera independiente hasta que necesita 
intercambiar información.


**Desventajas**

* Requiere que el programador maneje comunicación explícita, lo que aumenta 
la complejidad del código.

* Mayor latencia de comunicación comparado con la memoria compartida.

* Sincronización y transferencia de datos deben planearse cuidadosamente 
para no afectar el rendimiento.

****************************************************************************************************


# MPI

MPI es un estándar de programación paralela diseñado para sistemas con memoria distribuida, 

* Basado en el modelo de paso de mensajes (“message passing”).

* Permite que varios procesos trabajen de forma colaborativa y sincronizada.

* Los procesos pueden estar en una misma máquina o distribuidos en diferentes nodos de 
un clúster.

* Es portable y funciona en múltiples plataformas y arquitecturas.


| **Funciones** | **Descrpción**| 
|:-------------:|---------------|
| `MPI_Init / MPI_Finalize` | Inicializan y finalizan el entorno MPI. |
| `MPI_Comm_size` | Obtiene el número total de procesos. |  
| `MPI_Comm_rank`| Identifica el número (rank) del proceso actual. |
| `MPI_Send / MPI_Recv` | Permiten enviar y recibir mensajes entre procesos. |
| `MPI_Bcast, MPI_Reduce, MPI_Gather` | Permiten comunicación colectiva (entre todos los procesos del grupo). |

**Ventajas**

* Alta escalabilidad, ideal para sistemas con muchos nodos.

* Gran control sobre la comunicación entre procesos.

* Eficiente para problemas que requieren distribuir grandes volúmenes de datos o cálculos.

**Desventajas**

* La programación es más compleja que en modelos de memoria compartida (como OpenMP).

* Se requiere diseñar la comunicación explícita entre procesos.

* Mayor latencia de comunicación por el uso de red.

****************************************************************************************************

## **ACTIVIDAD**

****************************************************************************************************

# Memoria Híbrida (MPI + OpenMP)

Combina programación de memoria distribuida (MPI) y de memoria compartida (OpenMP).

* **MPI para la comunicación entre nodos:** Se crean procesos MPI separados para cada nodo 
de un clúster. Estos procesos se comunican entre sí enviando y recibiendo mensajes.

* **OpenMP para la paralelización dentro de los nodos:** Dentro de cada proceso MPI, se 
pueden crear múltiples hilos utilizando OpenMP. Estos hilos comparten la memoria del 
nodo y ejecutan tareas en paralelo.

* **Configuración de hilos/procesos:** La configuración se suele hacer estableciendo la 
cantidad de procesos MPI por nodo (usando `#SBATCH --ntasks-per-node` en un trabajo de 
SLURM) y luego la cantidad de hilos OpenMP por proceso MPI (por ejemplo, 
usando la variable de entorno `OMP_NUM_THREADS` o el parámetro `#SBATCH --cpus-per-task`). 


**En otras palabras:** Cada nodo ejecuta uno o varios procesos MPI, y dentro de cada 
proceso se crean varios hilos OpenMP para paralelizar el trabajo.

**Ejemplo**

Imagina un clúster con 4 nodos, cada uno con 8 núcleos:

* Ejecutas 4 procesos MPI (uno por nodo). (Dividir el problema en procesos)

* Dentro de cada proceso, se crean 8 hilos OpenMP (uno por núcleo). (Divides el trabajo de cada proceso en varios hilos)

Así, en total se utilizan 32 hilos en paralelo, combinando ambos modelos.	


**Ventajas**

* Mejor aprovechamiento del hardware.
* Menor comunicación entre nodos que usando solo MPI.
* Permite reducir la sobrecarga de comunicación y optimizar el uso de memoria compartida.
* Escalable a sistemas masivos con miles de núcleos.


**Desventajas**

* Mayor complejidad en la programación y depuración.
* Se requiere balancear adecuadamente el número de procesos MPI y los hilos OpenMP.
* El rendimiento depende fuertemente de la arquitectura del clúster y la configuración de Slurm.

****************************************************************************************************


## **ACTIVIDAD**

****************************************************************************************************

# **TRABAJOS PARALELOS (GPU)**

# Job Arrays

Un Job Array (o arreglo de trabajos) es una forma de enviar múltiples trabajos similares al 
mismo tiempo con un solo comando o script de envío.

Se utiliza cuando necesitas ejecutar el mismo programa varias veces pero con parámetros 
diferentes, o simplemente para procesar muchos archivos o tareas en paralelo.

**Idea principal:** En lugar de enviar 100 trabajos individuales con sbatch, puedes enviar 
un solo Job Array que contenga 100 elementos.
Cada elemento del arreglo se ejecuta como un trabajo independiente, con su propio ID, variables 
de entorno y salida.

```bash
    # Sintaxis básica
    $SBATCH --array=0-9

Este ejemplo crea 10 tareas (de 0 a 9).
```



```bash
Cada una tendrá una variable de entorno especial:

    # ID del trabajo principal
    $SLURM_ARRAY_JOB_ID 

    # ID del elemento dentro del arreglo  
    $SLURM_ARRAY_TASK_ID  
```

| **Concepto** | **Descripción** |
|:------------:|:---------------:|
| `--array=0-9` | Define los índices del arreglo |
| `$SLURM_ARRAY_JOB_ID` | ID del trabajo principal |
| `$SLURM_ARRAY_TASK_ID` | ID individual de cada tarea |
| `--array=0-99%10` | Ejecuta 100 tareas, máximo 10 a la vez |
| Ventaja | Ejecutar muchas tareas similares en paralelo fácilmente |

****************************************************************************************************


## **ACTIVIDAD**

****************************************************************************************************


# Dependencia de Trabajos

La dependencia de trabajos permite controlar el orden de ejecución entre varios 
jobs, de modo que un trabajo no comience hasta que otro haya terminado o cumpla 
cierta condición.

**Tipos de dependencias**

Se definen con la opción `--dependency` al enviar un trabajo con sbatch.

| **Dependencia** | **Descripción** | **Ejemplo** |
|:---------------:|:---------------:|:-----------:|
| `after:jobid` | El trabajo se ejecuta después de que el indicado haya iniciado. | --dependency=after:12345
| `afterok:jobid` | Se ejecuta solo si el trabajo indicado terminó correctamente (exit code 0). | --dependency=afterok:12345
| `afternotok:jobid` | Se ejecuta solo si el trabajo anterior falló. | --dependency=afternotok:12345
| `afterany:jobid` | Se ejecuta después de que el trabajo termine, sin importar si fue exitoso o no. | --dependency=afterany:12345
| `singleton` | Asegura que solo un trabajo con el mismo nombre se ejecute a la vez. | --dependency=singleton

**Ejemplo**
```bash
#Supón que tienes tres trabajos:

    #preprocesar.sh
    #analizar.sh
    #graficar.sh

#1. Primero ejecutas el trabajo de preprocesamiento:
    jid1=$(sbatch preprocesar.sh | awk '{print $4}')

#2. Luego envías el segundo trabajo con dependencia:
    jid2=$(sbatch --dependency=afterok:$jid1 analizar.sh | awk '{print $4}')

#3. Y finalmente: 
    sbatch --dependency=afterok:$jid2 graficar.sh

#4. Asi, slurm gestionará automáticamente el orden: 
    preprocesar.sh → analizar.sh → graficar.sh
```

## **ACTIVIDAD?**

# Programación de trabajos
