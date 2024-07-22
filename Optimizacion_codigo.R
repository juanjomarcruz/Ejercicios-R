#En este reto guiado partiremos de un set de datos que ofrece R, en particular del set de diamantes.
#Vamos a guardar este set de datos en un CSV y con un código ya elaborado, aplicaremos diferentes técnicas de optimización para mejorar el código planteado.

#install.packages('profvis')
library(readr)
library(ggplot2)
#library(profvis)
#library(dplyr)

profvis({                     #con profvis podemos ver gráficamente dónde tenemos los cuellos de botella. Encontramos principalmente 2: read_csv y bucle for.
path <- "datos/diamonds.csv"
datos <- read_csv(path)       #mirando con microbenchmark comprobamos que la función read.csv es más óptima.

resultados <- list()
cortes <- unique(datos$cut)

for (i in 1:length(cortes)){                               #este bucle for puede ser sustituído mediante el uso de funciones del paquete dplyr del universo de paquetes tidyverse.
  seleccion <- datos[datos$cut==cortes[i],]                # resumen_diamantes <- datos %>% group_by(cut) %>% summarise(Media=mean(price)).
  media <- mean(seleccion$price)
  resultados[[i]] <- data.frame(Corte=cortes, Media=media)
}

resumen_diamonds <- do.call(rbind, resultados)

ggplot(resumen_diamonds, aes(x=Corte, y=Media)) +
  geom_col()+
  geom_text(aes(label=Media))

})