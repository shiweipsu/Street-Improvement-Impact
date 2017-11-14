#bring in bike network for pdx, pull out the improved lanes and join to commercial


if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, stringr, ggplot2, dplyr)

pdx_bike <- st_read("https://opendata.arcgis.com/datasets/dbba62f675ba4847968c3bd5dbf9345a_75.geojson")

pdx_bike <- pdx_bike %>% filter(YearBuilt >= 2010, Facility == "BBL" | Facility == "SIR")

pdx_zoning <- st_read("https://opendata.arcgis.com/datasets/7950361b922344b8a0d321445c86b128_16.geojson")

pdx_commercial <- pdx_zoning %>% filter(str_detect(ZONE_DESC, "Commercial")|
                                          str_detect(ZONE_DESC, "Central Employment"))

pdx_bike <- st_join(pdx_bike, pdx_commercial, left = FALSE)

st_write(pdx_bike, "Data/Bicycle_Network/pdx_bike_network_Green.shp", delete_dsn = TRUE)

rm(pdx_bike, pdx_commercial, pdx_zoning)
