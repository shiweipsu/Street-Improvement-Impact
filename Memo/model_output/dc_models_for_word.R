#trying to export dc models directly to html, open in word and paste from there

if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, tidyr, stargazer, sf, ggplot2, ggthemes, cowplot, forcats, dplyr,dbplyr,RPostgreSQL, 
       zoo, forcats)

user <- "jamgreen"
host <- "pgsql102.rc.pdx.edu"
pw <- scan(here::here("batteries.pgpss"), what = "")
dbname <- "bike_lanes"

con <- dbConnect("PostgreSQL", host = host, user = user, dbname = dbname, 
                 password = pw, port = 5433)

source(here::here("Code/corridor_comparison_functions.R"))

dc_corridor <- st_read(dsn = con, query = "select a.geoid10 as geoid, a.c000 as c000,
a.cns07 as cns07, a.cns12 as cns12, a.cns14 as cns14, a.cns15 as cns15, 
a.cns16 as cns16, a.cns17 as cns17, a.cns18 as cns18, a.cns19 as cns19, b.st_name as Name, 
b.buildstart as buildstart, b.buildend as buildend, b.sitegroup as corridor_group, 
b.type as grouptype,  a.year as year, a.geom as geometry
FROM dc_lehd a, dc_corridors b
WHERE ST_Intersects(ST_Buffer(b.geom, 20), a.geom);")

names(dc_corridor) <- toupper(names(dc_corridor)) 

dc_corridor <- dc_corridor %>% rename(Type = GROUPTYPE, year = YEAR, Group = CORRIDOR_GROUP)

## L street DiD...won't run ITS, not enough time past


l_did <- did_agg_analysis(dc_corridor, group = 2, endyear = 2012)

stargazer(l_did[[1]], l_did[[2]], l_did[[3]], 
          title = "L St. Corridor Difference-in-Difference Estimates", 
          column.labels = c("Retail Emp.", "Accommodations Emp.", "'Business' Emp."), 
          type = "html", out = here::here("Memo/model_output/dc/l_st_lehd_did.html"),
          font.size = "tiny", model.numbers = FALSE, no.space = TRUE)

## M Street DiD

m_did <- did_agg_analysis(dc_corridor, group = 5, endyear = 2014)

stargazer(m_did[[1]], m_did[[2]], m_did[[3]], 
          title = "M St. Corridor Difference-in-Difference Estimates", 
          column.labels = c("Retail Emp.", "Accommodations Emp.", "'Business' Emp."), 
          type = "html", out = here::here("Memo/model_output/dc/m_st_lehd_its.html"),
          font.size = "tiny", model.numbers = FALSE, no.space = TRUE)