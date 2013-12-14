Script en R para analizar la ocupación de un directorio
========

Necesitamos tener instalado R: ``apt-get install r-base-core``

También necesitamos el paquete treemap de R:
```
# R
> install.packages(treemap)
```

Para usar el script (se pueden pasar varios directorios):

``Rscript ocupacion-filesystem.r /home/pepe /var/lib``

Mostrará las gráficas en un escritorio x11.

Los datos los saca de hacer un ``ls -l``, por lo tanto los directorios aparecen ocupando muy poco.

![alt text](https://raw.github.com/adrianlzt/R-scripts/master/ocupacion_filesystem/captura.png "Treemap de ficheros")
