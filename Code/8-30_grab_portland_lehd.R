#grab portland lehd and upload to spatial db

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

years <- 2004:2015

portland_lehd <- nitc_lehd(years = years, target_state = "OR", target_county = "Multnomah", 
                          target_place = "Portland")

portland_lehd$BLOCKCE10 <- NULL

names(portland_lehd) <- tolower(names(portland_lehd))

portland_lehd <- portland_lehd %>% filter(!is.na(state)) %>% st_transform(5070)

st_write(portland_lehd, dsn = con, overwrite = TRUE, "portland_lehd",geom_col="geometry")

dbDisconnect(con)
