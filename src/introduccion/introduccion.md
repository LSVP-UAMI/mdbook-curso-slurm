# Clúster Yoltla

## **Información?**
![Clúster Yoltla](./images/yolta.jpg)

# Infraestructura

## Nodos Yoltla/login
* 2 Nodos
    * Intel(R) Xeon(R) CPU E5-2695 v2 @ 2.40GHz
    * 48 CPUs
    * 94 GB RAM

![Nodos yoltla](./images/nodos_yoltla/login_yoltla.png)

****************************************************************************************************

## Nodos nc
* 140 Nodos
    * Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
    * 20 CPUs
    * 62 GB RAM

![Nodos nc](./images/nodos_yoltla/nc_yoltla.png)

****************************************************************************************************

## Nodos ncz
* 24 Nodos
    * AMD EPYC 7513 32-Core Processor
    * 64 CPUs
    * 500 GB RAM

![Nodos ncz](./images/nodos_yoltla/ncz_yoltla.png)

****************************************************************************************************

## Nodos ngk

****************************************************************************************************

## Nodos tt
* 104 Nodos 
    * Intel(R) Xeon(R) CPU E5-2660 v3 @ 2.60GHz
    * 20 CPUs
    * 125 GB RAM

![Nodos tt](./images/nodos_yoltla/tt_yoltla.png)

****************************************************************************************************

## Nodos gpu

****************************************************************************************************

## Clúster Yoltla

![Clúster yoltla](./images/nodos_yoltla/yoltla.png)

Descripción de los nodos de procesamiento

****************************************************************************************************


# Accediendo al clúster

El acceso al clúster Yoltla es remoto y se realiza por medio de 2 
servidores llamados nodos de acceso. Para conectarse a los nodos 
de acceso se requiere de un shell seguro (secure shell / SSH).

| **Nombre del nodo**   | **Dirección IP**  | 
|:---------------------:|:-----------------:|
|       yoltla0         | 148.206.50.61     |
|       yoltla1         | 148.206.50.62     |

```admonish warning title="IMPORTANTE"
La primera conexión debe realizarse al nodo de acceso `yoltla0`.
```

Diagrama de conexión por ssh al clúster Yoltla

![Conexión yoltla-ssh](./images/diagrama_yoltla.png)

****************************************************************************************************

## SSH GNU/Linux OS X

Desde la terminal ejecute el comando:
```
ssh -l <nombre de usuario> <dirección IP del nodo de acceso>
```

```admonish note title="NOTA"
Opción `-l` (letra ele minúscula).
```

Otra forma de realizar la conexión es utilizando la notación usuario@maquina:
```
ssh <nombre usuario>@<dirección IP del nodo de acceso>
```

****************************************************************************************************

## Windows

Utiliza [PuTTY](https://portableapps.com/apps/internet/putty_portable) para acceder 
al clúster con la siguiente información: 

-   **Host Name (or IP address):** 148.206.50.61
-   **Port:** 22
-   **Connection type:** SSH

La ventana de configuración debe quedar de la siguiente manera: 
<center>

![PuTTy configuración](./images/putty_configuration.png)
</center>

Posteriormente, se abrirá una nueva ventana en donde se le solicitará su nombre de usuario y su 
contraseña:
<center>

![Pantalla vienvenida](./images/pantalla_bienvenida.png)
</center>

****************************************************************************************************


# ¿Que es SLURM?

**SLURM** (Simple Linux Utility for Resource Management) es un sistema de 
gestión de trabajos y recursos de código abierto utilizado en clusters 
de computación de alto rendimiento (HPC).

Características principales:

* Gestor de colas: Organiza y planifica la ejecución de trabajos
* Administrador de recursos: Asigna CPU, memoria, GPU y otros recursos
* Escalable: Soporta desde pequeños clusters hasta supercomputadoras
* Tolerante a fallos: Capaz de recuperarse de fallos del sistema

**Componentes clave:**

* srun: Para lanzar trabajos paralelos
* sbatch: Para enviar trabajos por lotes

****************************************************************************************************


# Comandos principales de slurm

## sinfo - Información del estado del cluster 

**sinfo** muestra información sobre los nodos y particiones del cúster. Con esta 
herramienta se puede consultar el estado de los recursos disponibles, como CPUs, 
memoria, tiempo máximo de ejecución y disponibilidad de los nodos.

```bash
    # Sintaxis básica.
    sinfo [opciones]
```

Si se ejecuta **sinfo** sin opciones, mostrará una vista general de las particiones y 
sus estados.

```bash
    [pepe@yoltla0 ~]$ sinfo

    PARTITION  AVAIL  TIMELIMIT  NODES  STATE NODELIST
    q1h-20p*      up    1:00:00      1  inval nc84
    q1h-20p*      up    1:00:00     10 drain$ nc[7,9-12,21,69-72]
    q1h-20p*      up    1:00:00      2 drain* nc[17,50]
    q1h-20p*      up    1:00:00      1  drain nc43
    q1h-20p*      up    1:00:00     65  alloc nc[2-5,8,13-16,23-24,26]
    q1d-20p       up 1-00:00:00     14  down* nc[18,20,22,27-28,33-34]
    q1d-20p       up 1-00:00:00      6   drng nc[19,55,61,67,80,99]
    q1d-20p       up 1-00:00:00      1  drain nc43
```

En la siguiente tabla se da una descripción de los campos que conforman la salida anterior:

|   **Campo**   |   **Descripción** |
|:-------------:|-------------------|
|   `PARTITION` |   Nombre de la partición.|
|   `AVAIL`     |   Estado de la partición.|
|   `TIMELIMIT` |   Tiempo máximo de ejecución para cualquier trabajo.|
|   `NODES`     |   Número de nodos en la partición.|
|   `STATE`     |   Estado actual de los nodos (por ejemplo, `idle`, `alloc`, `mix`, `down`).|
|   `NODELIST`  |   Lista de nodos que conforman la partición.|

Estados de los nodos: 

|   **Estado**   |   **Descripción** |
|:--------------:|-------------------|
| `idle`  | Nodo libre, sin trabajos asignados. | 
| `alloc` | Nodo completamente asignado de trabajos. |
| `mix`   | Nodo parcialmente ocupado. |
| `down`  | Nodo fuera de servicio. |
| `drain` | Nodo deshabilitado para nuevos trabajos (por mantenimeinto o error). |

**Ejemplos de uso**
```bash
    # Mostrar particiones especificas. 
    sinfo -p particion1,particion2

    # Mostrar detalles a nivel de nodos.
    sinfo -N

    # Mostrar nodos con formato personalizado
    sinfo -o "%N %P %t %C %m %G"

        #Donde: 
        # %N = nombre del nodo
        # %P = partición
        # %t = estado del nodo
        # %C = configuración de CPU
        # %m = memoria
        # %G = grupos de GPU
```
**************************************************************************

## squeue - Estado de la cola de trabajos

El comando `squeue` muestra información sobre los trabajos en cola y 
en ejecución dentro del clúster.

```bash
    # Sintaxis básica.
    squeue [opciones]
```

Al ejecutar `squeue` sin parametros, se mostrará información similar a la 
siguiente: 


```bash
    [pepe@yoltla0 ~]$ squeue

    JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    696283      gpus pruebaGr   a.7350  R 1-13:54:33      1 ngk4
    695490      gpus     M_R1   i.5519  R 3-14:29:39      1 ngk9
    697438      gpus  T230KFu l.100038  R    9:04:47      1 ngk10
    697519  q12h-80p prueba_q   i.5533 PD       0:00      4 (Resources)
    697518   q1d-20p       M8  cedillo  R      44:57      1 nc112
    697443   q1d-20p 3hit20wY     frml  R    2:46:52      1 nc113
    697360  q1d-320p mgco3Bul      jgo PD       0:00     16 (Resources)
    697286   q1d-40p corriend     insa  R    5:27:56      2 nc[39,42]
    697509   q1h-20p BCTrpZ_c   a.7312  R      52:14      1 nc88
    697508   q1h-20p BCTrpZ_c   a.7312  R      52:32      1 nc83
```

En la siguiente tabla se da una descripción de los campos que conforman la 
salida anterior:

|   **Campo**   |   **Descripción** |
|:-------------:|-------------------|
| `JOBID` | Identificador del trabajo. |
| `PARTITION` | Partición donde se ejecuta. |
| `NAME` | Nombre del trabajo. |
| `USER` | Usuario que envio el trabajo. |
| `ST` | Estado del trabajo (por ejemplo, `R`, `PD`, `GC`, etc) |
| `TIME` | Tiempo trascurrido. |
| `NODES` | Número de nodos asignados. |
| `NODELIST (REASON)` | Lsita de nodos asignados o razón por la que el trabajo está pendiente. |

Estados comunes de los trabajos: 

| **Código** | **Estado** | **Descripción** |
|:----------:|:----------:|-----------------|
| `PD` | Pending | Esperando recursos o dependencias. |
| `R` | Running | En ejecucuón. |
| `CG` | Completing | Termonando ejecución. |
| `CD` | Completed | Finalizado con éxito. | 
| `F` | Failed | Finalizó con error. | 
| `TO` | Timeout | Excedió el tiempo máximo. | 
| `CA` | Cancelled | Cancelado por el usuario o el sistema. | 

**Ejemplos de uso**
```bash
    # Mostrar los trabajos de un usuario.
    squeue -u 'usuario'

    # Mostrar trabajos en una partición específica.
    squeue -p 'partición'

    # Mostrar formato personalizado.
    squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R"

        #Donde:
        # %i = JOBID.
        # %P = Partición.
        # %j = Nombre del trabajo.
        # %u = Usuario.
        # %t = Estado.
        # %M = Tiempo transcurrido.
        # %D = Nodos asignados.
        # %R = Motivo o lista de nodos.

```
**************************************************************************

## sacct - Información de trabajos completados

`sacct` muestra información histórica o detallada sobre los trabajos 
que ya se ejecutaron o se están ejecutando.

```bash
    # Sintaxis básica
    sacct [opciones]
```
Ejemplo de salida típica:
```bash
       JobID    JobName  Partition    Account  AllocCPUS  State  ExitCode
------------ ---------- ---------- ---------- ---------- ------- --------
12345        jobA       batch       users          64    COMPLETED 0:0
12346        jobB       gpu         users          32    FAILED    1:0
12347.batch  jobC       debug       users          16    CANCELLED 0:15
```

**Ejemlos de uso**
```bash
    # Información de trabajos de un suario.
    sacct -u 'usuario'
    
    # Información de trabajos en un rango de fechas.
    sacct -S 2024-01-01 -E 2024-01-02
    
    # Información detallada de un trabajo
    sacct -j 12345 -o jobid,jobname,partition,account,alloccpus,state,exitcode
    
    # Información de trabajos cancelados o fallidos
    sacct -s CA,F
```
-------------------------------------

## scontrol - Control y configuración


`scontrol` es una herramienta administrativa y de diagnóstico que permite 
ver y modificar el estado de varios elementos de Slurm:
trabajos(`job`), nodos(`node`), particiones(`partition`), y más

```bash
    # Sintaxis básica
    scontrol [subcomando] [objeto] [argumentos]
```


Los principales subcomandos se muestran en la siguiente tabla.

| **Subcomando** | **Descripción** |
|----------------|-----------------|
| `show` | Muestra información detallada. |
| `update` | Cambia atributos o estados. | 
| `reconfigure` | Recarga la configuración de Slurm sin reiniciar. |
| `ping` | Verifica si el `slurmctl` está respondiendo. |
| `hold`/`release` | Suspende o libera trabajos en espera. |
| `listpids` | Muestra los `PIDs` asociados a un trabajo. |

**Ejemplos de uso**
```bash
    # Información de un trabajo.
    scontrol show job 12346

    # Información de un nodo.
    scontrol show node nodo01

    # Liberar un nodo.
    scontrol update nodoname=nodo01 state=RESUME

    # Modificar parámetros de un trabajo.
    scontrol update jobid=12345 TimeLimit=50:00
```
**************************************************************************

## scancel - Cancelar trabajos

`scancel` se usa para detener uno o varios trabajos en ejecución o pendientes.

```bash
    # Sintaxis básica
    scancel [opciones] <JOBID>
```

**Ejemplos de uso**
```bash
    # Cancelar un trabajo específico.
    scanccel 12345

    # Cancelar múltiples trabajos a la vez.
    scancel 12345 78945 65478 

    # Cancelar todos tus trabajos.
    scancel -u $USER
    acancel -u 'nombre_usuario'

    # Cancelar todos los trabajos de una partición.
    scancel -p 'partición'

    # Cancelar todos los trabajos en ejecución.
    scancel -t RUNNING

    # Cancelar trabajos pendientes.
    scancel -t PENDING -u 'nombre_usuario'
```
**************************************************************************

# Parámetros de Slurm

Indican qué recursos necesita tu trabajo: número de nodos, CPUs, memoria, 
tiempo, partición, etc.

Se pueden especificar de dos maneras:

- Dentro de un script, con directivas `#SBATCH`: 
```bash
    #SBATCH -N 2   =  #SBATCH --nodes=2
    #SBATCH -n 8   =  #SBATCH --ntasks=1
    #SBATCH -t 10  =  #SBATCH --time=00:10:00
```
        
- Desde la línea de comandos, al ejecutar `srun` o `sbatch`:
```bash
    srun -N 2 -n 8 -t 10 ./mi_programa
```

Ambos casos son equivalentes: las opciones `#SBATCH` son los mismos parámetros que usarías 
en la línea de comando.

## Principales parámetros de Slurm

### Recursos computacionales

| **Parámetro** |-|  **Descripción** | **Ejemplo** |
|:-------------:|-|-----------------|-------------|
| `--nodes` | `-N` | Número de nodos solicitados. | #SBATCH -N 2 |
| `--ntasks` | `-n` | Número total de tareas (processes) | #SBATCH -n 8 | 
| `--ntasks-per-node` | |	Tareas por nodo. | #SBATCH --ntasks-per-node=4 | 
| `--cpus-per-task` | `-c` | Núcleos (threads) por tarea. | #SBATCH -c 2 |
| `--gpus` | | Número de GPUs solicitadas. | #SBATCH --gpus=1 |
| `--gres` | | Recursos genéricos (por ejemplo GPUs, licencias). | #SBATCH --gres=gpu:2 | 

**Ejemplo:**
```bash
    #SBATCH -N 2
    #SBATCH -n 8
    #SBATCH --ntasks-per-node=4
    #SBATCH -c 2

2 nodos, cada uno con 4 tareas, cada tarea usa 2 CPUs (total 16 núcleos).
```

### Memoria

| **Parámetro** | **Descripción** | **Ejemplo** |
|:-------------:|-----------------|-------------|
| `--mem` | Memoria total por nodo. | #SBATCH --mem=4G |
| `--mem-per-cpu` |	Memoria por CPU. | #SBATCH --mem-per-cpu=1G |
| `--mem-per-gpu` | Memoria por GPU. | #SBATCH --mem-per-gpu=8G |

```admonish note title="Nota"
- Si usas `--mem` y tienes varios nodos, cada nodo recibirá esa cantidad.

- Si usas `--mem-per-cpu`, Slurm calcula el total = CPUs × memoria por CPU.   
```

### Tiempo y prioridad

| **Parámetro** | - | **Descripción** | **Ejemplo** |
|---------------|---|-----------------|-------------|
| `--time` | `-t` | Tiempo máximo de ejecución. Formato: min o HH:MM:SS. | #SBATCH -t 30 o #SBATCH -t 01:00:00 |
| `--partition` | `-p` | Cola o partición donde ejecutar el trabajo. | #SBATCH -p gpu |
| `--nice` | | Cambia la prioridad del trabajo (valor alto = menor prioridad). | #SBATCH --nice=100 | 


### Archivos de salida

| **Parámetro** | - | **Descripción** | **Ejemplo** |
|---------------|---|-----------------|-------------|
| `--output` | `-o` | Archivo donde guardar la salida estándar (stdout). | #SBATCH -o salida.out |
| `--error` | `-e` | Archivo donde guardar los errores (stderr). | #SBATCH -e errores.log |
| `--job-name` | `-J` | Nombre del trabajo. | #SBATCH -J simulacion | 
| `--mail-user` | | Correo del usuario para notificaciones. | #SBATCH --mail-user=usuario@dominio.com |
| `--mail-type` | |	Cuándo enviar correo (`BEGIN`, `END`, `FAIL`, `ALL`). | #SBATCH --mail-type=END,FAIL |

```admonish success title=" "
- `%j` inserta el ID del trabajo automáticamente.
```
    







Las directivas establecen las opciones con las que se va a ejecutar el trabajo.

| **Directiva** | **Descripción** | **Uso** |
|:-------------:|:---------------:|:-------:|
| `--job-name=trabajo`     |  Nombre del trabajo.         |  Opcional  |
| `--output=salida`        |  Salida estándar.            |  Opcional  |
| `--error=error`          |  Error estándar.             |  Opcional  |
| `--partition=partición`  |  Nombre de la partición.     |  Obligatorio  |
| `--time=dd-hh:mm:ss`     |  Tiempo máximo de ejecución. |  Obligatorio  |
| `--nodes=#`              |  Número de nodos.            |  Obligatorio  |
| `--ntasks-per-node=#`    |  Número de tareas por nodo.  |  Obligatorio  |
| `--cpus-per-task=#`      |  Número de CPUs por tarea.   |  Obligatorio  |
| `--mem=#`                |  Memoria por nodo.           |  Opcional     |
| `--mail-user=email`      |  Correo electrónico del usuario.  |  Opcional  |
| `--mail-type=eventos`    |  Eventos que se notificarán por correo electrónico.  |  Opcional  |

```admonish warning title="IMPORTANTE"
**Sólo se utiliza la directiva:**
    
    --cpus-per-task=#
    
**cuando el programa usa memoria compartida (OpenMP).**
```



# Srun 

Es un comando de la utilidad del gestor de trabajos de clúster. Se utiliza para 
ejecutar trabajos en paralelo o de forma interactiva. 

`srun` es síncrono y espera a que el trabajo termine para devolver el control al usuario.

**Ejemplo**
```bash
[pepe@nc56 ~]$ srun hostname

nc56
```

`srun` puede iniciar trabajos o pasos de trabajos dentro de una asignación de recursos existente, 
```bash
[pepe@nc56 ~]$ srun -N 1 --ntasks-per-node=4 --mem-per-cpu=1gb -t 1:00:00 -p interactive comando 

```


>**ACTIVIDAD**
>
>Ejecuta el comando `hostname` en la partición `q1` con `srun`: 
>* Con un unico prceso.
>* Con dos procesos iguales.
>* Con dos procesos en distintos nodos.
>* Lanzando un porceso que tenga dos ***cores*** reservados.
>
>
>
>
>
>
>







# Sbatch
    - ejercicio

# Htop

# Lmod ó module avial?
    Cargar modulos en yoltla

# Cuota de discos?

# Eficiencia Computacional

# Dudas

    - htop
    - Reserva de RAM
    - Lmod
    - Cuota de discos
    - Uso de particiones GPUs
