if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(tidyverse, RPostgreSQL)

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

indy_qcew <- readxl::read_xlsx("Data/Indianapolis/Indianapolis corridors 2004-2016.xlsx")

dbWriteTable(conn = con, "indy_qcew_raw", indy_qcew)

#it is unclear what these corridor names are but had a similar issue with sales tax
#as such taking a risk assuming the labels are the some

indy_qcew <- indy_qcew %>% 
  mutate(corridor_name = case_when(corridor_id == 1 ~ "virginia ave",
                                   corridor_id == 2 ~ "mass ave",
                                   corridor_id == 3 ~ "prospect",
                                   corridor_id == 4 ~ "mass ave (control)",
                                   corridor_id == 5 ~ "shelby",
                                   corridor_id == 6 ~ "meridian"),
         corridor_group = case_when(grepl("mass", corridor_name) ~ 2,
                                    TRUE ~ 1),
         corridor_type = case_when(corridor_name == "virginia ave" ~ "treatment",
                                   corridor_name == "mass ave" ~ "treatment",
                                   TRUE ~ "control"))

dbWriteTable(conn = con, "indy_qcew_modified", indy_qcew)

dbDisconnect(conn = con)
