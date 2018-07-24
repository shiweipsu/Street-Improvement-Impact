#grab minneapolis lehd and upload to spatial db

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

minn_lehd <- nitc_lehd(years = years, target_state = "MN", target_county = "Hennepin", 
                          target_place = "Minneapolis")

minn_lehd$BLOCKCE10 <- NULL
names(minn_lehd) <- tolower(names(minn_lehd))

minn_lehd <- minn_lehd %>% filter(!is.na(state))

st_write(minn_lehd, dsn = con, overwrite = TRUE, "minneapolis_lehd")

dbDisconnect(con)
