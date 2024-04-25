#Define una variable llamada numero con el valor 10 y otra llamada nombre con tu nombre.
numero <- 10
nombre <- "Juan José Martínez Cruz"
#Utiliza las funciones class e is.numeric para determinar el tipo de dato de numero.
class(numero)
is.numeric(numero)
#Realiza una operación aritmética que sume numero y el doble de numero.
Suma <- numero + 2*numero
Suma
#Crea un vector llamado edades con las edades de tres personas y una lista llamada informacion con el nombre y la edad de una persona.
edades <- c(23,13,67)
informacion <- list("nombre"="Juan López Martínez","edad"=24)
edades
informacion
#Verifica si nombre es de tipo caracter y si es_numerico es de tipo lógico.
is.character(nombre)
is.logical(numero)
#Crea una variable llamada mayor_de_edad que sea TRUE si la edad de la primera persona en edades es mayor o igual a 18.
mayor_de_edad <- edades[1]>=8
mayor_de_edad
#Utiliza el operador %in% para verificar si el valor 30 está presente en el vector edades.
condicion <- 30 %in% edades
condicion
#Compara si el doble de numero es mayor que edades[3].
condicion_2 <- 2*numero > edades[3]
condicion_2
#Define dos variables lógicas, condicion1 y condicion2 , ambas con valor TRUE . Comprueba si ambas condiciones son verdaderas.
condicion1 <- TRUE
condicion2 <- TRUE
condicion3 <- condicion1 && condicion2 == TRUE
condicion3
#Define una variable lógica, verdadero , con valor TRUE . Comprueba que su valor NO sea verdadero.
verdadero <-- TRUE
condicion <-- verdadero != TRUE
condicion