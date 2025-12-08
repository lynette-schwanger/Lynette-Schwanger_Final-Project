
library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(tigris)

load("fenAppData.RData")

ui <- fluidPage(
  titlePanel("Lake & Eagle County Fen & Wetland Explorer"),
  leafletOutput("map", height = "80vh")
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet() |>
      addProviderTiles("Esri.WorldTopoMap") |>
      addPolygons(
        data = lake_eagle,
        fill = FALSE,
        weight = 2,
        color = "black",
        group = "Counties"
      ) |>
      addPolygons(
        data = usfws_co_wetlands_crop,
        weight = 1,
        color = "blue",
        fillOpacity = 0.4,
        group = "Wetlands"
      ) |>
      addPolygons(
        data = cdot_fens_crop,
        weight = 1,
        color = "green",
        fillOpacity = 0.7,
        group = "Potential fens"
      ) |>
      addLayersControl(
        overlayGroups = c("Counties", "Wetlands", "Potential fens"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
