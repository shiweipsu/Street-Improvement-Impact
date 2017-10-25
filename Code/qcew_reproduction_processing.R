#check qcew data and join to corridors
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, ggplot2, dplyr)

#the file structure is a mess, have to bring this shit in manually and then save as new file, i reckon

qcew04 <- st_read("Data/qcew_2000_2015_bps/2004_Data_new/2004QCEW.shp")
qcew05 <- st_read("Data/qcew_2000_2015_bps/2005_Data/MetroBLS2005.shp")
qcew06 <- st_read("Data/qcew_2000_2015_bps/2006_Data/MetroBLS2006.shp")
qcew07 <- st_read("Data/qcew_2000_2015_bps/2007_Data_new/2007QCEW.shp")
qcew08 <- st_read("Data/qcew_2000_2015_bps/2008_Data/ES202_2008_Final.shp")
qcew09 <- st_read("Data/qcew_2000_2015_bps/2009_Data/MetroRegion2009.shp")
qcew10 <- st_read("Data/qcew_2000_2015_bps/2010_Data/QCEW_2010_FINAL.shp")
qcew11 <- st_read("Data/qcew_2000_2015_bps/2011_Data/PDX_QCEW_2011.shp")
qcew12 <- st_read("Data/qcew_2000_2015_bps/2012_Data/QCEW_2012_PDX_FINAL.shp")
qcew13 <- st_read("Data/qcew_2000_2015_bps/2013_Data/frmState/QCEW2013_5County.shp")
qcew14 <- st_read("Data/qcew_2000_2015_bps/2014_Data/archived/QCEW2014_5Cnty.shp")
qcew15 <- st_read("Data/qcew_2000_2015_bps/2015_Data/QCEW_2015_FINAL.shp")

#start chopping down the dfs for eventual cbind
qcew04 <- qcew04 %>% select(UI, FIRMNAME, NAICS, YEAR, 27:44)
qcew05 <- qcew05 %>%  select(NAICS,17:28, NAME, YR)
qcew06 <- qcew06 %>% select(NAICS,17:28, NAME, YR)
qcew07 <- qcew07 %>% select(UI, FIRMNAME, NAICS, YEAR, 27:44)
qcew08 <- qcew08 %>% select(12:29, 31)                            
qcew09 <- qcew09 %>%  select(UI, FIRMNAME, NAICS, YEAR, 28:41)
qcew10 <- qcew10 %>% select(UI, FIRMNAME, NAICS, YEAR, 18:29)
qcew11 <- qcew11 %>% select(UI, 6:18, year, name)
qcew12 <- qcew12 %>% select(3, 8:20, year, name) %>% mutate(UI = stringr::str_sub(UI_RUN, 1, 10))
qcew13 <- qcew13 %>% select(UI, NAME, NAICS, YEAR_, 34:45)
qcew14 <- qcew14 %>% select(UI, NAME, NAICS, YEAR_, 32:43)
qcew15 <- qcew15 %>% select(UI, FIRMNAME, NAICS, YEAR_, 16:27)

#thought I could preserve lat/longs and pay...gonna say no and keep only employment
qcew04 <- qcew04 %>%  select(-5, -6, -c(19:22))
qcew07 <- qcew07 %>%  select(-5, -6, -c(19:22))
qcew08 <- qcew08 %>% select(-c(14:17))
qcew09 <- qcew09 %>% select(-c(5,6))
qcew12 <- qcew12 %>% select(-UI_RUN)

qcew11 <- qcew11 %>% select_all(.funs = toupper)
qcew12 <- qcew12 %>% select_all(.funs = toupper)

qcew13 <- qcew13 %>% rename(YEAR = YEAR_, DEC = DEC_)
qcew14 <- qcew14 %>% rename(YEAR = YEAR_, DEC = DEC_)
qcew15 <- qcew15 %>% rename(YEAR = YEAR_)



#it's inefficient but write out to the data folder as new files

st_write(qcew04,  "qcew04.shp")
st_write(qcew05,   "qcew05.shp")
st_write(qcew06,   "qcew06.shp")
st_write(qcew07,   "qcew07.shp")
st_write(qcew08,   "qcew08.shp")
st_write(qcew09,   "qcew09.shp")
st_write(qcew10,   "qcew10.shp")
st_write(qcew11,   "qcew11.shp")
st_write(qcew12,   "qcew12.shp")
st_write(qcew13,   "qcew13.shp")
st_write(qcew14,   "qcew14.shp")
st_write(qcew15,   "qcew15.shp")

#moved and reprojected using bash
#testing some now

qcew06 <- st_read("Data/processed_qcew/qcew06.shp")







