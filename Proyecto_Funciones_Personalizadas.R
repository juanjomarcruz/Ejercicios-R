#Construir una funcion salario que, al indicarle el salario por hora,
# el número de horas trabajadas durae una semana por un trabajador, y la retención,
# en decimales, calcule y devuelva el salario neto y el salario bruto, considerando
# que si el número de horas trabajadas semanalmente es mayor a 45, se consideran
# horas extras y debe pagarse a un 50% más Por defecto las horas semanales son 40,
# y la retención un 2% (0.02).


salario <- function(coste_por_hora, horas_semanales=40, retencion=0.02){
  
  if (horas_semanales > 45){
    
    coste_horas_extra=1.5*coste_por_hora
    horas_extra=horas_semanales-45
    salario_bruto <- ((coste_horas_extra*horas_extra) + (45*coste_por_hora))
    
  } else {
    
    salario_bruto <- horas_semanales*coste_por_hora
    
  }
  
  salario_neto <- salario_bruto *(1-retencion)
  
  return(list("Salario Bruto"=salario_bruto, "Salario Neto"=salario_neto))
  
}

print(salario(coste_por_hora = 20))

# Calcular la media de un vector numérico, sumando todos sus elementos y dividiendo
# entre el número de elementos, sin emplear funciones de R (mean()). Emplee un bucle for.

media <- function(numeros){
  
  suma <- 0
  
  for (i in numeros){
    
    suma <- suma+i
    
  }
  
  media=suma/length(numeros)
  
  return(media)
  
}

numeros <- c(2,4,2,6,7)

numeros <- 1:11

print(media(numeros))

numeros <- c(1,2,1,3)

media <- function(numeros){
  
  suma <- 0
  contador <- 1 # en R los índices empiezan por 1, en Python por 0. Mucho ojo con esto. Por eso además en la condición del while ponemos <=.
  
  while (contador <= length(numeros)){
    
    suma <- suma + numeros[contador]
    contador <- contador + 1
    
  }
  
  media=suma/length(numeros)
  
  return(media)
  
}

media(numeros)

#La vectorización, es decir, operar sobre cada uno de los elementos de un vector, simplica el cálculo de la media de esta manera:

media <- function(x){
  
  sum(x)/length(x)
  
}

media(20:30)
      