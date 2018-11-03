# checking on NETS subset
install.packages(c("dplyr", "sf"))
library(dplyr)
library(sf)


nets <- readRDS("Data/NETS_NITC_RETAIL.RDS")

cities <- nets %>% group_by(City) %>% tally()

nets <- nets %>% mutate(Longitude = Longitude*-1)
nets_sf <- st_as_sf(nets, coords = c("Longitude", "Latitude"), crs = 4326)


plot(nets_sf[5])

st_write(nets_sf, "Data/retail_NETS.shp", delete_dsn  = TRUE)
readr::write_csv(nets, "Data/NETS_Retail_NITC.csv")
