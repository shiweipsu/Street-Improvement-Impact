#isolate bicycle networks in Denver and San Francisco in commercial zones
if(!require("pacman")){install.packages("pacman"); library(pacman)}
p_load(sf, ggplot2, dplyr)

#this is WGS84
denver_zoning <-st_read("Data/zoning.shp")
denver_commercial <- denver_zoning %>% 
  filter(ZONE_DIST_ == "Commercial Mixed Use")

denver_bike <- st_read(unzip("Data/Bicycle_Network/denver_bicycle_facilities.zip"), 
                       quiet = TRUE)

#removed the unzipped bicycle network folder

#filter out bike lane, buffered bike lane, cycle track, bus/bike lane
denver_bike <- denver_bike %>% filter(EXISTING_F == "BL" | EXISTING_F == "BufBL"|
                                        EXISTING_F == "CT"| EXISTING_F == "B/BL")

denver_bike$YEAR_BUILT <- as.character(denver_bike$YEAR_BUILT)
denver_bike$YEAR_BUILT <- as.numeric(denver_bike$YEAR_BUILT)

denver_bike <- denver_bike %>% filter(YEAR_BUILT > 2008)

#run intersect on the bike path and zoning district then filter
denver_bike <- denver_bike %>% st_join(denver_commercial, left = FALSE)

#denver bike commercial corridors
st_write(denver_bike, "Data/Bicycle_Network/denver_bike_commercialzones.shp", delete_dsn = TRUE)

#san francisco zoning

sf_bike <- st_read(unzip("Data/Bicycle_Network/SFMTABikewayNetwork.zip"), quiet = TRUE)
file.remove(list.files(pattern = "geo_export*",recursive = F))

sf_bike <- sf_bike %>% filter(install_ye > 2008)
sf_bike <- sf_bike %>% filter(innovative == "BIKE BOULEVARD"| innovative == "BUFFERED BIKE LANE" |
                                innovative == "SEPARATED BIKEWAY")

sf_zoning <- st_read(unzip("Data/San_FranZoningDistricts.zip"), quiet = TRUE)
file.remove(list.files(pattern = "geo_export*",recursive = F))

sf_zoning <- sf_zoning %>% filter(gen == "Commercial"| gen == "Mixed Use")

sf_bike <- st_join(sf_bike, sf_zoning, left = FALSE)
st_write(sf_bike, "Data/Bicycle_Network/sf_bike_commercialzones.shp", delete_dsn = TRUE)

rm(denver_bike, denver_commercial, denver_zoning, sf_bike, sf_zoning)
