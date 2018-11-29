#benchmark some nets processing for wei

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf, ggplot2, directlabels,ggthemes, tidyverse, 
       dbplyr, stargazer,cowplot, lubridate, gridExtra)

user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)


nets <- st_read(dsn = con, query = "select * from nets")

nets_a <- nets %>% gather(key, value, -c(1:10,89:92)) %>% 
  separate(key, c("retail", "year"), sep=-2) %>% 
  spread(retail, value) %>% 
  mutate(business1 = case_when(substr(naics,1,3) %in% c(441:454) ~ "Retail",
                               substr(naics,1,3) %in% c(722) ~ "Food"),
         business2 = case_when((substr(naics,1,3) %in% c(443,445,446,448,451,452,453)|substr(naics,1,4) %in% c(8121,8123,8129)) ~ "Retail",
                               substr(naics,1,4) %in% c(7224,7225) ~ "Food"),
         year = ifelse(as.numeric(year)<16, paste0("20",year), paste0("19",year)))

nets1 <- nets_a %>% 
  group_by(year, business1, city) %>% 
  summarise(emp = sum(emp, na.rm = T), sales= sum(sales, na.rm = T), n=n(),
            emp_pest = emp/n, sales_pest = sales/n) %>% drop_na(.) 

nets11 <- filter(nets1, city == "PORTLAND"| city == "SAN FRANCISCO"| city == "MINNEAPOLIS"| city =="INDIANAPOLIS") 
nets11 <- nets11 %>% ungroup() %>% 
  mutate(year = as.Date(as.character(paste0(year, "-01-01")),"%Y-%m-%d"),
         city = factor(city))
