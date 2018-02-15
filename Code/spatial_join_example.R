if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, dplyr)


indy_buff <- st_read("Data/indy_corridor_buffer.shp")
indy_lehd <- st_read("Data/indy_lehd_NAD83.shp")

corridor_lehd <- st_intersection(indy_buff, indy_lehd)

corridor_poly <- st_join(indy_lehd, indy_buff, left = FALSE)
