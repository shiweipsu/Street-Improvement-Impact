#upload memphis sales tax from the google drive to the spatial db
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(RPostgreSQL, dplyr, dbplyr, readr, tidyverse)

user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

#i downoaded from google drive, just bring from downloads folder

memphis_sales <- read_csv("Data/memphis/corridor_sales_receipts_final.csv")

#need to rationalize the table...split the corr_type column, set labels, and street groups
#split corr_type column

memphis_sales <- memphis_sales %>% 
  separate(col = corr_type, into = c("street_type", "street_name"))

#Set street group by street_name

#set two groups, filter out S Cooper St to make it control for both,drop the street_name variable 

memphis_sales <- memphis_sales %>% 
  mutate(street_group = case_when(district_name == "Madison Ave" | street_name == "Madison" | district_name == "S Cooper St" ~ 1,
                                  district_name == "Broad Ave" | street_name == "Broad" ~ 2))

cooper <- memphis_sales %>% filter(district_name == "S Cooper St") %>% mutate(street_group =2)

memphis_sales <-rbind(memphis_sales, cooper)

memphis_sales <- memphis_sales %>% 
  select(-street_name, -index)

dbWriteTable(conn = con, name = "memphis_sales_tax", value = memphis_sales, overwrite = TRUE)

dbDisconnect(con)
