#Conexión y consulta a base de datos SQL

#Paquete RODBC
#install.packages("RODBC")

#Crear una conexión ODBC
con <- odbcConnect("mi_odbc_data_source")

#Ejecutar una consulta SQL
query <- "SELECT * FROM ventas"
resultado <- sqlQuery(con,query)

#Cerrar la conexión
odbcclose(con)

#Paquete RSQLite
#install.packages("RSQLite")

#Crear una conexión a una base de datos SQLite
con <- dbConnect(RSQLite::SQLite(),"mi_odbc_data_source")

#Ejecutar una consulta SQL
query <- "SELECT * FROM ventas"
resultado <- dbGetQuery(con,query)

#Cerrar la conexión
dbDisconnect(con)

#Paquete RMySQL
#install.packages("RMySQL")

#Crear una conexión a una base de datos MySQL
con <- dbConnect(RMySQL::MySQL(),
                 dnname="my_database",
                 host="localhost",
                 user="usuario",
                 password="contraseña")

#Ejecutar una consulta SQL
query <- "SELECT * FROM ventas"
resultado <- dbGetQuery(con,query)

#Cerrar la conexión
dbDisconnect(con)

#Paquete RPostgreSQL
#install.packages("RPostgreSQL")

#Crear una conexión a una base de datos PostgreSQL
con <- dbConnect(PostgreSQL(),
                 dnname="my_database",
                 host="localhost",
                 port= 5432,
                 user="usuario",
                 password="contraseña")

#Ejecutar una consulta SQL
query <- "SELECT * FROM ventas"
resultado <- dbGetQuery(con,query)

#Cerrar la conexión
dbDisconnect(con)