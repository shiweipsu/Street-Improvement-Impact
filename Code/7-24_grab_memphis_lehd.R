#grab memphis lehd and upload to spatial db

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf, tidyr,dplyr, dbplyr)

source(here::here("Code/grab_place_lehd_func.R"))

#query the corridors from bike_lanes
user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

years <- 2004:2015

memphis_lehd <- nitc_lehd(years = years, target_state = "TN", target_county = "Shelby", 
                          target_place = "Memphis")

memphis_lehd$BLOCKCE10 <- NULL

names(memphis_lehd) <- tolower(names(memphis_lehd))

memphis_lehd <- memphis_lehd %>% filter(!is.na(state))

st_write(memphis_lehd, dsn = con, overwrite = TRUE, "memphis_lehd")

dbDisconnect(con)
