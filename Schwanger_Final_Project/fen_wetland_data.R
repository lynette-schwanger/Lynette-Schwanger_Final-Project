
library(sf)
sf_use_s2(FALSE)
library(dplyr)
library(tigris)

usfws_co_wetlands <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg")

cdot_fens <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson")

cnhp_fens <- st_read("https://cnhp.colostate.edu/arcgis/rest/services/Wetland_Inv/Fen_Mapping/MapServer/0/query?where=1=1&outFields=*&f=geojson")

co_counties <- counties(state = "CO")

lake_eagle <- co_counties %>% 
  filter(NAME %in% c("Eagle", "Lake"))

lake_eagle_water <- linear_water(
  state  = "CO",
  county = c("Lake", "Eagle"))

target_crs <- "EPSG:4326"

usfws_co_wetlands <- st_transform(usfws_co_wetlands, target_crs)

cdot_fens <- st_transform(cdot_fens,target_crs)  

lake_eagle <- st_transform(lake_eagle,target_crs)

lake_eagle_water <- st_transform(lake_eagle_water,target_crs)

co_counties <- co_counties %>%
  st_as_sf() %>%
  st_transform(target_crs)

usfws_co_wetlands_crop <- st_intersection(usfws_co_wetlands, lake_eagle)

cdot_fens_crop <- st_intersection(cdot_fens, lake_eagle)

save(usfws_co_wetlands_crop, cdot_fens_crop, lake_eagle, lake_eagle_water, file = "fenAppData.RData")
  
