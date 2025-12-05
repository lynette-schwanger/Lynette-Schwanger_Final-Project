

knitr::opts_chunk$set(echo = TRUE)

source("setup.R")

usfws_co_wetlands <- "/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/CO_geopackage_wetlands.gpkg"

cdot_fens <- "/Users/lynetteschwanger/Desktop/Env-Data-Sci_2025/Lynette-Schwanger_Final-Project/data/Potential_Fen_Wetlands.geojson"

# Run the application 
shinyApp(ui = ui, server = server)
