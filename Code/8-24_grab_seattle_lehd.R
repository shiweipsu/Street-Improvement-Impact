#grab seattle lehd and upload to spatial db

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

seattle_lehd <- nitc_lehd(years = years, target_state = "WA", target_county = "King", 
                          target_place = "Seattle")

seattle_lehd$BLOCKCE10 <- NULL

names(seattle_lehd) <- tolower(names(seattle_lehd))

seattle_lehd <- seattle_lehd %>% filter(!is.na(state))

st_write(seattle_lehd, dsn = con, overwrite = TRUE, "seattle_lehd")

dbDisconnect(con)
