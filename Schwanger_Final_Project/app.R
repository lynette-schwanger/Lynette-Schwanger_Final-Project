
library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(tigris)

load("fenAppData.RData")

ui <- fluidPage(
  titlePanel("Eagle County Fen & Wetland Explorer"),
  h5("This map compares three different datasets that map wetlands and potential fens in Eagle County, Colorado"), 
  tags$ul(
    tags$li(strong("USFWS – Wetlands:"), "National Wetlands Inventory polygons."),
    tags$li(strong("CDOT – Potential Fens:"), "potential fens mapped by the Colorado Department of Transportation along transportation corridors."),
    tags$li(strong("CNHP – Potential Fens:"), "potential fens mapped by the Colorado Natural Heritage Program.")),
  p("The limited overlap between layers highlights how agency missions and survey designs shape where wetlands and fens have been mapped so far."),
  leafletOutput("map", height = "75vh"))

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
   
    leaflet() %>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      addPolygons(
        data = eagle_co,
        fill = FALSE,
        weight = 2,
        color = "black"
      ) %>%
      addPolygons(
        data = usfws_co_wetlands_crop,
        weight = 1,
        color = "purple",
        fillOpacity = 0.4,
        group = "USFWS - Wetlands"
      ) %>%
      addPolygons(
        data = cdot_fens_crop,
        weight = 1,
        color = "orange",
        fillOpacity = 0.7,
        group = "CDOT - Potential Fens"
      ) %>%
      addPolygons(
        data = cnhp_fens_crop,
        weight = 1,
        color = "darkgreen",
        fillOpacity = 0.6,
        group = "CNHP - Potential Fens"
      ) %>%
      addLegend(
        position = "topright",
        title    = "Data Source",
        colors   = c("purple", "orange", "darkgreen"),
        labels   = c("USFWS - Wetlands",
                     "CDOT - Potential Fens",
                     "CNHP - Potential Fens"),
        opacity  = 1
      ) %>%
    addLayersControl(
      overlayGroups = c("USFWS - Wetlands",
                        "CDOT - Potential Fens",
                        "CNHP - Potential Fens"),
      options = layersControlOptions(collapsed = FALSE))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
