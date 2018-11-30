

#benchmark some nets processing for wei

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, RPostgreSQL, sf,  dplyr, tidyr, dbplyr, data.table)

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

#the original calls...the import is relatively fast but the
#gather/spread argument takes 7 minutes on my cube machine, slower on
#my laptop


#going to try a data.table approach for the reshaping and adding filter in the SQL statement

#first we can do the city subset in our SQL query. This will cut down on the size of the
#the initial sf/data.frame object

# nets <- st_read(dsn = con, query = "select * from nets where city = 'PORTLAND' OR 
#                 city = 'SAN FRANCISCO' OR city = 'MINNEAPOLIS' OR city = 'INDIANAPOLIS';")


nets <- tbl(con, "nets") %>% 
  filter(city == "PORTLAND"| city == "MINNEAPOLIS"| city == "INDIANAPOLIS"| city == "SAN FRANCISCO") %>% 
  collect()

#setting nets as a data.table and setting key for joining later on
nets <- setDT(nets)
nets <- setkey(nets, dunsnumber)

#check position of naics columns. naics columns are numeric when we want them as character

#this is telling data.table to take the cols variable and apply
#as.character...I don't fully understand the syntax yet but it works
# https://stackoverflow.com/questions/7813578/convert-column-classes-in-data-table
#the second answer



nets_long <- melt(nets, id.vars = c("dunsnumber", "city"),
                  measure.vars = 11:88,
                  variable.factor = TRUE)

nets_long <- nets_long %>% 
  separate(variable, c("code", "year"), sep = -2) %>% 
  spread(code, value) 

nets_long[, year_full := ifelse(year < 16, paste0(20, year), paste0(19, year))]

nets_long[, naics := as.character(naics)]

nets_long[, biz1 := ifelse(substr(naics, 1,3) %in% c(441:454), "Retail", 
                               ifelse(substr(naics, 1,3) %in% c(722), "Food", NA))]


nets_long[, biz2 := ifelse(substr(naics, 1,3) %in% c(443,445,446,448,451,452,453)|substr(naics,1,4) %in% c(8121,8123,8129), "Retail", 
                           ifelse(substr(naics, 1, 4) %in% c(7224, 7225), "Food", NA))]



#aggregated data.table

nets_a <- nets_long[,.(emp = sum(emp, na.rm = TRUE), sales = sum(sales, na.rm = TRUE), n = .N),
                    by =.(year_full, biz1, city)]

nets_a <- nets_a[,c("emp_pest", "sales_pest") := list(emp/n, sales/n)] 







