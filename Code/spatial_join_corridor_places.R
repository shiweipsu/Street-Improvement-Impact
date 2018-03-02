if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, dplyr)


indy_buff <- st_read("Data/indianapolis/indy_corridor_buffer.shp")
indy_lehd <- st_read("Data/indianapolis/indy_lehd_NAD83.shp")

buff_crs <- st_crs(indy_buff)
indy_lehd <- st_transform(indy_lehd, crs = buff_crs)

corridor_poly <- st_join(indy_lehd, indy_buff, left = FALSE)
st_write(corridor_poly, "Data/indianapolis/indy_corridor_lehd_NAD83.shp", delete_dsn = TRUE)

#minneapolis

minn_buff <- st_read("Data/minneapolis/minneapolis_corridorsNAD83.shp")
minn_lehd <- st_read("Data/minneapolis/minn_lehd.geojson")


buff_crs <- st_crs(minn_buff)

minn_lehd <- st_transform(minn_lehd, crs = buff_crs)

corridor_poly <- st_join(minn_lehd, minn_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 55:63)
st_write(corridor_poly, "Data/minneapolis/minn_corridor_lehd_NAD83.shp", delete_dsn = TRUE)

#seattle 

seattle_buff <- st_read("Data/seattle/seattle_corridors.shp")
seattle_lehd <- st_read("Data/seattle/seattle_lehd.geojson")

buff_crs <- 5070
seattle_buff <- st_transform(seattle_buff, crs = buff_crs)
seattle_buff <- st_zm(seattle_buff)

seattle_lehd <- st_transform(seattle_lehd, crs = buff_crs)

seattle_buff <- st_buffer(seattle_buff, dist = 10)

corridor_poly <- st_join(seattle_lehd, seattle_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 55:63)
st_write(corridor_poly, "Data/seattle/seattle_corridor_lehd_NAD83.shp", delete_dsn = TRUE)
