# match or_wac with treatment (stark_oak) and control corridors (the other two)

library(tidyverse)
library(foreign)

or_wac_2002_2014 <- readRDS("../Data/or_wac_2002_2014.RDS")

stark_oak_shp <- read.dbf("../Data/Shapefile/Stark_Oak.dbf")
sw_alder_shp <- read.dbf("../Data/Shapefile/SW_Alder.dbf")
nw_everett_shp <- read.dbf("../Data/Shapefile/NW_Everett.dbf")
portland_shp <- read.dbf("../Data/Shapefile/Portland_blocks.dbf")

stark_oak_service <- stark_oak_shp %>% 
  left_join(or_wac_2002_2014, by=c("GEOID10"="w_geocode")) %>%
  select("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19","year")
  
nw_everett_service <- nw_everett_shp %>% 
  left_join(or_wac_2002_2014, by=c("GEOID10"="w_geocode")) %>%
  select("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19","year")

sw_alder_service <- sw_alder_shp %>% 
  left_join(or_wac_2002_2014, by=c("GEOID10"="w_geocode")) %>%
  select("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19","year")

portland_service <- portland_shp %>% 
  left_join(or_wac_2002_2014, by=c("GEOID10"="w_geocode")) %>%
  select("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19","year")

rm(list=c("stark_oak_shp","sw_alder_shp","nw_everett_shp","or_wac_2002_2014","portland_shp"))
