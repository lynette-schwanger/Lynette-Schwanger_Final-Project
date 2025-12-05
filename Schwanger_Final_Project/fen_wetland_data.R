# prep data

library(sf)
library(dplyr)
library(tigris)

usfws_co_wetlands <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg")

cdot_fens <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson")

co_counties <- counties(state = "CO")

target_crs <- "EPSG:4326"

usfws_co_wetlands <- st_transform(usfws_co_wetlands, target_crs)

cdot_fens <- st_transform(cdot_fens,target_crs)   

co_counties <- co_counties %>%
  st_as_sf() %>%
  st_transform(target_crs)

lake_eagle_co <- co_counties %>%
  
