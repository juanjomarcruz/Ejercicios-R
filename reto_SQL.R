
#¿Qué vamos a hacer?
# 1- Crear una base de datos de SQLite
# 2- Crear en esa bd las tablas who y ppopulation, basada en los datasets homónimos
#sobre datos de población y tuberculosis
# 3- Consulta SQL para crear un data.frame con las columnas:
# País, Año, Nuevos Casos, población total(de cada año)
# siguiendo estos criterios:
# - Sólo casos en España y México
# - Sólo casos entre 2001 y 2008
# - Sólo casos de mujeres entre 45 y 54 años
# Realizar la misma operación empleando dplyr, y mostrar qué consulta SQL construye

#install.packages("tidyverse")
library(RSQLite)
library(tidyverse) #aquí se aloja el dataset que emplearemos para crear la base de datos
library(DBI)


#Nombramos la base de datos
db <- "tuberculosis.db"

#Creamos la conexión a la base de datos
con <- RSQLite::dbConnect(SQLite(),dbname=db)
dbListTables(con)

#Añadir información a la base de datos
dbWriteTable(conn=con,
             name="ppopulation",
             value=population)
dbListTables(con)

dbWriteTable(conn=con,
             name="who",
             value=who)
dbListTables(con)

tbl(con,"ppopulation")
tbl(con,"who")

#Construimos sentencias SQL
select <- "SELECT who.year, who.country, who.new_sp_f4554,ppopulation.population"
from <- "FROM who"
left_join <- "LEFT JOIN ppopulation ON who.country = ppopulation.country AND who.year = ppopulation.year"
where <- "WHERE (who.country= 'Spain' or who.country = 'Mexico') AND (who.year >= 2001 AND who.year <= 2008)"

query <- paste(select,from,left_join,where)
query

resultado <- RSQLite::dbGetQuery(conn=con, statement = query)
class(resultado)

#Usando dplyr

query_dplyr <- tbl(con,"who") %>%
  filter(country %in% c("Spain","Mexico"), year>=2001 && year<= 2008) %>%
  select("country","year","new_sp_f4554") %>%
  left_join(y=tbl(con,"ppopulation"), by=c("country","year")) %>%
show_query(query_dplyr)

resultado_dplyr <- query_dplyr %>% collect() #es lo mismo que resultado.
