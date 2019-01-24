# -Tarea_Nro5
Creando una página y extrayendo sus datos

#  A) ¿Se dieron cuenta de el suceso extraño respecto al tag “img”, analice en qué se diferencia de los tag ya vistos previamente?
R:  Lo extraño del tag "img" es que no cierra,  dado que existen ciertos tag  que no necesitan cierres. Un ejemplo de ello es el tag "br", utilizada en textos.

# B) Con las funciones entregadas anteriormente realice la extracción del título de la noticia, y luego la noticia, separe las palabras y almacenarlas en una lista.
R: Para realizarlo, se procede a:
- instalar: install.packages(rvest),para descargarla"
- usar la library("rvest")

# inicializando la variable archivo con el nombre de mi pÃ¡gina
archivo <- 'PagWeb.html'

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

##########################################################
############# ExtracciÃ³n del texto noticia ###############
##########################################################

# Extrayendo contenido en la clase justificado
contenidojumbo <- html_nodes(webpage,'p')

# Pasando la info a texto
textojumbo <- html_text(contenidojumbo)

# Viendo a priori la info en la variable textoNoticia
print(textojumbo)

