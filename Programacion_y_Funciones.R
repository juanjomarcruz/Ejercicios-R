#Definir una función sin parámetros
saludo <- function(){
  print('Hola, bienvenido a R')
}
saludo()
# Crea una función llamada calificar_edad que tome un parámetro numérico llamado edad y
# muestre en la consola si la persona es "menor de edad" o "mayor de edad".

calificar_edad <- function(edad){
  
  if (!is.numeric(edad)){
    
    print('Introduce un número entero')
    
  } else if (is.numeric(edad) && edad != as.integer(edad)){
    
    print('Introduce una edad sin decimales')
    
  } else if (edad < 0){
    
    print('La edad no puede ser negativa')
    
  } else if(edad >=0 && edad<18){
    
    print('Eres menor de edad')
    
  } else {
    
    print('Eres mayor de edad')
  }
  
}

# Define una función llamada tabla_multiplicar que tome un parámetro numérico n e
# imprima la tabla de multiplicar del 1 al 10 de ese número

tabla_multiplicar <- function(n){
  for (i in 1:10){
    
    resultado=n*i
    print(paste(as.character(n),'*',as.character(i),'=',as.character(resultado)))
    
  }
}
tabla_multiplicar(2)

# Crea una función llamada numeros_pares que tome un parámetro numérico limite e imprima
# los números pares hasta ese límite

numeros_pares <- function(límite){
  v = c()
  i <- 2
  x <- 1
  while (i <= límite){
    v[x]=i
    i <- i + 2
    x <- x + 1
  }
  return(v)
}

print(numeros_pares(10))

# Define una función llamada matriz_cuadrada que tome un parámetro numérico n e imprima una
# matriz cuadrada de tamaño n x n donde los elementos son el resultado de la suma de sus índices de fila y columna.

matriz_cuadrada <- function(n){
  
  m <- matrix(0, nrow= n, ncol=n)
  
  for (i in 1:n){
    
    for (j in 1:n){
      
      m[i,j]=i+j
      
    }
    
  }
  return(m)
}

print(matriz_cuadrada(3))

