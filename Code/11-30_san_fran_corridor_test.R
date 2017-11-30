#sanfran bike network analyses
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, tigris, devtools,tidyverse)
options(tigris_class = "sf", tigris_use_cache = TRUE)

devtools::install_github("jamgreen/lehdr")
library(lehdr)

#import, reproject treatment/corridors to make buffering easier

sf_compare <- st_read("Data/Bicycle_Network/sf_comparison_corridorsNAD83_clean.shp")
sf_treat <- st_read("Data/Bicycle_Network/sf_treatment_dissolvedNAD83.shp")

sf_compare <- st_transform(sf_compare, 5070)
sf_treat <- st_transform(sf_treat, 5070)

#grab block group shapes for san francisco and lehd data
sf_city <- block_groups(state = "CA", county = "San Francisco")

years <- 2007:2015

ca_lehd <- map_df(years, grab_lodes, state = "ca", lodes_type = "wac", job_type = "JT01", 
                  segment = "S000", download_dir = "Data/lodes_raw")

ca_lehd <- ca_lehd %>% mutate(geoid = str_sub(w_geocode, 1, 12)) %>% group_by(year, geoid) %>% 
  summarise_if(is.numeric, sum)

ca_lehd <- ca_lehd %>%inner_join(sf_city, by =c("geoid" = "GEOID")) %>% st_as_sf()

ca_lehd <- st_transform(ca_lehd, 5070)

#create buffers and get the spatial join between our buffered polygons and shapes
#and filter out non-null block groups for the intersection
sf_compare_buff <- st_buffer(sf_compare, 20)
sf_treat_buff <- st_buffer(sf_treat, 5)

ca_lehd <- st_join(ca_lehd, sf_compare_buff)
ca_lehd <- st_join(ca_lehd, sf_treat_buff)

ca_lehd <- ca_lehd %>% select(-30:-64)

ca_lehd_corridors <- ca_lehd %>% filter(!is.na(StName) | !is.na(full_stree))
ca_lehd_corridors <- ca_lehd_corridors %>% mutate(Treatment = ifelse(!is.na(full_stree), 1, 0))

ca_lehd_corridors <- ca_lehd_corridors %>% select(geoid, year, TotEmp = C000, 
                                                  Retail = CNS07, ArtsRec = CNS17, 
                                                  Accomodation = CNS18, StName, Comparator,
                                                  TreatStreet = full_stree, Installed = install_ye,
                                                  Treatment)

#rename our sf_treat and compare for visualization and modeling
sf_compare <- ca_lehd_corridors %>% filter(Treatment == 0)
sf_treat <- ca_lehd_corridors %>% filter(Treatment == 1)


t.test(sf_compare$TotEmp, sf_treat$TotEmp)
t.test(sf_compare$Retail, sf_treat$Retail)
