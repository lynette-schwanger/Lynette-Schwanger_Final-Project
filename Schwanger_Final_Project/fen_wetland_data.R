
library(sf)
sf_use_s2(FALSE)
library(dplyr)
library(tigris)

usfws_co_wetlands <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg")

cdot_fens <- st_read("/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson")

co_counties <- counties(state = "CO")

lake_co <- co_counties %>% 
  filter(NAME == "Lake")

target_crs <- "EPSG:4326"

usfws_co_wetlands <- st_transform(usfws_co_wetlands, target_crs)

cdot_fens <- st_transform(cdot_fens,target_crs)  

lake_co <- st_transform(lake_co,target_crs)

co_counties <- co_counties %>%
  st_as_sf() %>%
  st_transform(target_crs)

bb <- st_bbox(lake_co)

bbox_string <- paste(
  bb["xmin"], bb["ymin"], bb["xmax"], bb["ymax"],
  sep = ","
)

cnhp_url <- paste0(
  "https://cnhp.colostate.edu/arcgis/rest/services/Wetland_Inv/Fen_Mapping/MapServer/0/query?",
  "geometry=", bbox_string,
  "&geometryType=esriGeometryEnvelope",
  "&inSR=4326",
  "&spatialRel=esriSpatialRelIntersects",
  "&where=1=1",
  "&outFields=*",
  "&f=geojson"
)

cnhp_fens <- st_read(cnhp_url)

cnhp_fens <- st_transform(cnhp_fens, target_crs)

usfws_co_wetlands_crop <- st_intersection(usfws_co_wetlands, lake_co)

cdot_fens_crop <- st_intersection(cdot_fens, lake_co)

cnhp_fens_crop <- st_intersection(cnhp_fens, lake_co)

save(usfws_co_wetlands_crop, cdot_fens_crop, cnhp_fens_crop, lake_co, file = "/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/Schwanger_Final_Project/fenAppData.RData")
  

