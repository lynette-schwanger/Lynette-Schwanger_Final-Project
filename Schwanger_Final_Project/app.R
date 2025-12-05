

knitr::opts_chunk$set(echo = TRUE)

library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(tigris)

usfws_co_wetlands <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg")

cdot_fens <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson")

# Run the application 
shinyApp(ui = ui, server = server)
