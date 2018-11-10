#grab san francisco lehd and upload to spatial db

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf, tidyr,dplyr, dbplyr)

source(here::here("Code/grab_place_lehd_func.R"))

#query the corridors from bike_lanes
user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

sf_corridor <- st_read(here::here("Data/sanfrancisco/sf_corridors.shp")) 
names(sf_corridor) <- tolower(names(sf_corridor))

years <- 2004:2015

sf_lehd <- nitc_lehd(years = years, target_state = "CA", target_county = "San Francisco", 
                          target_place = "San Francisco")

sf_lehd$BLOCKCE10 <- NULL

names(sf_lehd) <- tolower(names(sf_lehd))

sf_lehd <- sf_lehd %>% filter(!is.na(state))


sf_rac <- nitc_rac(years = years, target_state = "CA", target_county = "San Francisco", 
                         target_place = "San Francisco")

sf_rac$BLOCKCE10 <- NULL

names(sf_rac) <- tolower(names(sf_rac))

sf_rac <- sf_rac %>% filter(!is.na(state)) %>% st_transform(5070)

st_write(sf_lehd, dsn = con, overwrite = TRUE, "sf_lehd")
st_write(sf_corridor, dsn = con, overwrite = TRUE, "sf_corridor")
st_write(sf_rac, dsn = con, overwrite = TRUE, "sf_rac",geom_col="geometry")


dbDisconnect(con)
