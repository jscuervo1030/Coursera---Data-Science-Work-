
# Developing Data Products Course Project 

## By: Juan Sebastian Cuervo 
## ui.R file

## The following code explains the code for loading the ui.server program 


## 1. We first load the required libraries from R for our server

library(shiny)
library(leaflet)

## We build the required interface 

shinyUI(fluidPage(
  titlePanel("Mapping Location Application - Point a Place in the World "),
  sidebarLayout(
    sidebarPanel(
      sliderInput("long","Select the Longitude",
                  -180, 180, value = 0),
      sliderInput("lat","Select the Latitude",
                  -90, 90, value = 0),
      
      textInput("Text1","What message do you want in the marker?", "Write in Here"),
      actionButton("execute", "Execute")
      ),
    mainPanel(
      h3("Interactive Map of the World by Juan Sebastian Cuervo"),
      leafletOutput("mymap")
     )
  )
))

