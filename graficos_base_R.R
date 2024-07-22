#Gráficos de líneas

coste <- 1:15
precio <- coste*2

plot(coste,precio, type="l")

plot(coste,precio, type="p",
     main="Relación entre coste y precio",
     xlab="Coste del producto",
     ylab="P.V.P.")

#Gráficos de barras

vendedores <- c("Juan","Silvia","María","Pedro")
ventas <- c(10000,15000,8000,20000)

barplot(ventas,names.arg = vendedores,
        main="Ventas por asesor",
        xlab="Asesores",
        ylab="Importe de ventas",
        horiz=FALSE,
        space=0.2,
        width = 4)

#Histograma

datos <- rnorm(2500) #distribución normal de 2500 números

hist(datos,
     main="Histograma de frecuencias",
     xlab="datos",
     ylab="frecuencias")

#Gráfico de dispersión

x <- rnorm(100)
y <- 2*x + rnorm(100)

plot(x,y,
     main="Diagrama de dispersión",
     xlab="X",
     ylab="Y")

?plot
