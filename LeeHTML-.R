### borrado de variables rm(list = ls())  

##########################################################
######### Iniciando la extracción de información #########
##########################################################

# install.packages("rvest"), para descargarla 
# Usando la libreria rvest
library('rvest')

# inicializando la variable archivo con el nombre de mi página
archivo <- 'PagWeb.html'

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

##########################################################
############# Extracción del texto noticia ###############
##########################################################

# Extrayendo contenido en la clase justificado
contenidojumbo <- html_nodes(webpage,'p')

# Pasando la info a texto
textojumbo <- html_text(contenidojumbo)

# Viendo a priori la info en la variable textoNoticia
print(textojumbo)

# Pregunta: ¿Qué representa el \n?

# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)

# Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

# Separando las palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

# Pasando todas las palabras a minúsculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

# Contando palabras
unlistNoticias<-unlist(splitEspacioNoticia)
tablaPalabras<-table(unlistNoticias)

# Pasando la información a un data frame
dfPalabrasNoticia <- as.data.frame(tablaPalabras)

# Almacenando la información en CSV
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.csv")

# o en un txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")

##########################################################
############ Extraccion información tabla ################
##########################################################

# Extrayendo los elementos que contienen las tablas
tablaProductos <- html_nodes(webpage, ".productos")

# Extraccio de el contenido de las tablas usando el tag table
contenedorDeTablas <- html_nodes(tablaProductos, "table")

# Extracción información tabla 1
tabla1 <- html_table(contenedorDeTablas[1][[1]])

# Viendo el contenido de la posición 1,2 de la tabla1
print(tabla1[1,2])

# Extracción información tabla 2
tabla2 <- html_table(contenedorDeTablas[2][[1]])

# Viendo el contenido de la posición 1,2 de la tabla2
print(tabla2[1,2])

# Limpiando $ comas y cambios de puntos por coma
tabla1$Valor <- gsub("\\$","",tabla1$Valor)
tabla1$Valor <- gsub("[.]","",tabla1$Valor)
tabla1$Valor <- as.numeric(gsub(",",".",tabla1$Valor))

tabla2$Valor <- gsub("\\$","",tabla2$Valor)
tabla2$Valor <- gsub("[.]","",tabla2$Valor)
tabla2$Valor <- as.numeric(gsub(",",".",tabla2$Valor))

# Combinando los dos data frames y creando un tercer data frame
tablaMerge <- rbind(tabla1,tabla2)

# Realizando una busqueda en el dataframe
elementosEncontrados <- tablaMerge[which(tablaMerge$Supermercado == "Unimarc"), ]

# Creando una tercera columna "ProductoSupermercado" con la 
# intención de generando nombres únicos, esto es para
# graficar el valor de cada producto en cada supermercado
tablaMerge$ProductoSupermercado <- paste(tablaMerge$Producto," ",tablaMerge$Supermercado) 

################### Graficando los productos
library('ggplot2')

# Gráfico Barra por producto concatenado con supermercado,
# respecto al costo
tablaMerge %>%
  ggplot() +
  aes(x = ProductoSupermercado, y = Valor) +
  geom_bar(stat="identity")

# Gráfico boxplot diferenciado por producto
tablaMerge %>%
  ggplot() +
  geom_boxplot(aes(x = Producto, y = Valor)) +
  theme_bw()



