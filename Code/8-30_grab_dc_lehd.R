#grabbing and updated DC LEHD
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, dplyr, sf, dbplyr, tigris, devtools)
options(tigris_class = "sf")

install_github("jamgreen/lehdr")
library(lehdr)



#query the corridors from bike_lanes
user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

state <- "dc"
years <- 2010:2015


dc_lehd <- grab_lodes(state = state, year = years, lodes_type = "wac", 
                      job_type = "JT01", segment = "S000",
                      agg_geo = "block", download_dir = here::here("dc_lehd"))

dc_lehd <- dc_lehd %>% 
  select(geoid10 = w_geocode, c000 = C000, cns07 = CNS07, cns12 = CNS12,
         cns14 = CNS14, cns15 = CNS15, cns16 = CNS16, cns17 = CNS17, cns18 = CNS18,
         cns19 = CNS19, year, state)

dc_blocks <- blocks(state = "dc")
dc_blocks <- dc_blocks %>% 
  select(GEOID10, geometry)

dc_lehd <- dc_lehd %>% left_join(dc_blocks, by = c("geoid10" = "GEOID10"))
dc_lehd <- dc_lehd %>% st_as_sf()

dc_lehd <- dc_lehd %>% st_transform(crs = 5070)
dc_lehd <- dc_lehd %>% rename(geom = geometry)

st_write(dc_lehd, dsn = con,layer = "dc_lehd", delete_dsn = TRUE, overwrite = TRUE)
