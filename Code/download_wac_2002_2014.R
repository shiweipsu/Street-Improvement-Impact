#download Oregon WAC lehd data for 2002-2014 using Jamaal's lehdr package and save

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(purrr)

devtools::install_github("jamgreen/lehdr")
library(lehdr)

years <- c(2002:2014)
or_wac <- map_df(years, grab_lodes, state = "or", lodes_type = "wac", job_type = "JT00", segment = "S000", 
                 download_dir = "Data/lehd")

saveRDS(or_wac, file = "Data/or_wac_2002_2014.RDS" )
