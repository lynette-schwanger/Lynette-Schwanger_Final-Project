
library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(tigris)

load("fenAppData.RData")

ui <- fluidPage(
  titlePanel("Lake County Fen & Wetland Explorer"),
  leafletOutput("map", height = "80vh"))

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
   
     bb <- st_bbox(lake_eagle)
     center_lon <- as.numeric((bb["xmin"] + bb["xmax"]) / 2)
     center_lat <- as.numeric((bb["ymin"] + bb["ymax"]) / 2)
     
    leaflet() %>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      addPolygons(
        data = lake_co,
        fill = FALSE,
        weight = 2,
        color = "black",
        group = "Counties"
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
        group = "CNHP fen polygons"
      ) %>%
      addLayersControl(
        overlayGroups = c("Counties", "USFWS Mapped Wetlands", "CDOT mapped fens", "CNHP fen polygons"),
        options = layersControlOptions(collapsed = FALSE)
      ) %>%
      setView(lng = center_lon, lat = center_lat, zoom = 9.5)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
