# Cojo los parametros
args <- commandArgs(trailingOnly = TRUE)

# Para mostrar ventanas y mantenerlas abiertas hasta presionar una tecla
library(tcltk)
x11()

# Cargo las librerias necesarias
library(treemap)
library(tools)

# Ejecuto ls y meto la salida en la variable 'ls'
exec <- paste(c("ls -l --time-style=+%Y-%m-%d:%H:%M:%S",args),collapse=' ')
ls <- system(exec, intern=T,ignore.stderr=T)

# Quito las cabeceras de ls (total y nombre del directorio, si se pasa mas de uno)
ls <- grep('^[d-]{1}.*',ls,value=T)

# Convierto 'ls' en un date.frame
dfls <- read.table(textConnection(ls))

# Pongo los nombres de las columnas
colnames(dfls) = c("perms","links","user","group","size","date","file")

# Convierto la fecha a R
dfls$date <- strptime(dfls$date,format('%Y-%m-%d:%H:%M:%S'))

# Introduzco columna con las extensiones de los ficheros
dfls$ext <- file_ext(dfls$file)

# Abro el navegador para ver el tree map
# itreemap(dfls,index="file",vSize="size") # no funciona con Rscript
treemap(dfls,index="file",vSize="size")

# Mantener abiertas las ventanas hasta presionar una tecla
prompt  <- "Pulsar OK para cerras las ventanas"
capture <- tk_messageBox(message = prompt)
