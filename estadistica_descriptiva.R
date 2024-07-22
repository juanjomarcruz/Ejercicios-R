#Cargamos datos de ejemplo: Iris

d <- datasets::iris

#Visualizamos las primeras filas
head(d)

#Medidas de posición
#Media
#El argumento na.rm=TRUE, excluye el cálculo de los NA.
#El argumento trim permite excluir valores extremos.
mean(d$Sepal.Length)
mean(d$Sepal.Length, na.rm = TRUE, trim=0.025)

#Mediana:
median(d$Sepal.Length)

#Moda
#Requiere el paquete modeest
install.packages("modeest")
library(modeest)
mfv(d$Sepal.Length)

#Tamaño de la muestra
length(d$Sepal.Length)

#Frecuencias absolutas
t <- table(d$Species)
t

#Frecuencias relativas
prop.table(t)
round(prop.table(t)*100,2) #en porcentaje y redondeado.

#Cuantiles
quantile(d$Sepal.Length,prob=c(0.25,0.5,0.75))

#Medidas de dispersión
#Mínimo
min(d$Sepal.Length)

#Máximo
max(d$Sepal.Length)

#Rango
range(d$Sepal.Length)

#Varianza
var(d$Sepal.Length)

#Desviación estándar
sd(d$Sepal.Length)

#Forma de distribución
#Requiere el paquete psych
install.packages("psych")
library(psych)

#Coeficiente de simetría
skew(d$Sepal.Length)

#Curtosis
kurtosi(d$Sepal.Length)

#Calcular varios estadísticos de forma agregada
summary(d$Sepal.Length)
summary(d)

#Histograma de frecuencia de la longitud del sépalo
hist(d$Sepal.Length)

#Gráfico de barras
barplot(table(d$Species))
barplot(table(d$Species),col="skyblue",ylab="frecuencia",main="Frecuencia de cortes")


#Prueba
library(ggplot2)
ggplot(d,aes(x=Sepal.Length)) + geom_bar(col="black",fill="beige")

?geom_bar()

#Relación entre altura y anchura del pétalo

plot(x=d$Petal.Length,y=d$Petal.Width,col="red")
cor(d$Petal.Length,d$Petal.Width) #Coeficiente de correlación lineal
