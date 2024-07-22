install.packages("mlbench")

library(mlbench)
library(ggplot2)
library(stringr)
library(dplyr)

?mpg

head(mpg, n=5)


#Histograma

ggplot(data=mpg, aes(x=cyl)) + geom_histogram(binwidth = 0.7, fill="red",color="black") +
  labs(title="Distribución de cilindrada",
       x="Cilindros",
       y="Número de coches")

#Gráfico de barras

ggplot(data=mpg, aes(x=class)) + geom_bar(aes(fill=manufacturer)) +
  labs(title="Distribución de coches por clase",
       x="Clase",
       y="Número de coches") +
  theme(panel.background = element_blank(),plot.title = element_text(color="red")) +
  theme(legend.position = "None")

#Boxplot

mpg$trans <- mpg$trans %>% str_sub(1,-5)

ggplot(data=mpg, aes(x=trans, y=cty)) +
  geom_boxplot(aes(fill=trans)) +
  labs(title="Consumo urbano por Transmisión",
       x="Transmisión",
       y="Consumo urbano") +
  theme(legend.position = "none",panel.background = element_blank())
  
#Dispersión

ggplot(data=mpg,aes(x=cty,y=hwy)) +
  geom_point(aes(color=class,size=cyl)) +
  facet_wrap(~trans)
