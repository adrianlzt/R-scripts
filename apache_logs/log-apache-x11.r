#!/usr/bin/env Rscript
#
# Obtener estadisticas de fichero access_log
#
# El formato del fichero de log debe ser:
# 1.2.4.5 - - [08/Dec/2013:03:19:11 +0100] "POST /url HTTP/1.1" 500 20 "http://1.2.4.5/" "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0"
#
# El parseo de la fecha esta puesto para idioma ingles (LC_TIME=C). Cambiar si es necesario (por ejemplo si el mes es "Dic")
#
# Uso: Rscript log-apache.r /var/log/httpd/access_log
#
# Gracias a http://data-experience.blogspot.de/
#

# Para mostrar ventanas y mantenerlas abiertas hasta presionar una tecla
library(tcltk)
x11()

# Cargo libreria necesaria
library(treemap)

# Obtengo los parametros donde apunta al fichero de log
args <- commandArgs(trailingOnly = TRUE)

# Leo el fichero y lo convierto a un data.frame
ac <- read.table(args[1])

# Le damos nombres a las columnas
colnames(ac)=c("host",NA,NA,"date","timezone","request","status","bytes","url","browser")

# Quitamos las columnas que no queremos (las dos vacias y el timezone)
ac <- ac[c("host","date","request","status","bytes","url","browser")]

# Convertir la fecha, mirar date.md
Sys.setlocale("LC_TIME", "C") 
ac$date <- strptime(ac$date,format('[%d/%b/%Y:%H:%M:%S'))

# Campo para poder pintar el treemap
ac$count <- c(1)

# Add day, hour and year-month column
ac$day = format(ac$date,'%A')
ac$hour = format(ac$date,'%H')
ac$yearmonth = format(ac$date, "%Y-%m")

# Mostrar todas las graficas en una misma ventana
par(mfrow=c(2,2))

# Graficas con numero de peticiones por year-month 
barplot(table(ac$yearmonth), xlab="Year-Month", ylab="Num peticiones")

# Graficas con numero de peticiones por hora
barplot(table(ac$hour), xlab="Hour", ylab="Num peticiones")

# Graficas con numero de peticiones por dia de la semana
barplot(table(factor(ac$day, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))), xlab="Day", ylab="Num peticiones")

# Número de peticiones por cada código de contestación (200,405,500...)
barplot(table(ac$status),log="y",xlab="Codigos HTTP",ylab="Num peticiones (Log)")

# Mostrar hosts que más acceden en un formato de cajas, donde a mayor tamaño más accesos, en una ventana nueva
dev.new()
x11()
treemap(ac, index="host", vSize='count',title="Clientes")

# Nos devuelve las filas que tienen ".*json.*" en la columna request
# ac[grep('.*json.*',ac$request),]

# Mantener abiertas las ventanas hasta presionar una tecla
prompt  <- "Pulsar OK para cerras las ventanas"
capture <- tk_messageBox(message = prompt, detail = extra)
