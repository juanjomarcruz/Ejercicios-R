#Librerías
library(ggplot2)
library(dplyr)

#Obtenemos los datos
data("PimaIndiansDiabetes2",package="mlbench")
head(PimaIndiansDiabetes2)

#Preparar los datos
diabetes <- na.omit(PimaIndiansDiabetes2)
rm(PimaIndiansDiabetes2)

#Construir el modelo de regresión logística múltiple
modelo <- glm(diabetes ~ .,data=diabetes, family = "binomial") #el punto se refiere al resto de variables.

#Crear modelo de regresión logística simple
modelo_2 <- glm(diabetes ~ glucose, data=diabetes, family = "binomial")
#Analizar el modelo
summary(modelo)
#si el estimador de la variable cuantitativa es positivo, significa que si aumenta su valor, nos aumenta la probabilidad de padecer diabetes
#si el estimador de la variable cuantitativa es negativo, significa que si aumenta su valor, nos disminuye la probabilidad de padecer diabetes.
#el p-valor asociado a cada variable cuantitativa nos muestra si la influencia de dicha variable es estadísticamente significativa.
#las variables glucosa es la más relevante, seguida de la masa y pedrigree. (p-valor inferior a 0.05).

summary(modelo_2)

#Representar el modelo
diabetes <- diabetes %>% mutate("probabilidad"=ifelse(diabetes=="pos",1,0)) #transformamos pos en 1 y neg en 0 creando una nueva columna probabilidad.
ggplot(diabetes,aes(x=glucose, y=probabilidad)) + geom_point() + geom_smooth(method="glm",method.args=list(family="binomial"))

#Realizar predicciones
nuevos_datos <- data.frame(glucose=c(80,120,230,90,60))
probs <- predict(modelo_2,nuevos_datos,type="response")
round(probs*100,1)
