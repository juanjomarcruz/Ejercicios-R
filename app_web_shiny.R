#Instalamos el paquete Shiny
install.packages("shiny")

#Cargamos las librerías necesarias
library(shiny)
library(dplyr)

#Cargamos los datos de la librería mtcars
data(mtcars)

#La primera parte de un código de aplicación web en Shiny es la interfaz de usuario (UI).
ui <- fluidPage( #*
  titlePanel("Datos de automóviles"), #función para el título
  p("Empleamos datos del dataset mtcars"),
  sidebarLayout( #función para que aparezca barra lateral
    sidebarPanel( #función para activar panel de control lateral
      selectInput( #función para activar una caja con opciones para seleccionar
        "trans","Transmisión (0=AT,1=MA)", choices = unique(mtcars$am)) #Nombre de la variable del primer widget / Título del primer widget / opciones del desplegable, la opción elegida se guardará en la variable.
      ),
      mainPanel( #función para que aparezca panel principal
        plotOutput("scatterplot") #función para mostrar un gráfico, concretamente un gráfico de dispersión.
      )
  )
)

#*la función fluidPage sirve para que la aplicación web se comporte...
#*de manera automática en modo "responsive", de manera que los diferentes elementos de la página web..
#*se van colocando y autodimensionando según las dimensiones de la pantalla.

#La segunda parte de un código para desarrollar una aplicación web con Shiny es el servidor, que esconde la lógica que sigue la app.

server <- function(input,output){ #se genera una función server que recibe el input, en este caso una selección de un desplegable (una lista), y devuelve el output (gráfico dibujado)
  output$scatterplot <- renderPlot({ #definimos el output dibujando el gráfico con renderPlot
    
    muestra <- mtcars %>% filter(am==input$trans) #definimos una muestra de los datos, que en este caso es una selección de los registros donde am es igual a la selección (0 o 1).
    plot(muestra$hp,muestra$mpg, #función plot para generar el gráfico
         xlab="Potencia",
         ylab="Consumo",
         main=paste("Relación entre potencia y consumo por tipo de transmisión",input$trans))
  })
}

#La tercera y última parte del código debe ser la declaración de la aplicación web con la función shinyApp:
shinyApp(ui,server)
