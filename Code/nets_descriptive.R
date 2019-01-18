if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf, ggplot2, directlabels,ggthemes, tidyverse, dbplyr, stargazer,cowplot, lubridate, gridExtra)

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

ggplot(data=nets11, aes(x=year, y=n)) +
  geom_bar(aes(fill=business1),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Establishment Trend Across Study Cities", x="Year", y ="Number of Establishments") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services"))

ggplot(data=nets11, aes(x=year, y=emp)) +
  geom_bar(aes(fill=business1),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Employment Trend Across Study Cities", x="Year", y ="Employment") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services")) +
  scale_y_continuous(labels = function(x) format(x, scientific = F))

ggplot(data=nets11, aes(x=year, y=sales)) +
  geom_bar(aes(fill=business1),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Retail Sales Trend Across Study Cities", x="Year", y ="Sales") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services")) +
  scale_y_continuous(labels = function(x) format(x, scientific = T))


nets2 <- nets_a %>% 
  group_by(year, business2, city) %>% 
  summarise(emp = sum(emp, na.rm = T), sales= sum(sales, na.rm = T), n=n(),
            emp_pest = emp/n, sales_pest = sales/n) %>% drop_na(.)

nets22 <- filter(nets2, city == "PORTLAND"| city == "SAN FRANCISCO"| city == "MINNEAPOLIS"| city =="INDIANAPOLIS") 
nets22 <- nets22 %>% ungroup() %>% 
  mutate(year = as.Date(as.character(paste0(year, "-01-01")),"%Y-%m-%d"),
         city = factor(city))

ggplot(data=nets22, aes(x=year, y=n)) +
  geom_bar(aes(fill=business2),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Establishment Trend Across Study Cities", x="Year", y ="Number of Establishments") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services"))

ggplot(data=nets22, aes(x=year, y=emp)) +
  geom_bar(aes(fill=business2),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Employment Trend Across Study Cities", x="Year", y ="Employment") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services")) +
  scale_y_continuous(labels = function(x) format(x, scientific = F))

ggplot(data=nets22, aes(x=year, y=sales)) +
  geom_bar(aes(fill=business2),stat = "identity")+
  facet_wrap(~city)+
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  labs(title="Retail Sales Trend Across Study Cities", x="Year", y ="Sales") +
  theme(legend.position = "bottom") +
  scale_fill_discrete(name="Business Type",
                      breaks=c("Retail", "Food"),
                      labels=c("Retail Services", "Food Services")) +
  scale_y_continuous(labels = function(x) format(x, scientific = T))
