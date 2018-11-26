if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(dplyr, dbplyr, tigris, sf, here, RPostgreSQL)
options(tigris_class = "sf")

#upload new tidy tidy tax table to db

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

dc <- places(state = "dc")
dc <- st_transform(dc, crs = 5070)
dc <- st_cast(dc, "MULTIPOLYGON")

st_write(dsn = con, dc, "city_boundaries", append = TRUE)
