#El análisis de series temporales nos permite detectar tendencias y patrones en un conjunto de datos que
#evolucionan con el tiempo. De esta manera, pueden generarse modelos para predecir y hacer proyecciones a
#futuro de ciertas variables cuantitativas.

install.packages("forecast")
library(forecast)

#Preparamos los datos
head(AirPassengers)
class(AirPassengers) #compramos que se trata de una serie temporal.
AirPassengers
plot(AirPassengers) #representamos como varían los pasajeros con el tiempo.
desc <- decompose(AirPassengers)#Descomponemos los datos en observed (todos), trend (tendencia), seasonal (datos que siguen patrón estacional), random (datos que no siguen patrón)
class(desc) #comprobamos que se trata de una serie temporal descompuesta.
plot(desc) #representamos la descomposición.

start(AirPassengers) #queremos saber el inicio y fin de nuestra serie temporal para poder dividirla en datos de entrenamiento del modelo y datos de test.
end(AirPassengers)

trainData <- window(AirPassengers, start=c(1949,1), end=c(1959,12)) #definimos los datos de entrenamiento hasta diciembre de 1959.
testData <- window(AirPassengers, start=c(1960,1), end=c(1960,12)) #definimos los datos de test dese enero hasta diciembre de 1960.

#Construimos el modelo. Para ello, aplicamos la función del modelo arima (Modelo autoregresivo de medias móviles, que busca patrones para hacer predicciones a futuro. Primero hay que entrenarlo para después poder testearlo.

modelo <- auto.arima(trainData) #entrenamiento

pred <- forecast(modelo, h=length(testData)) #testeo
plot(pred)

accuracy(pred, testData) #con esta función podemos visualizar las medidas asociadas al conjunto de datos de entrenamiento y de test. La MAPE (Mean Absolut Percentage Error) asociada a los datos de test es de apenas un 4%. Es, por lo tanto, un buen modelo de predicción de series temporales.
