Scripts en R para analizar un fichero access_log
========

El formato del fichero de log debe ser:

1.2.4.5 - - [08/Dec/2013:03:19:11 +0100] "POST /url HTTP/1.1" 500 20 "http://1.2.4.5/" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0"


Necesitamos tener instalado R: ``apt-get install r-base-core``

También necesitamos el paquete treemap de R:
```
# R
> install.packages(treemap)
```

Para usar el script (solo se puede pasar un fichero):
``Rscript log-apache-to_pdf.r /dev/shm/access_log``
Generá dos ficheros pdf en el directorio que lo hayamos ejecutado con las gráficas.

Si queremos mostrar las gráficas en un escritorio x11 usaremos el otro script:
``Rscript log-apache-x11.r /dev/shm/access_log``

![alt text](https://raw.github.com/adrianlzt/R-scripts/master/apache_logs/captura-plots.png "Plots de datos")
![alt text](https://raw.github.com/adrianlzt/R-scripts/master/apache_logs/captura-tree.png "Treemap de hosts")
