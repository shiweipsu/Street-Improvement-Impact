#install older version of pacman and load in packages

install.packages("devtools", repos='http://cran.us.r-project.org/')
library(devtools)

install_version('pacman', version = "0.4.6",
                 dependencies=TRUE, repos='http://cran.us.r-project.org/')
library(pacman)
p_load(tigris, dplyr, sf, here, RPostgreSQL, purrr, glue)
options(tigris_type = "sf")

#connect to bike_lanes for upload

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

#download city boundaries and upload to db
nitc_states <- c("IN", "MN", "DC", "TN", "WA", "PA")

city_list <- c("Minneapolis", "Seattle", "Washington", 
               "Indianapolis city (balance)", 
               "Memphis", "Pittsburgh")

nitc_cities <- places(state = nitc_states) 
nitc_cities <- st_as_sf(nitc_cities)


nitc_cities2 <- nitc_cities %>% filter(NAME %in% city_list) 
nitc_cities2 <- nitc_cities2 %>% 
  filter((!GEOID %in% c("1880504", "1848384", "4281328")))

nitc_cities2 <- st_transform(nitc_cities2, crs = 5070)

st_write(nitc_cities2, dsn = con, "city_boundaries", overwrite = TRUE)

#attempt download of blocks
#get state county pairs
county_fips <- fips_codes
county_fips <- county_fips %>% filter(state %in% nitc_states)

in_blocks <- blocks(state = "IN")
mn_blocks <- blocks(state = "MN")
dc_blocks <- blocks(state = "DC")
tn_blocks <- blocks(state = "TN")
wa_blocks <- blocks(state = "WA")
pa_blocks <- blocks(state = "PA")
