#minneapolis sales tax moved to bike_lanes

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf, tidyr, dplyr, dbplyr)

#connect to bike_lanes
user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

minn_sale <- read.csv(here::here("Data/Minneapolis/BikeDataAggregated.csv"))

minn_sale <- minn_sale %>% 
  filter(!is.na(Street)) %>%
  mutate(Group= case_when(Street %in% c("RIVERSIDE AVE","CEDAR AVE S") ~ 1,
                          Street=="FRANKLIN AVE E" ~ 2,
                          Street %in% c("CENTRAL AVE NE","UNIVERSITY AVE NE") ~3,
                          Street %in% c("LYNDALE AVE S","GRAND AVE S") ~4,
                          Street %in% c("2ND ST N","WEST BROADWAY") ~5),
         Study= case_when(Group==1 ~ ifelse(Street=="RIVERSIDE AVE"," Improvement","Control"),
                          Group==2 ~ ifelse(Street=="FRANKLIN AVE E"," Improvement","Control"),
                          Group==3 ~ ifelse(Street=="CENTRAL AVE NE"," Improvement","Control"),
                          Group==4 ~ ifelse(Street=="LYNDALE AVE S"," Improvement","Control"),
                          Group==5 ~ ifelse(Street=="2ND ST N"," Improvement","Control"))) %>% 
  filter(Group %in% c(1:5)) %>% 
  group_by(Street,Type,Group,Study,TaxYear) %>% 
  summarise(TaxableSales = sum(TaxableSales, na.rm = TRUE))

minn_sale <- minn_sale %>% 
  spread(Type,TaxableSales) %>% 
  mutate(year=TaxYear,
         Type=Study,
         CNS07=Retail,
         CNS18=Restaurant,
         geometry=1)

st_write(minn_sale, dsn = con, "minn_sales_tax", overwrite = TRUE)
dbWriteTable(conn = con, "minn_sales_tax", value = minn_sale, overwrite = TRUE, row.names = FALSE)

dbDisconnect(con)
