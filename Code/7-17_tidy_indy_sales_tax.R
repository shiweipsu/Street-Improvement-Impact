#fixing the indy tidy tax spreadsheet...have already modified it a bit in excel

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, readr, RPostgreSQL, tidyr, lubridate, dplyr, dbplyr)


#attempt to read in and tidy csv

indy <- read_csv(here::here("Data/7-17_indy_salestax_raw.csv"))

indy_tidy <- indy %>% gather(key = "quarter", value = "tax_revenue", 2:37)

indy_tidy <- indy_tidy %>% mutate_at(vars("quarter"), funs(mdy))

#upload new tidy tidy tax table to db

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

names(indy_tidy) <- tolower(names(indy_tidy))
indy_tidy <- indy_tidy %>% mutate(group = if_else(grepl("Mass*", .$corridor), 1, 2))
indy_tidy <- indy_tidy %>% 
  mutate(type = if_else(grepl("Mass Ave$|Virginia Ave", .$corridor), "treatment", "control"))


dbWriteTable(conn = con, name = "indy_sales_tax", value = indy_tidy, overwrite = TRUE)


dbDisconnect(con)
