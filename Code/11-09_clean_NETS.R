if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL,dplyr, sf, ggmap, tidyr)

user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

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
  select(DunsNumber, City, State, ZipCode, Address, Latitude, Longitude, LevelCode,EstCat, YearStart, LastYear, Industry, 
         starts_with("Emp9"), starts_with("Emp0"), starts_with("Emp1"), 
         starts_with("Sales9"), starts_with("Sales0"),starts_with("Sales1"), starts_with("NAICS"))

# find the most repeated NAICS code for each establishement from 1990 to 2015
nets2 <- nets1[,c(1,65:90)]
nets2$NAICS <- apply(nets2,1, function(x) names(which.max(table(x))))
nets2$NAICS3 <- substr(nets2$NAICS, 1, 3)
nets2$NAICS4 <- substr(nets2$NAICS, 1, 4)
nets1 <- left_join(nets1, nets2[,c(1,28,29,30)], by="DunsNumber")

# filter NAICS code 44-45 and 722 and 812
nets_retail <- filter(nets1, NAICS3 %in% c(441:454, 722, 812))

nets_geo <- filter(nets_retail, LevelCode%in%c("D"))
nets_nogeo <- nets_retail %>% filter(LevelCode%in%c("B","T","Z","S")) %>%  filter(Address!="") 

# find zip code of where corridors locate in for those don't have exact XY coordinates at block face level
  # Seattle: 98101:5, 98112,98122, 98115
  # Portland: 97204, 97205, 97209
  # SF: 94102, 94103,94110,94109
  # Memphis: 38112, 38107, 38104, 38111
  # Indy: 46202, 46203, 46204, 46225
  # Minn: 55401, 55404, 55406, 55408, 55409, 55411:14/18/19/22/54/55
  # DC: 20001, 20005, 20006, 20009, 20010, 20011, 20036, 20037, 20052, 20427
# filter(ZipCode %in% c(98101:98105, 98112,98122, 98115, 97204, 97205, 97209, 94102, 94103,94110,94109,
#                         38112, 38107, 38104, 38111,46202, 46203, 46204, 46225, 
#                         55401, 55404, 55406, 55408, 55409, 55411:55414, 55418, 55419,55422,55454,55455,
#                         20001, 20005, 20006, 20009, 20010, 20011, 20036, 20037, 20052, 20427)) 


# geocode nogeo addresses: https://geocoding.geo.census.gov/geocoder/geographies/addressbatch?form
# nets_nogeo0 <- nets_nogeo %>% select(DunsNumber, Address, City, State, ZipCode)
# nets_nogeo1 <- nets_nogeo0[1:9999,]
# nets_nogeo2 <- nets_nogeo0[10000:19998,]
# nets_nogeo3 <- nets_nogeo0[19999:21962,]
# write.csv(nets_nogeo1, "Data/nets_nogeo1.csv", row.names = F)
# write.csv(nets_nogeo2, "Data/nets_nogeo2.csv", row.names = F)
# write.csv(nets_nogeo3, "Data/nets_nogeo3.csv", row.names = F)

nets_nogeo_coded1 <- read.csv("Data/nets_nogeo1_coded.csv")
nets_nogeo_coded2 <- read.csv("Data/nets_nogeo2_coded.csv")
nets_nogeo_coded3 <- read.csv("Data/nets_nogeo3_coded.csv")
nets_nogeo_coded <- rbind(nets_nogeo_coded1, nets_nogeo_coded2, nets_nogeo_coded3)

nets_nogeo_coded <- filter(nets_nogeo_coded, TIGER.MATCH.TYPE=="Exact") %>% 
  mutate(Lat= as.character(Lat),
         DunsNumber = as.numeric(as.character(DunsNumber))) %>% 
  separate(Lat, c("Longitude", "Latitude"),",") %>% 
  select(DunsNumber, Latitude, Longitude)
nets_nogeo <- right_join(nets_nogeo, nets_nogeo_coded, by="DunsNumber") %>% 
  mutate(Latitude.x=Latitude.y,
         Longitude.x=Longitude.y,
         LevelCode = "GC") %>% 
  select(1:93) %>% 
  rename(Latitude=Latitude.x, Longitude = Longitude.x)

nets_retail <- rbind(nets_geo, nets_nogeo)

# filter same industry of LEHD/QCEW/Sales Tax
nets_retaila <-  filter(nets_retail, NAICS3 %in% c(441:454, 722))

# filter another set of NAICS code (443, 445, 446, 448, 451, 452, 453, 7224, 7225 8121, 8123, 8129)
  # 4431 Electronics and Appliance Stores; 4451 Grocery Stores; 4452 Specialty Food Stores;
  # 4453 Beer, Wine and Liquor Stores; 4461 Health and Personal Care Stores; 4481 Clothing Stores; 4482 Shoe Stores;
  # 4483 Jewlry Luggage and Leather Goods Stores; 4511 Sproting Goods, Hobby and Musical Instrument Stores;
  # 4512 Book Stores and New Dealers; 4522 Department Stores; 4523 General Merchandise Stores; 4531 Florists; 
  # 4532 Office Supplies, Stationery and Gift Stores; 4533 Used Mercandise Stores; 4539 Other misecellaneouse store retailers
  # 7224 Drinking places; 7225 Restaurants and other eating places; 8121 Personal Care Services; 8121 Personal care services
  # 8123 Dryingcleaning and laundry services; 8129 other personal services
nets_retailb <-  filter(nets_retail, NAICS3 %in% c(443,445,446,448,451,452,453)| NAICS4 %in% c(7224,7225,8121,8123,8129))

# transform to sf file
nets_sf <- st_as_sf(nets_retail, coords = c("Longitude", "Latitude"), crs=4326) %>% st_transform(5070)
names(nets_sf) <- tolower(names(nets_sf))

st_write(nets_sf, dsn = con, overwrite = TRUE, "nets",geom_col="geometry")
