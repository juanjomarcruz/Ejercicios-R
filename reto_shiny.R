#Creamos una app para analizar, con el dataset de diamantes, cómo varía el precio en función de la calidad
#del corte, los quilates y el color

#Cargamos librerías necesarias
library(shiny)
library(dplyr)
library(ggplot2)

#Defimimos la interfaz de usuario

ui <- fluidPage(
  titlePanel("DiamondsApp"),
  p("Empleamos el dataset diamonds"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable","Selecciona la variable", choices = c("carat","cut","color","clarity")), #Establecemos un desplegable con opciones.
      sliderInput("muestra","Tamaño de la muestra",
                  min=1000, #Establecemos el mínimo de la barra arrastrable
                  max=nrow(diamonds), #Establecemos el máximo de la barra selectora
                  value=min(5000,nrow(diamonds)), #Establecemos el comportamiento: el mínimo ira del 5000 al máximo.
                  step=500,#Se podrán seleccionar números de 500 en 500
                  round=0) #Siempre se seleccionarán números redondos. Sin decimales.          
    ),
    mainPanel(
      tabsetPanel(
      tabPanel("Gráfico de dispersión", plotOutput("scatterplot")),
      tabPanel("Gráfico de barras", plotOutput("bar")),
      tabPanel("Tabla",tableOutput("tabla"))
    )
  )
)
)

#Definimos el servidor

server <- function(input,output){
  output$scatterplot <- renderPlot({
    ggplot(data=diamonds[sample(nrow(diamonds),input$muestra),],
           aes_string(x=input$variable, y="price")) +
      geom_point()
  })
  
  output$bar <- renderPlot({
    ggplot(data=diamonds[sample(nrow(diamonds),input$muestra),],
           aes_string(x=input$variable)) +
      geom_bar()
  })
  
  output$tabla <- renderTable({
    diamonds[sample(nrow(diamonds),input$muestra),]
  })
}

shinyApp(ui,server)

