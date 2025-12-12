
library(sf)
sf_use_s2(FALSE)
library(dplyr)
library(tigris)

usfws_co_wetlands <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg")

cdot_fens <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson")

cnhp_fens <- st_read("https://cnhp.colostate.edu/arcgis/rest/services/Wetland_Inv/Fen_Mapping/MapServer/0/query?where=1=1&outFields=*&resultRecordCount=12000&f=geojson")

co_counties <- counties(state = "CO")

eagle_co <- co_counties %>% 
  filter(NAME == "Eagle")

eagle_water <- linear_water(state  = "CO", county = "Eagle")

target_crs <- "EPSG:4326"

usfws_co_wetlands <- st_transform(usfws_co_wetlands, target_crs)

cdot_fens <- st_transform(cdot_fens,target_crs)  

cnhp_fens <- st_transform(cnhp_fens, target_crs)

eagle_co <- st_transform(eagle_co,target_crs)

eagle_water <- st_transform(eagle_water,target_crs)

usfws_co_wetlands_crop <- st_intersection(usfws_co_wetlands, eagle_co)

cdot_fens_crop <- st_intersection(cdot_fens, eagle_co)

cnhp_fens_crop <- st_intersection(cnhp_fens, eagle_co)

eagle_water_crop <- st_intersection(eagle_water, eagle_co)

save(usfws_co_wetlands_crop, cdot_fens_crop, cnhp_fens_crop, eagle_co, eagle_water_crop, file = "/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/Schwanger_Final_Project/fenAppData.RData")
  

