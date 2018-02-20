if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, dplyr)


indy_buff <- st_read("Data/indy_corridor_buffer.shp")
indy_lehd <- st_read("Data/indy_lehd_NAD83.shp")

buff_crs <- st_crs(indy_buff)
indy_lehd <- st_transform(indy_lehd, crs = buff_crs)

corridor_poly <- st_join(indy_lehd, indy_buff, left = FALSE)
st_write(corridor_poly, "Data/indy_corridor_lehd_NAD83.shp", delete_dsn = TRUE)
