#isolate bicycle networks in Denver and San Francisco in commercial zones
if(!require("pacman")){install.packages("pacman"); library(pacman)}
p_load(sf, ggplot2, dplyr)

#this is WGS84
denver_zoning <-st_read("Data/zoning.shp")

#filter out bike lane, buffered bike lane, cycle track, bus/bike lane
denver_bike <- denver_bike %>% filter(EXISTING_F == "BL" | EXISTING_F == "BufBL"|
                                        EXISTING_F == "CT"| EXISTING_F == "B/BL")

#run intersect on the bike path and zoning district then filter
denver_bike <- denver_bike %>% st_join(denver_zommercial, left = FALSE)

#denver bike commercial corridors
st_write(denver_bike, "Data/Bicycle_Network/denver_bike_commercialzones.shp")

#san francisco zoning

sf_bike <- st_read(unzip("Data/Bicycle_Network/SFMTABikewayNetwork.zip"), quiet = TRUE)
file.remove(list.files(pattern = "geo_export*",recursive = F))

sf_zoning <- st_read(unzip("Data/San_FranZoningDistricts.zip"), quiet = TRUE)
file.remove(list.files(pattern = "geo_export*",recursive = F))

sf_zoning <- sf_zoning %>% filter(gen == "Commercial"| gen == "Mixed Use")
