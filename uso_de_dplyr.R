write.csv(x=datasets::HairEyeColor,file="C:/Users/juanj/Documents/GitHub/Ejercicios R/HairEyeColor.csv", sep=",", row.names = FALSE, col.names = TRUE)

install.packages('dplyr')
library(dplyr)

df <- read.csv('C:/Users/juanj/Documents/GitHub/Ejercicios R/HairEyeColor.csv')
head(df)

Males <- df %>% filter(Sex=='Male')
head(Males)

seleccionar <- Males %>% select(Hair,Eye)
head(seleccionar)

brown_eyes <- seleccionar %>% mutate(brown_eyes= ifelse(Eye=='Brown','Yes','No'))
head(brown_eyes)

brown_eyes <- brown_eyes %>% arrange(desc(Hair))
brown_eyes


