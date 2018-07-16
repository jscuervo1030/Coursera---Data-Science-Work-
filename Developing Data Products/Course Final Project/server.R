
# Developing Data Products Course Project 

## By: Juan Sebastian Cuervo 
## ui.R file

## The following code explains the code for loading the ui.server program 

# Load the Required Libraries in R

library(shiny)
library(leaflet)


shinyServer(function(input,output){
  
    points <- eventReactive(input$execute, {
    cbind(input$long,input$lat)
  }, ignoreNULL = FALSE)
    messages <- eventReactive(input$execute,input$Text1,ignoreNULL = FALSE) 
      
    
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      setView(lng= 0, lat = 0 , zoom = 2)%>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points(), popup = messages())
  })
  
  
})
