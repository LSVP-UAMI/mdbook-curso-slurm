# Cuota de discos?

Las politicas actuales del cluster son

## Para directorio HOME
Por grupo de trabajo en el directorio *HOME*

|Tipo|Limite|
|:----|:---:|
|Uso de disco|2 TB|
|Cantidad de archivos|2 M|

Para ver el uso actual del grupo se puede usar el comando
```bash
    lfs quota  -g <grupo> -h /LUSTRE
```

El resultado es similar a este
```
Disk quotas for grp xgx (gid 5013):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
        /LUSTRE  821.7G    1.9T      2T       - 1889885  1900000 2000000       -
```

Si se supera este limite los trabajos fallan con un mensaje que en alguna parte dice
`quota exceded`


## Para directorio *HOME/tmp*

> Los archivos se eliminan después de un mes de haber sido creados


## Resolver problemas

Si es el caso se puede buscar los archivos más grandes con el comando
`ncdu`

Sugerimos respaldar archivos con la herramienta `rsync`
por ejemplo
```bash
rsync -Paz 148.206.50.61:mi_directorio_grande/carpetaB .
```

