# Uso de GPUS
- Como ejecutar un programa mediante Slurm que utilice gpus

Particiones
> - gpus
> - vgpus

Parámetro
> --gres=gpu:2

Módulos
> - cuda/10.2
> - cuda/11.2
> - cuda/11.8
> - cuda/9.0

por ejemplo
```bash
#!/bin/bash
#SBATCH --partition=gpus
#SBATCH --job-name=prueba gpus
#SBATCH --gres=gpu:2           # Para solicitar gpus (pueden ser 2,4,8)
#SBATCH --ntasks=20
#SBATCH --time=04-00:00:00

module purge
module load namd/2.13-CUDA
namd2 +p20 +idlepoll +devices 0,1 +setcpuaffinity INPUT.CONF
```
