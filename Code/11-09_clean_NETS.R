if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL,dplyr, sf)

user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

source(here::here("Code/corridor_comparison_functions.R"))

nets <- readRDS("Data/NETS_NITC_RETAIL.RDS")
naics <- readRDS("Data/NAICS2015_xwalk.RDS")
nets <- nets %>% left_join(naics, by="DunsNumber") %>% mutate(Longitude=Longitude*(-1))

# select columns: 
  # LevelCode: Level at which latitude/longitude provided (D = Block Face, B = Block Group, 
  #           T = Census Tract Centroid, Z = ZIP Code Centroid, N = Not Coded, S = Street Level)
  # EstCat: Last Type of Location (Single Location, Headquarters, Branch)
  # Industry: Primary SIC Industry Name in Last Year
  # LastYear tells you when it went out of business. If not “2015”, then the establishment has stopped reporting and presumed out-of-business. 

nets1 <- nets %>% 
  select(DunsNumber, City, ZipCode,Address, Latitude, Longitude, LevelCode,EstCat, YearStart, LastYear, Industry, 
         starts_with("Emp9"), starts_with("Emp0"), starts_with("Emp1"), 
         starts_with("Sales9"), starts_with("Sales0"),starts_with("Sales1"), starts_with("NAICS"))

nets_geo <- filter(nets1, LevelCode%in%c("D"))
nets_nogeo <- nets1 %>% filter(LevelCode%in%c("B","T","Z","S")) %>% 
  filter(ZipCode %in% c(98101:98105, 98112,98122, 98115, 97204, 97205, 97209, 94102, 94103,94110,94109,
                        38112, 38107, 38104, 38111,46202, 46203, 46204, 46225, 
                        55401, 55404, 55406, 55408, 55409, 55411:55414, 55418, 55419,55422,55454,55455,
                        20001, 20005, 20006, 20009, 20010, 20011, 20036, 20037, 20052, 20427)) %>% 
  filter(is.na(Address))
# find zip code of where corridors locate in
  # Seattle: 98101:5, 98112,98122, 98115
  # Portland: 97204, 97205, 97209
  # SF: 94102, 94103,94110,94109
  # Memphis: 38112, 38107, 38104, 38111
  # Indy: 46202, 46203, 46204, 46225
  # Minn: 55401, 55404, 55406, 55408, 55409, 55411:14/18/19/22/54/55
  # DC: 20001, 20005, 20006, 20009, 20010, 20011, 20036, 20037, 20052, 20427

nets_sf <- st_as_sf(nets1, coords = c("Longitude", "Latitude"), crs=5070)
