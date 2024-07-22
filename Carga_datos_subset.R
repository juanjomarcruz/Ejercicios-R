#Leer el excel mtcars
library(readxl)

data_cars <- read_excel(path='C:/Users/juanj/Desktop/ThePower Business School/Documentación - Data Transformation & Manipulation/mtcars.xlsx', sheet='cars')
excel_sheets(path='C:/Users/juanj/Desktop/ThePower Business School/Documentación - Data Transformation & Manipulation/mtcars.xlsx')

head(data_cars,5)

?mtcars

automatic_cars <- data_cars[data_cars$am==0,]
head(automatic_cars,5)

resumen_at <- automatic_cars[,c("mpg","cyl","hp","gear")]

data_cars[data_cars$]

library(rvest)
 
data_jump <- read_html(url)
jump_tables <- html_table(html_elements(data_jump,'table'))
jump_my_table <- jump_tables[[3]]

class(jump_my_table)
head(jump_my_table,n=5)
tail(jump_my_table,n=5)

jump_my_table$Mark

records_in_ny <- jump_my_table[jump_my_table$Venue=='New York',]
records_in_ny
