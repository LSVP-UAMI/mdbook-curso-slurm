# Uso de módulos

Las aplicaciones en el clúster Yoltla están disponibles mediante la herramienta `Modules`.

## Listar los módulos del clúster

Para listar los módulos del clúster, utilice el comando `module` seguido del subcomando `avail`:
```
module avail
```
A continuación se muestra de manera parcial la salida de este comando:
```
[pepe@yoltla0 ~]$ module avail
----------------------------- /LUSTRE/yoltla/nc/mf -----------------------------
compilers/gcc/5.4.0
compilers/intel/2013/u1/xe-13.2.144
.
.
.
tools/tmux/2.0
tools/vmd/1.9.2

---------------------------- /LUSTRE/yoltla/gpu/mf -----------------------------
compilers/cuda/5.0
compilers/cuda/5.5
.
.
.
cuda/7.5/intel/15.2.164/impi/5.0.3.48/gromacs/5.0.7-s
cuda/7.5/intel/15.6.232/impi/5.0.3.49/gromacs/5.1.4-s

--------------------------- /LUSTRE/yoltla/modules/ ----------------------------
abinit/8.4.1                 namd/2.13
amber/ambertools19           namd/2.13-CUDA
.                            .
.                            .
.                            .
namd/2.12-CUDA               wien2k/19.1
namd/2.12-GIT-CUDA           xtb/6.2.3
```

```admonish warning title="IMPORTANTE"
Para hacer uso de los módulos del clúster es necesario cargarlos.
```

## Cargar un módulo

Para cargar un módulo, utilice el comando `module` seguido del subcomando `load` y el 
nombre del módulo a cargar:
```
module load <módulo>
```

Al utilizar este comando no obtendrá ningún mensaje por parte del sistema.

Por ejemplo, para cargar el modulo *intel/impi-2017u4*, ejecute el comando:
```
[pepe@yoltla0 ~]$ module load intel/impi-2017u4
```

```admonish note title="NOTA"
Los módulos sólo se cargan en la sesión actual del usuario.
```

## Listar los módulos cargados

Para listar todos los módulos cargados, utilice el comando `module` seguido del subcomando `list`:
```
module list
```
Por ejemplo, el usuario pepe tiene cargados los siguientes módulos:
```
[pepe@yoltla0 ~]$ module list
Currently Loaded Modulefiles:
  1) /intel/compilers-2017u4
  2) /python/intel/2.7
  3) /singularity/evolinc-i/5.0
```

```admonish note title="NOTA"
En caso de no tener módulos cargados obtendrá el siguiente mensaje por parte del sistema:

    No Modulefiles Currently Loaded.
```

## Descargar un módulo

Para descarga un módulo, utilice el comando `module` seguido del subcomando `unload` y 
el nombre del módulo a descargar:
```
module unload <módulo>
```
Al utilizar este comando no obtendrá ningún mensaje por parte del sistema.

Por ejemplo, para descargar el módulo *intel/impi-2017u4*, ejecute el comando:
```
[pepe@yoltla0 ~]$ module unload intel/impi-2017u4
```

## Descargar todos los módulos cargados

Para descargar todos los módulos cargados, utilice el comando `module` seguido del 
subcomando `purge`:
```
module purge
```

Al utilizar este comando no obtendrá ningún mensaje por parte del sistema.

Por ejemplo, el usuario pepe tiene cargados los siguientes módulos:
```
[pepe@yoltla0 ~]$ module list
Currently Loaded Modulefiles:
  1) /intel/compilers-2017u4
  2) /python/intel/2.7
  3) /singularity/evolinc-i/5.0
```

Al ejecutar el comando:
```
[pepe@yoltla0 ~]$ module purge
```

Y volver a comprobar los módulos cargados, se obtiene el siguiente mensaje:
```
[pepe@yoltla0 ~]$ module list
No Modulefiles Currently Loaded.
```

><center>
>
>**Actividad**
>
></center>
>
>Descarga el Archivo `suma_lista.py` y crea un scritp que tenga lo siguiente:
>
>* Asignar un nombre al trabajo
>* Se ejecute en la partición `q1`.
>* Cada trabajo reserva un único core.
>* Crea archivo de salida y error con el ID del trabajo.
>* El tiempo máximo de ejecución sea 5 minutos.
>* Descargue todos los módulos.
>* Cargue el modulo py.
>
>Agrega lo siguiente al final y ejeucta el script.
>
>```bash
>echo "iniciando trabajo en$(hostname)"
>echo "Hora de inicio: $(date)"
>
>python3 suma_lista.py
>
>echo " "
>echo "Hora de finalización: $(date)"
>```
>


# Cuota de discos?

# Eficiencia Computacional

En computación de alto rendimiento, cuando paralelizamos un programa 
(correr con varios CPUs), queremos saber si realmente estamos obteniendo 
una mejora significativa.

Para esto se utilizan doms métricas fundamentales
* **SpeedUp**

* **Eficiencia**

## SpeedUp

El SpeedUp mide cuánto más rápido corre un programa al usar múltiples CPUs en comparación con una sola CPU.

La fórmula es:

<center>

   ![SpeedUp](./images/speedup.png)
   
</center>

donde: 
   * T1 = tiempo de ejecución con 1 CPU
   * Tn = timepo de ejecución con N CPU

Que se interpreta de la siguiente manera:
* *SpeedUP* = 1, No hay mejora
* *SpeedUp* = 2, El programa es el doble de rápido
* *SpeedUp ideal* = N, (lineal)

>**Ejemplo**
>
>   Si un programa tarda:
>   * 100 segundos con 1 CPU
>   * 30 segundso con 4 CPUs
>
>   entonces:
>
>   <center>
>
>   ![Ejemplo SpeedUp](./images/speedup_ejemplo.png)
>
>   </center>
>
>   Signifiaca que con 4 CPUs corre **3.33** veces más rápido

## Eficiencia

La *Eficiencia* mide qué tan bien se usan las CPUs adicionales.

Se calcula como:

<center>

   ![Eficiencia](./images/eficiencia.png)

</center>

donde:
* *N* = número total de CPUs utilizadas.

>**Ejemplo**
>
>Retomando el ejemplo anterior:
>
>SpeesUp = 3.33 con 4 CPUS. 
>
><center>
>
>   ![Eficiencia ejemplo](./images/eficiencia_ejemplo.png)
>
></center>
>
>Que significa:
>* El programa usa **83% de la capacidad paralela ideal.**
>* El 17% restante se pierde por: 
>    * Comunicación entre procesoso
>    * operaciones secuenciales
>    * sincronización
>    * I/O, etc

**Observación**

El *SpeddUp* **JAMÁS** será perfecto, la comunicación entre procesos, la 
sincronización y la parte secuencial del código limitan la *eficiencia.*

# Uso de GPUS

# Dudas

    - htop
    - Reserva de RAM
    - Lmod
    - Cuota de discos
    - Uso de particiones GPUs




