#Test t de Student: comparar media de dos grupos
data(package="mlbench",PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2)

t <- t.test(glucose~diabetes, data = PimaIndiansDiabetes2)
t

#Cuanto mayor sea el valor absoluto del estadístico t, más significativa será la diferencia de medias.
#Si el intervalo de confianza incluye el 0, no podemos rechazar la hipótesis nula. En este caso, no lo contiene.
#El p-valor es menor al nivel de significación (0.05), por lo que se rechaza la hipótesis nula.

#Test ANOVA: comparar media de múltiples grupos
data(package="ggplot2",diamonds)
anova <- aov(price~cut, data=diamonds)
print(summary(anova))

#Test de Chi-cuadrado: relación entre dos variables categóricas
tabla_contingencia <- table(diamonds$cut,diamonds$color)
tabla_contingencia

chi_cuadrado <- chisq.test(tabla_contingencia)
chi_cuadrado

#Test de correlación de Pearson: relacion lineal entre dos variables
cor_test <- cor.test(PimaIndiansDiabetes2$glucose,PimaIndiansDiabetes2$mass)
cor_test

#Test de Wilcoxon: Medianas de dos grupos, no normalidad
precio_antes <- diamonds$price[1:100]
precio_despues <- diamonds$price[101:200]

wilcoxon <- wilcox.test(precio_antes,precio_despues,paired = TRUE)
print(wilcoxon)
