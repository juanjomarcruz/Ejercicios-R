#En este reto guiado utilizaremos el paquete de PimaIndiansDiabetes2, para predecir si una persona
#es diabética o no. Es decir, estaremos realizando una una tarea de clasificación.

#Para ello vamos a entrenar dos modelos distintos basados en dos algoritmos diferentes:
#KNN y Regresión logística

#El algoritmo KNN los indicará si una persona es diabética o no en función a los vecinos cercanos.
#Si los vecinos cercanos son diabéticos, establecerá que la variable a evaluar también lo es.

#El modelo de regresión logística se basa en que la variable de respuesta es dicotómica o binaria,
#es decir, tiene dos categorías posibles. En este caso sí o no.

#El dataset PimaIndiansDiabetes2 se encuentra en el paquete mlbench
install.packages("mlbench")
library(mlbench)
data("PimaIndiansDiabetes2", package = "mlbench")
head(PimaIndiansDiabetes2)

#Primero vamos a hacer el tratamiento de los datos, concretamente la partición de los mismos. Primero
#necesitamos cargar la librería caret, que nos aporta las funciones necesarias para machine learning,
#entre ellas, funciones para el pre-procesado de los datos.

library(caret)
library(dplyr)

set.seed(123) #creamos la semilla de la aleatoriedad, para que el experimento sea reproducible.

datos <- PimaIndiansDiabetes2 %>% select(pregnant,pressure,mass,pedigree,age,diabetes) %>% na.omit()

index <- createDataPartition(datos$diabetes,
                                 p=0.7,
                                 list=FALSE)
train_set <- datos[index,]
test_set <- datos[-index,]

#Regresión logística

#Definimos nuestra función de control, que irá ajustando el modelo probando con diferentes valores
#para cada parámetro hasta conseguir los más óptimos (mayor precisión del modelo para predecir outcome)

ctr <- trainControl(method="cv",number=10,verboseIter=TRUE)


lr_model <- train(diabetes~.,
                  method="glm",
                  data=datos,
                  trControl = ctr)

?predict

lr_model_prediction <- predict(lr_model,test_set)

confusionMatrix(lr_model_prediction,test_set$diabetes) #De 143 negativos ha clasificado 123 como negativos. Por otro lado, de 75 positivos ha clasificado 30 positivos y 45 negativos.

#KNN


knn_model <- train(diabetes~.,
                  method="knn",
                  data=datos,
                  trControl = ctr,
                  tuneGrid = expand.grid(k=seq(1,20,1)))

?predict

knn_model_prediction <- predict(knn_model,test_set)

confusionMatrix(knn_model_prediction,test_set$diabetes) #De 143 negativos ha clasificado 123 como negativos. Por otro lado, de 75 positivos ha clasificado 29 positivos y 46 negativos.

knn_model

plot(knn_model) 

#Para evaluar qué modelo se comporta mejor para este escenario, mediremos qué modelo detecta el
#mayor número de casos positivos. Para ello tendremos que fijarnos en el valor de "Specificity"
#o especificidad de la matriz de confusión.

#A través del análisis de los valores que nos ofrece la matriz de confusión, podemos ver que el
#modelo de regresión logística se comporta mejor que el modelo de KNN, ya que obtenemos un valor
#superior de especificidad, indicando que detecta mayor número de positivos.