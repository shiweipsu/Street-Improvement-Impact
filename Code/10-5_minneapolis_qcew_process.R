#minneapolis qcew upload to db

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, dplyr, dbplyr, tidyverse, readxl)

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

#bring in the qcew data from the excel sheet

broadway <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "C3:E75") %>% 
  mutate(corridors = "Broadway Ave", street_type = "control")

cedar <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "F3:H75") %>% 
  mutate(corridors = "Cedar Ave", street_type = "control")

central <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "I3:K75") %>% 
  mutate(corridors = "Central Ave", street_type = "improvement")

franklin_control <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "L3:N75") %>% 
  mutate(corridors = "Franklin Ave", street_type = "control")

franklin_improvement <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "O3:Q75") %>% 
  mutate(corridors = "Franklin Ave", street_type = "improvement")

grand <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "R3:T75") %>% 
  mutate(corridors = "Grand Ave", street_type = "control")

lyndale <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "U3:W75") %>% 
  mutate(corridors = "Lyndale Ave S", street_type = "improvement")

north2nd <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "X3:Z75") %>% 
  mutate(corridors = "North 2nd Street", street_type = "improvement")

riverside <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "AA3:AC75", na = "x") %>% 
  mutate(corridors = "Riverside Ave", street_type = "improvement")

university <- read_xlsx("Data/MinneapolisCorridors.xlsx", range = "AD3:AF75") %>% 
  mutate(corridors = "University Ave", street_type = "control")

qcew <- bind_rows(list(broadway, cedar, central, franklin_control, franklin_improvement, grand, lyndale,
                       north2nd, riverside, university))

qcew <- qcew %>% 
  mutate(years = rep("2000":"2017", each = 4, length.out = nrow(.)),
         quarters = rep(c("01", "02", "03", "04"), length.out = nrow(.)))

#re-arrange and upload to db

qcew <- qcew %>% 
  select(corridors, street_type, year = years, quarter = quarters ,establishments = Establishments, 
         total_wages = TotalWage, avg_emp = AvgEmp)

dbWriteTable(conn = con, name = "minneapolis_qcew_modified", value = qcew, overwrite = TRUE)

dbDisconnect(con)
