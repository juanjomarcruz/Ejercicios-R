install.packages("RSQLite")
library(RSQLite)
library(DBI)
library(dplyr)
library(dbplyr)

data(package="mlbench",PimaIndiansDiabetes2) #Crearemos una base de datos a partir de este set de datos de R

#Nombramos la base de datos

db <-"PimaIndians.db"

#Crear conexión a la db
con <- dbConnect(SQLite(),dbname= db)
dbListTables(con) #comprobamos que no hay datos todavía en la base de datos db

#Almacenar el dataset PimaIndians en nuestra base de datos db

dbWriteTable(conn=con,    #conexión
                 name="Pima", #nombre de la tabla que se va a crear en la db
                 value = PimaIndiansDiabetes2)
dbListTables(con) #comprobamos que hay datos en la base de datos db

#Ejecutar la consulta SQL

#Queremos extraer aquellas mujeres que son diabéticas
query1 <- "SELECT * FROM Pima WHERE diabetes='pos'"
resultado1 <- RSQLite::dbGetQuery(conn = con, statement = query1)
resultado1
class(resultado1) #nos devuelve un dataframe, que es muy manejable en R.

#Queremos extraer aquellas mujeres que tienen glucosa por encima de 160 y tienen más de 50 años.
query2 <- "SELECT * FROM Pima WHERE glucose > 160 AND age>50"
resultado2 <- RSQLite::dbGetQuery(conn = con, statement = query2)
resultado2
class(resultado2) #nos devuelve un dataframe, que es muy manejable en R.

#Queremos extraer edad, imc y embarazos de mujeres que tienen glucosa por encima de 180.
query3 <- "SELECT age,mass,pregnant FROM Pima WHERE glucose > 180"
resultado3 <- RSQLite::dbGetQuery(conn = con, statement = query3)
resultado3
class(resultado3) #nos devuelve un dataframe, que es muy manejable en R.

#uso del paquete dbplyr para traducir operaciones de manipulación de datos que son propias del
#paquete dplyr en lenguaje SQL. Esto nos permite hacer consultas de datos alojados en bases de
#datos de SQL sin conocimiento del lenguaje SQL.

tbl(src=con,"Pima") #para ver la tabla Pima de nuestra base de datos denominada db (función del paquete dplyr)

#Queremos extraer aquellas mujeres que son diabéticas
q1 <- tbl(src=con,"Pima") %>% filter(diabetes=="pos")
show_query(q1) #se muestra nuestra query q1 traducida a lenguaje SQL

resultadosq1 <- q1 %>% collect() #la función collect recoge la consulta en una tibble (data.frame simplificado)
#Comprobamos que resultadosq1 es lo mismo que resultado1

#Queremos extraer aquellas mujeres que tienen glucosa por encima de 160 y tienen más de 50 años.
q2 <- tbl(src=con,"Pima") %>% filter(glucose>160 && age>50)
show_query(q2)
resultadosq2 <- q2 %>% collect() #Comprobamos que resultadosq2 es lo mismo que resultado2


#Queremos extraer edad, imc y embarazos de mujeres que tienen glucosa por encima de 180.
q3 <- tbl(src=con,"Pima") %>% filter(glucose>180) %>% select("age","mass","pregnant")
show_query(q3)
resultadosq3 <- q3 %>% collect() #Comprobamos que resultadosq3 es lo mismo que resultado3
