#downloading lehd for each city
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(devtools, tigris, sf, dplyr)
options(tigris_class = "sf")

install_github("jamgreen/lehdr")
library(lehdr)

#Seattle-----

years <- 2004:2015

wa_lehd <- grab_lodes(state = "wa", year = years, lodes_type = "wac", 
                      job_type = "JT01", segment = "S000",download_dir = "Data/wa_lehd")

seattle.sf <- places(state = "WA")
seattle.sf <- seattle.sf %>% filter(NAME == "Seattle")

wa_blocks <- blocks("wa", county = "King")

seattle_blocks <- st_intersection(seattle.sf, wa_blocks)

seattle_lehd <- seattle_blocks %>% 
  left_join(wa_lehd, by = c("GEOID10" = "w_geocode"))

seattle_lehd <- seattle_lehd %>% select(4:5, 21, 34:84, 86:88)
#feature 332 was spitting out an error...i just dropped it
seattle_lehd <- seattle_lehd[-332,]

st_write(seattle_lehd, "Data/seattle_lehd.geojson")
