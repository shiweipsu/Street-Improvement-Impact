if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, dplyr)


indy_buff <- st_read("Data/indianapolis/indy_corridor_buffer.shp")
indy_lehd <- st_read("Data/indianapolis/indy_lehd_NAD83.shp")

buff_crs <- st_crs(indy_buff)
indy_lehd <- st_transform(indy_lehd, crs = buff_crs)

corridor_poly <- st_join(indy_lehd, indy_buff, left = FALSE)
st_write(corridor_poly, "Data/indianapolis/indy_corridor_lehd_NAD83.shp", delete_dsn = TRUE)

#minneapolis

minn_buff <- st_read("Data/minneapolis/minneapolis_corridors_ConusAlbers.shp")
minn_lehd <- st_read("Data/minneapolis/minn_lehd.geojson")

buff_crs <- st_crs(minn_buff)

minn_lehd <- st_transform(minn_lehd, crs = buff_crs)

corridor_poly <- st_join(minn_lehd, minn_buff, left = FALSE)
corridor_poly <- corridor_poly %>% select(3:30, 58:64)
st_write(corridor_poly, "Data/minneapolis/minn_corridor_lehd_NAD83.shp", delete_dsn = TRUE)
