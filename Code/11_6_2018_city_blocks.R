#install older version of pacman and load in packages



library(pacman)
p_load(tigris, dplyr, dbplyr, sf, here, RPostgreSQL, purrr)
options(tigris_class = "sf")

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

#st_write(nitc_cities2, dsn = con, "city_boundaries", overwrite = TRUE)

#have to manually download the blocks...couldn't get the loop to work

nitc_counties <- c("097", "053", "001", "157", "033", "003")

state_blocks <- map2(nitc_states, nitc_counties,  ~{blocks(state = .x, county = .y)}) %>% 
  rbind_tigris()


nitc_blocks <- st_transform(state_blocks, crs = 5070)
nitc_place_blocks <- st_intersection(nitc_blocks, nitc_cities2)
nitc_place_blocks <- nitc_place_blocks %>% filter(st_is(., "POLYGON"))

#st_write(nitc_place_blocks, dsn = con, "city_blocks", overwrite = TRUE)

dbDisconnect(con)
