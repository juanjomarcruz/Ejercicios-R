#Regresión lineal
library(ggplot2)

#Visualizar las primeras filas del dataset diamonds
data(package="ggplot2",diamonds)
head(diamonds)

#Realizar la regresión lineal
?diamonds
modelo <- lm(price ~ carat,data=diamonds)

#Analizar el modelo de regresión

summary(modelo)
#Ecuación: price = 7756.43* carat - 2256.36
#Ajuste: 84.93%
#Nivel de significación = 0.05 > p-valor

#Representar el modelo
ggplot(diamonds,aes(x=carat,y=price)) +
  geom_point() +
  geom_smooth(method='lm',color="red",se=FALSE) #se=FALSE para desactivar que muestre el intervalo de confianza.

