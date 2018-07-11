source("Code/grab_place_lehd_func.R")

years <- 2004:2015
target_state <- "in"
target_county <- "marion"
target_place <- "Indianapolis city (balance)"

indy_lehd <- nitc_lehd(years = years, target_state = target_state, target_county = target_county, 
                       target_place = target_place)

st_write(indy_lehd, "Data/indy_lehd.shp", delete_dsn = TRUE)


