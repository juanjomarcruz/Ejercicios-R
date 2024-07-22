#Cargar librería caret

library(caret)

modelos <- getModelInfo() #Guardamos en la variable modelos la función getModelInfo del paquete caret.
                          #Esta función es clave para poder tener información de los modelos
names(modelos)            #Consultamos el nombre de los modelos de ML que hay disponibles en el paquete.

modelLookup("knn")        #Para saber algunos detalles de cada uno de los modelos: parámetros que tiene,
                          #para qué tareas de ML se pueden usar: clasificación / regresión / ambas.

data("mtcars")

#Regresión (predicción del consumo de los coches (mpg) en base al resto de variables del dataset mtcars)

set.seed(123) #Antes de separar los resultados en unos datos de entrenamiento y otros de test. Debemos hacer
              #que cada vez que R haga la partición de los datos, estas partes sean iguales. De esta manera,
              #los resultados serán replicables cuando compartamos el código. Esto se consigue con la función
              #set.seed() a la que le pasamos cuál va a ser la raíz para esa generación de números aleatorios
              #que nos va a permitir crear el índice.

index <- createDataPartition(mtcars$mpg,   #muestreamos según la columna de consumo de los coches.
                             p = 0.7,      #muestreamos el 70% de los datos para el entrenamiento. El resto serán de prueba.
                             list = FALSE) #no queremos que nos lo devuelva como una lista, para así poder
                                           #pasárselo directamente al dataset.

train_set <- mtcars[index,] #Establecemos datos de entrenamiento (24 filas muestreadas aleatoriamente, todas las columnas)
test_set <- mtcars[-index,] #Establecemos datos de prueba (8 filas restantes, todas las columnas)

#Función de control

ctr <- trainControl(method="cv", number=10, verboseIter = TRUE) #la función de control es útil para ajustar los parámetros del modelo
                                                                #de manera que va probando diferentes valores para esos parámetros y
                                                                #y detecta cuáles son los más óptimos. Aquellos más óptimos serán los
                                                                #que finalmente se emplearán en el modelo. Hemos elegido el método de
                                                                #control cross validation (cv) con 10 iteraciones y que en cada iteración
                                                                #nos vaya mostrando cuáles son los valores de los parámetros que está ajustando.

#Regresión lineal
#para entrenar a un modelo, usamos la función train()
lr_model <- train(mpg~.,              #vamos a predecir la variable mpg a partir del resto.
                  data = train_set,   #empleamos los datos de entrenamiento
                  method = "lm",      #y el método de regresión lineal
                  trControl = ctr)    #pasamos como argumento la función de control del modelo creada anteriormente.

#para probar el modelo, usamos la función predict()
lr_predict <- predict(lr_model,test_set)
lr_rmse <- sqrt(mean((lr_predict-test_set$mpg)^2)) #Calculamos el error cuadrático medio para conocer la precisión de nuestro modelo.
lr_rmse

#KNN
#para entrenar a un modelo, usamos la función train()
knn_model <- train(mpg~.,             #vamos a predecir la variable mpg a partir del resto.
                  data = train_set,   #empleamos los datos de entrenamiento
                  method = "knn",     #y el método knn
                  trControl = ctr,    #pasamos como argumento la función de control del modelo creada anteriormente.
                  tuneGrid = expand.grid(k=seq(1,20,1)))    #Establecemos que el parámetro K tome valores del 1 al 20 de uno en uno para ajustar el modelo.

#para probar el modelo, usamos la función predict()
knn_predict <- predict(knn_model,test_set)
knn_rmse <- sqrt(mean((knn_predict-test_set$mpg)^2)) #Calculamos el error cuadrático medio para conocer la precisión de nuestro modelo.
knn_rmse

knn_model

#Red Neuronal
#para entrenar a un modelo, usamos la función train()
neural_model <- train(mpg~.,             #vamos a predecir la variable mpg a partir del resto.
                   data = train_set,     #empleamos los datos de entrenamiento
                   method = "neuralnet", #y el método de red neuronal
                   trControl = ctr,      #pasamos como argumento la función de control del modelo creada anteriormente.
                   tuneGrid = expand.grid(layer1=c(1:3),layer2=c(1:3),layer3=0))    #Establecemos que la red neuronal tome de 1 a 3 neuronas en las capas 1 y 2 y ninguna en la capa 3 para ajustar el modelo.

#para probar el modelo, usamos la función predict()
neural_predict <- predict(neural_model,test_set)
neural_rmse <- sqrt(mean((neural_predict-test_set$mpg)^2)) #Calculamos el error cuadrático medio para conocer la precisión de nuestro modelo.
neural_rmse

neural_model

#Comparamos los tres algoritmos empleados para hacer la regresión. ¿Cuál es el más preciso?
cat("Regresión lineal",lr_rmse,"\n")
cat("KNN",knn_rmse,"\n")
cat("Red Neuronal",neural_rmse,"\n")

#El algoritmo KNN es el algoritmo más preciso para realizar la regresión lineal. Este será el que usaremos para la predicción de nuevos datos.


#Clasificación (empleamos el dataset iris para clasificar flores en diferentes especies según sus datos)

#Conocemos los datos
head(iris)
summary(iris)

#Cargamos los datos
data(iris)

#Hacemos que los resultados sean replicables cuando compartamos el código
set.seed(568)

#Creamos el índice para poder definir datos de entrenamiento y de prueba.
index <- createDataPartition(iris$Species,
                             p=0.7,
                             list = FALSE)

train_set <- iris[index,]
test_set <- iris[-index,]

#Definimos función de control para el ajuste de los parámetros del modelo.
ctr <- trainControl(method="cv", number=10, verboseIter = TRUE)

#Entrenamos el modelo que elegimos usar para clasificar. En este caso, KNN.
knn_classification_model <- train(Species~.,
                                  data=train_set,
                                  method="knn",
                                  trControl=ctr,
                                  tuneGrid=expand.grid(k=seq(2,15,1))
                                  )
knn_classification_model

#Hacemos la predicción para evaluar la precisión del modelo.
knn_class_predict <- predict(knn_classification_model,test_set)

#Para la evaluación de modelos de clasificación en machine learning, nos basaremos en las
#matrices de confusión, que proporciona un resumen visual de la precisión de un modelo al
#comparar las predicciones del modelo con los resultados reales:

confusionMatrix(knn_class_predict,test_set$Species)

#La matriz se organiza de la siguiente manera:
#Verdaderos Positivos (VP): La cantidad de observaciones que fueron correctamente clasificadas como positivas por el modelo.
#Verdaderos Negativos (VN): La cantidad de observaciones que fueron correctamente clasificadas como negativas por el modelo.
#Falsos Positivos (FP): La cantidad de observaciones que fueron incorrectamente clasificadas como positivas por el modelo (también conocidos como errores de Tipo I).
#Falsos Negativos (FN): La cantidad de observaciones que fueron incorrectamente clasificadas como negativas por el modelo (también conocidos como errores de Tipo II).

knn_class_predict
