#grab indianapolis lehd data and upload to bike_lanes

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, here, RPostgreSQL)
options(tigris_class = "sf")

source("Code/grab_place_lehd_func.R")

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)


years <- 2004:2015
target_state <- "in"
target_county <- "marion"
target_place <- "Indianapolis city (balance)"

indy_lehd <- nitc_lehd(years = years, target_state = target_state, target_county = target_county, 
                       target_place = target_place)

names(indy_lehd) <- tolower(names(indy_lehd))

st_write(dsn = con, indy_lehd, overwrite = TRUE)


