install.packages("stringr")
library(stringr)

data(package="stringr")
head(sentences)
summary(sentences)
frutas <- c("pera","banana","kiwi","manzana","paraguayo","fresa","pera")

#Determinar coincidencias
str_detect(sentences,"sad")
str_count(sentences,"sad") #devuelve un 1 donde aparezca la palabra sad y un 0 donde no aparezca.
str_count(sentences,"a") #devuelve cuántas veces aparece la a en cada palabra.

sum(str_detect(sentences,"sad")) #devuelve cuántas veces aparece la palabra sad.
sum(str_count(frutas,"pera")) #devuelve cuántas veces aparece la palabra pera en el vector frutas.
str_count(frutas,"pera")  #devuelve un 1 donde aparezca la palabra pera y un 0 donde no aparezca.

str_which(frutas,"pera") #devuelve la posición en la que se encuentra pera en el vector frutas.
str_locate(frutas,"ana") #devuelve la primera y la última posición en la que aparece el string dentro de cada elemento del vector frutas.

#Subconjuntos

str_subset(sentences,"sad") #devuelve cada elemento completo donde aparece el string que queremos buscar.
str_sub(frutas,2,4) #devuelve los caracteres de la posición 2 a la 4 de cada elemento del vector frutas.

#manejar longitudes
str_length(frutas) #devuelve la longitud de cada uno de los strings del vector frutas.

#Modificar strings
str_sub(frutas[3],1,-1) <- "mango" #para sustituir el string completo (de la primer caracter al último) de la posición 3 del vector frutas por el string mango.
frutas
frutas <- replace(frutas,"pera","sandía") #sustituye pera por sandía en todas las posiciones donde aparezca pera.

#Unir y separar separar strings
frutas_unidas <- str_c(frutas,collapse="-") #se unen todos los strings del vector por el elemento del argumento collapse.
length(frutas_unidas) #aquí la longitud es 1 puesto que solo está compuesto por 1 elemento.
length(frutas) #aqui la longitud del vector frutas es de 7 pues tiene 7 elementos.
str_unique(frutas) #elimina los duplicados, extrayendo elementos únicos.
frutas_separadas <- str_split(frutas_unidas,"-") #separa el string frutas_unidas en una lista de 1 elemento, ese elemento tendrá longitud 7.
frutas_separadas
length(frutas_separadas)
length(frutas_separadas[[1]])
