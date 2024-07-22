#ggplot2 (datos, aes()) + geom_type()

install.packages("ggplot2")
install.packages("gapminder") #nos trae un dataset sobre datos de esperanza de vida por países y continentes.

library(ggplot2)
library(gapminder)
library(dplyr)

head(gapminder,n=5)

data_spain <- gapminder %>% filter(country=="Spain")
data_spain

ggplot(data=data_spain,aes(x=year,y=lifeExp)) + 
  geom_line(color="green") +
  geom_point(size=3,color="green") +
  geom_text(aes(label=lifeExp)) + #cuando especificamos un parámetro (p.e. label) respecto de una variable, siempre debemos hacerlo dentro de una función aes. Esto no hace falta si especificamos un
  #valor absoluto, por ejemplo, color="green".
  labs(title="Evolución de la esperanza de vida en España",
       x="Años",
       y="Esperanza de vida")                           

datos <- gapminder %>% select(country,continent) %>% group_by(continent) %>% filter(!duplicated(country))
datos

ggplot(data=datos)+
  geom_bar(aes(x=continent),fill="blue") +
  labs(title="Países por continente",x="Continente",y="Nº de países")

europe <- gapminder %>% filter(continent=="Europe")
europe

point <- ggplot(data=europe,aes(x=year,y=lifeExp)) +
               geom_point(aes(color=gdpPercap,size=pop),alpha=3/5) + #alpha para regular opacidad de los colores.
               labs(title="Evolución de la esperanza de vida en Europa",
                    x="Años",
                    y="Esperanza de vida") +
               theme(panel.background = element_blank()) + #para quitar el grid que aparece por defecto en el fondo.
               theme(legend.position = "none") #para quitar la leyenda.
point
