if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, dplyr)

#indianapolis 

indy_buff <- st_read("Data/indianapolis/indy_corridors.shp")
indy_lehd <- st_read("Data/indianapolis/indy_lehd.geojson")


buff_crs <- 5070

indy_buff <- st_transform(indy_buff, crs = buff_crs)
indy_lehd <- st_transform(indy_lehd, crs = buff_crs)

indy_buff <- st_buffer(indy_buff, dist = 15)

corridor_poly <- st_join(indy_lehd, indy_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 55:63)

st_write(corridor_poly, "Data/indianapolis/indy_corridor_lehd_NAD83.shp", delete_dsn = TRUE)

#minneapolis

minn_buff <- st_read("Data/minneapolis/minneapolis_corridorsNAD83.shp")
minn_lehd <- st_read("Data/minneapolis/minn_lehd.geojson")

buff_crs <- 5070

minn_lehd <- st_transform(minn_lehd, crs = buff_crs)
minn_buff <- st_transform(minn_buff, crs = buff_crs)

minn_buff <- st_buffer(minn_buff, dist = 15)

minn_lehd <- st_simplify(minn_lehd)

corridor_poly <- st_join(minn_lehd, minn_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 55:63)
st_write(corridor_poly, "Data/minneapolis/minn_corridor_lehd_wgs84.geojson", delete_dsn = TRUE)

#seattle 

seattle_buff <- st_read("Data/seattle/seattle_corridors.shp")
seattle_lehd <- st_read("Data/seattle/seattle_lehd.geojson")

buff_crs <- 5070
seattle_buff <- st_transform(seattle_buff, crs = buff_crs)
seattle_buff <- st_zm(seattle_buff)

seattle_lehd <- st_transform(seattle_lehd, crs = buff_crs)

seattle_buff <- st_buffer(seattle_buff, dist = 15)

corridor_poly <- st_join(seattle_lehd, seattle_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 55:63)
st_write(corridor_poly, "Data/seattle/seattle_corridor_lehd_NAD83.shp", delete_dsn = TRUE)
