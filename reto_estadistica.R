data(package="mlbench",PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2,10)

#Análisis estadístico
mean(PimaIndiansDiabetes2$glucose,na.rm = TRUE)
sd(PimaIndiansDiabetes2$glucose, na.rm = TRUE)

summary(PimaIndiansDiabetes2$glucose)

table(PimaIndiansDiabetes2$diabetes) #frecuencias absolutas
prop.table(table(PimaIndiansDiabetes2$diabetes)) #frecuencias relativas

summary(PimaIndiansDiabetes2)

hist(PimaIndiansDiabetes2$glucose,main="Distribución de los niveles de glucosa",xlab="Glucosa en sangre (mg/ml)", ylab="Frecuencia")

t <- t.test(glucose ~ diabetes, data = PimaIndiansDiabetes2)
t

library(dplyr)
datos <- PimaIndiansDiabetes2 %>% na.omit()
cor(datos$glucose,datos$pressure)

#Utilizaremos otro set de datos, mtcars, para realizar un análisis estadístico con representaciones más
#complejas en ggplot2, en el que probaremos la validez de la hipótesis nula o alternativa.

#Datos sobre el consumo en millas por galón de una serie de vehículos.
#Vamos a analizar la relación entre los caballos de fuerza, el número de cilindros, los litros, el peso,
#y la transmisión, con el consumo en millas por galón.

library(readxl)
library(writexl)
library(ggplot2)

mtcars_with_row_names <- cbind(Modelo=rownames(mtcars),mtcars)
write_xlsx(mtcars_with_row_names, path="GitHub/Ejercicios R/mtcars.xlsx")
datos <- read_excel("GitHub/Ejercicios R/mtcars.xlsx")
head(datos)

clean_datos <- datos %>% select(mpg,cyl,disp,hp,wt,am) %>%
  mutate(am=factor(am, level = c(0,1), labels=c("automático","manual")), cyl=as.factor(cyl))
summary(clean_datos)

correlation <- cor(clean_datos[,c("mpg","disp","hp","wt")]) #generamos una matriz de correlación con todas las filas y las variables (columnas) que queremos.
pairs(clean_datos[,c("mpg","disp","hp","wt")]) #para ver las correlaciones gráficamente

ggplot(data=clean_datos, aes(x=am,y=mpg,fill=am)) +
  geom_boxplot() +
  labs(title="Relación entre consumo y tipo de transmisión",
       x="Tipo de transmisión",
       y="Consumo (Millas por galón)")

ggplot(data=clean_datos, aes(x=cyl,y=mpg,fill=cyl)) +
  geom_boxplot() +
  labs(title="Relación entre consumo y número de cilindros",
       x="Número de cilindros",
       y="Consumo (Millas por galón)")

t <- t.test(mpg ~ am, clean_datos)
t

anova <- aov(mpg ~ cyl, data=clean_datos) #existen más de dos cilindradas (tres grupos con tres medias diferentes para el consumo)
summary(anova)

model <- lm(mpg ~ hp + disp + wt, data=clean_datos)
summary(model)

#R cuadrado = 0.8268 es el porcentaje que estamos explicando de la variable mpg gracias a esas 3 variables independientes.
#Las variables más influyentes en el consumo son, por orden: wt y hp. disp no influye apenas.
