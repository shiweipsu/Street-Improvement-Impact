if(!require(pacman)){install.packages("pacman");library(pacman)}
p_load(readr, stringr, sf, purrr, tigris, dplyr)
options(tigris_class = "sf", tigris_use_cache = TRUE)

devtools::install_github("jamgreen/lehdr")
library(lehdr)

years <- 2012:2014
or_lehd <- map(years, grab_lodes, state = "or", job_type = "JT00", lodes_type = "wac", segment = "S000", download_dir = "Data")

#or_lehd <-lapply(years, grab_wac,state="or")
names(or_lehd) <- years
or_lehd_201214 <- bind_rows(or_lehd)

library(tidycensus)
library(sf)
options(tigris_class = "sf")

or_blocks <- blocks(state = "or")

or_lehd_201214 <- or_lehd_201214 %>% left_join(or_blocks,by=c("w_geocode"="GEOID10"))
or_lehd_2014 <- st_as_sf(or_lehd_2014)
plot(or_lehd_2014[2])
