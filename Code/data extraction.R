setwd("C:/Users/shiwei/PDX Google drive/Street Improvements/Data/Portland")

options(scipen = 999)
load("LEHD/wac.RData")
library(foreign)


# Load Stark_Oak Data -----------------------------------------------------

stark_oak_shp <- read.dbf("Blocks/Stark_Oak.dbf")

stark_oak_retail <- merge(stark_oak_shp,wac.S000.JT00.2002[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2003[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2004[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2005[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2006[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2007[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2008[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2009[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2011[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2012[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2013[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
stark_oak_retail <- merge(stark_oak_retail,wac.S000.JT00.2014[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))

stark_oak_retail_job <- stark_oak_retail[,c(1,16:132)]

library(dplyr)
stark_oak_retail_CNS00 <- select(stark_oak_retail_job, GEOID10,starts_with("C00"))
colnames(stark_oak_retail_CNS00) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS07 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS07"))
colnames(stark_oak_retail_CNS07) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS12 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS12"))
colnames(stark_oak_retail_CNS12) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS14 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS14"))
colnames(stark_oak_retail_CNS14) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS15 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS15"))
colnames(stark_oak_retail_CNS15) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS16 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS16"))
colnames(stark_oak_retail_CNS16) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS17 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS17"))
colnames(stark_oak_retail_CNS17) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS18 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS18"))
colnames(stark_oak_retail_CNS18) <- c("GEOID10",2002:2014)
stark_oak_retail_CNS19 <- select(stark_oak_retail_job, GEOID10,starts_with("CNS19"))
colnames(stark_oak_retail_CNS19) <- c("GEOID10",2002:2014)

colnames(stark_oak_retail_job) <- c("GEOID10","CNS00.2002","CNS07.2002","CNS12.2002","CNS14.2002","CNS15.2002","CNS16.2002","CNS17.2002","CNS18.2002","CNS19.2002",
                                    "CNS00.2003","CNS07.2003","CNS12.2003","CNS14.2003","CNS15.2003","CNS16.2003","CNS17.2003","CNS18.2003","CNS19.2003",
                                    "CNS00.2004","CNS07.2004","CNS12.2004","CNS14.2004","CNS15.2004","CNS16.2004","CNS17.2004","CNS18.2004","CNS19.2004",
                                    "CNS00.2005","CNS07.2005","CNS12.2005","CNS14.2005","CNS15.2005","CNS16.2005","CNS17.2005","CNS18.2005","CNS19.2005",
                                    "CNS00.2006","CNS07.2006","CNS12.2006","CNS14.2006","CNS15.2006","CNS16.2006","CNS17.2006","CNS18.2006","CNS19.2006",
                                    "CNS00.2007","CNS07.2007","CNS12.2007","CNS14.2007","CNS15.2007","CNS16.2007","CNS17.2007","CNS18.2007","CNS19.2007",
                                    "CNS00.2008","CNS07.2008","CNS12.2008","CNS14.2008","CNS15.2008","CNS16.2008","CNS17.2008","CNS18.2008","CNS19.2008",
                                    "CNS00.2009","CNS07.2009","CNS12.2009","CNS14.2009","CNS15.2009","CNS16.2009","CNS17.2009","CNS18.2009","CNS19.2009",
                                    "CNS00.2010","CNS07.2010","CNS12.2010","CNS14.2010","CNS15.2010","CNS16.2010","CNS17.2010","CNS18.2010","CNS19.2010",
                                    "CNS00.2011","CNS07.2011","CNS12.2011","CNS14.2011","CNS15.2011","CNS16.2011","CNS17.2011","CNS18.2011","CNS19.2011",
                                    "CNS00.2012","CNS07.2012","CNS12.2012","CNS14.2012","CNS15.2012","CNS16.2012","CNS17.2012","CNS18.2012","CNS19.2012",
                                    "CNS00.2013","CNS07.2013","CNS12.2013","CNS14.2013","CNS15.2013","CNS16.2013","CNS17.2013","CNS18.2013","CNS19.2013",
                                    "CNS00.2014","CNS07.2014","CNS12.2014","CNS14.2014","CNS15.2014","CNS16.2014","CNS17.2014","CNS18.2014","CNS19.2014")

stark_oak_agg <- colSums(stark_oak_retail_job[,2:118])
stark_oak_agg
stark_oak_avg <- colMeans(stark_oak_retail_job[,2:118])
stark_oak_avg
stark_oak_retail_job[,c(1,74:82)]

# Load SW Alder Data ------------------------------------------------------
sw_alder_shp <- read.dbf("Blocks/SW_Alder.dbf")

sw_alder_retail <- merge(sw_alder_shp,wac.S000.JT00.2002[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2003[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2004[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2005[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2006[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2007[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2008[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2009[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2011[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2012[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2013[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
sw_alder_retail <- merge(sw_alder_retail,wac.S000.JT00.2014[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))

sw_alder_retail_job <- sw_alder_retail[,c(1,16:132)]

library(dplyr)
sw_alder_retail_CNS00 <- select(sw_alder_retail_job, GEOID10,starts_with("C00"))
colnames(sw_alder_retail_CNS00) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS07 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS07"))
colnames(sw_alder_retail_CNS07) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS12 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS12"))
colnames(sw_alder_retail_CNS12) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS14 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS14"))
colnames(sw_alder_retail_CNS14) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS15 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS15"))
colnames(sw_alder_retail_CNS15) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS16 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS16"))
colnames(sw_alder_retail_CNS16) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS17 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS17"))
colnames(sw_alder_retail_CNS17) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS18 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS18"))
colnames(sw_alder_retail_CNS18) <- c("GEOID10",2002:2014)
sw_alder_retail_CNS19 <- select(sw_alder_retail_job, GEOID10,starts_with("CNS19"))
colnames(sw_alder_retail_CNS19) <- c("GEOID10",2002:2014)

colnames(sw_alder_retail_job) <- c("GEOID10","C000.2002","CNS07.2002","CNS12.2002","CNS14.2002","CNS15.2002","CNS16.2002","CNS17.2002","CNS18.2002","CNS19.2002",
                                   "C000.2003","CNS07.2003","CNS12.2003","CNS14.2003","CNS15.2003","CNS16.2003","CNS17.2003","CNS18.2003","CNS19.2003",
                                   "C000.2004","CNS07.2004","CNS12.2004","CNS14.2004","CNS15.2004","CNS16.2004","CNS17.2004","CNS18.2004","CNS19.2004",
                                   "C000.2005","CNS07.2005","CNS12.2005","CNS14.2005","CNS15.2005","CNS16.2005","CNS17.2005","CNS18.2005","CNS19.2005",
                                   "C000.2006","CNS07.2006","CNS12.2006","CNS14.2006","CNS15.2006","CNS16.2006","CNS17.2006","CNS18.2006","CNS19.2006",
                                   "C000.2007","CNS07.2007","CNS12.2007","CNS14.2007","CNS15.2007","CNS16.2007","CNS17.2007","CNS18.2007","CNS19.2007",
                                   "C000.2008","CNS07.2008","CNS12.2008","CNS14.2008","CNS15.2008","CNS16.2008","CNS17.2008","CNS18.2008","CNS19.2008",
                                   "C000.2009","CNS07.2009","CNS12.2009","CNS14.2009","CNS15.2009","CNS16.2009","CNS17.2009","CNS18.2009","CNS19.2009",
                                   "C000.2010","CNS07.2010","CNS12.2010","CNS14.2010","CNS15.2010","CNS16.2010","CNS17.2010","CNS18.2010","CNS19.2010",
                                   "C000.2011","CNS07.2011","CNS12.2011","CNS14.2011","CNS15.2011","CNS16.2011","CNS17.2011","CNS18.2011","CNS19.2011",
                                   "C000.2012","CNS07.2012","CNS12.2012","CNS14.2012","CNS15.2012","CNS16.2012","CNS17.2012","CNS18.2012","CNS19.2012",
                                   "C000.2013","CNS07.2013","CNS12.2013","CNS14.2013","CNS15.2013","CNS16.2013","CNS17.2013","CNS18.2013","CNS19.2013",
                                   "C000.2014","CNS07.2014","CNS12.2014","CNS14.2014","CNS15.2014","CNS16.2014","CNS17.2014","CNS18.2014","CNS19.2014")

sw_alder_agg <- colSums(sw_alder_retail_job[,2:118])
sw_alder_agg
sw_alder_avg <- colMeans(sw_alder_retail_job[,2:118])
sw_alder_avg
sw_alder_retail_job[,c(1,74:82)]

# Load NW Everett Data ------------------------------------------------------------
nw_everett_shp <- read.dbf("Blocks/NW_Everett.dbf")

nw_everett_retail <- merge(nw_everett_shp,wac.S000.JT00.2002[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2003[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2004[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2005[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2006[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2007[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2008[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2009[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2011[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2012[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2013[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
nw_everett_retail <- merge(nw_everett_retail,wac.S000.JT00.2014[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))

nw_everett_retail_job <- nw_everett_retail[,c(1,16:132)]

library(dplyr)
nw_everett_retail_CNS00 <- select(nw_everett_retail_job, GEOID10,starts_with("C00"))
colnames(nw_everett_retail_CNS00) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS07 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS07"))
colnames(nw_everett_retail_CNS07) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS12 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS12"))
colnames(nw_everett_retail_CNS12) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS14 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS14"))
colnames(nw_everett_retail_CNS12) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS15 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS15"))
colnames(nw_everett_retail_CNS15) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS16 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS16"))
colnames(nw_everett_retail_CNS16) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS17 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS17"))
colnames(nw_everett_retail_CNS17) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS18 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS18"))
colnames(nw_everett_retail_CNS18) <- c("GEOID10",2002:2014)
nw_everett_retail_CNS19 <- select(nw_everett_retail_job, GEOID10,starts_with("CNS19"))
colnames(nw_everett_retail_CNS19) <- c("GEOID10",2002:2014)

colnames(nw_everett_retail_job) <- c("GEOID10","CNS00.2002","CNS07.2002","CNS12.2002","CNS14.2002","CNS15.2002","CNS16.2002","CNS17.2002","CNS18.2002","CNS19.2002",
                                     "CNS00.2003","CNS07.2003","CNS12.2003","CNS14.2003","CNS15.2003","CNS16.2003","CNS17.2003","CNS18.2003","CNS19.2003",
                                     "CNS00.2004","CNS07.2004","CNS12.2004","CNS14.2004","CNS15.2004","CNS16.2004","CNS17.2004","CNS18.2004","CNS19.2004",
                                     "CNS00.2005","CNS07.2005","CNS12.2005","CNS14.2005","CNS15.2005","CNS16.2005","CNS17.2005","CNS18.2005","CNS19.2005",
                                     "CNS00.2006","CNS07.2006","CNS12.2006","CNS14.2006","CNS15.2006","CNS16.2006","CNS17.2006","CNS18.2006","CNS19.2006",
                                     "CNS00.2007","CNS07.2007","CNS12.2007","CNS14.2007","CNS15.2007","CNS16.2007","CNS17.2007","CNS18.2007","CNS19.2007",
                                     "CNS00.2008","CNS07.2008","CNS12.2008","CNS14.2008","CNS15.2008","CNS16.2008","CNS17.2008","CNS18.2008","CNS19.2008",
                                     "CNS00.2009","CNS07.2009","CNS12.2009","CNS14.2009","CNS15.2009","CNS16.2009","CNS17.2009","CNS18.2009","CNS19.2009",
                                     "CNS00.2010","CNS07.2010","CNS12.2010","CNS14.2010","CNS15.2010","CNS16.2010","CNS17.2010","CNS18.2010","CNS19.2010",
                                     "CNS00.2011","CNS07.2011","CNS12.2011","CNS14.2011","CNS15.2011","CNS16.2011","CNS17.2011","CNS18.2011","CNS19.2011",
                                     "CNS00.2012","CNS07.2012","CNS12.2012","CNS14.2012","CNS15.2012","CNS16.2012","CNS17.2012","CNS18.2012","CNS19.2012",
                                     "CNS00.2013","CNS07.2013","CNS12.2013","CNS14.2013","CNS15.2013","CNS16.2013","CNS17.2013","CNS18.2013","CNS19.2013",
                                     "CNS00.2014","CNS07.2014","CNS12.2014","CNS14.2014","CNS15.2014","CNS16.2014","CNS17.2014","CNS18.2014","CNS19.2014")

nw_everett_agg <- colSums(nw_everett_retail_job[,2:118])
nw_everett_agg
nw_everett_avg <- colMeans(nw_everett_retail_job[,2:118])
nw_everett_avg
nw_everett_retail_job[,c(1,74:82)]

# Corridor comparison ---------------------------------------------------------------------

# treatment/control comparison
portland_shp <- read.dbf("Blocks/Portland_blocks.dbf")
portland_service <- merge(portland_shp,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
portland_service <- portland_service[,c("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")]

portland_service_no0 <- portland_service[apply(portland_service[,-c(1:2,4:8,10)],1,function(x) !all(x==0)),]
portland_service_no0$business <- portland_service_no0$CNS07+portland_service_no0$CNS18

# quantile
quantile(portland_service_no0$C000,probs = seq(0, 1, by= 0.05))
quantile(portland_service_no0$CNS07,probs = seq(0, 1, by= 0.05))
quantile(portland_service_no0$CNS18,probs = seq(0, 1, by= 0.05))
quantile(portland_service_no0$business,probs = seq(0, 1, by= 0.05))

# disaggregate employment proportion comparison
stark_oak_retail_2010 <- stark_oak_retail_job[,c(1,74:82)]
colnames(stark_oak_retail_2010) <- c("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")
stark_oak_retail_2010 <-
  stark_oak_retail_2010 %>%
  mutate(business = CNS07 + CNS18) %>%
  mutate(service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + CNS17 + CNS18 + CNS19) %>%
  mutate(service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19) %>%
  mutate(busi_perc1 = business/service1) %>%
  mutate(busi_perc2 = business/service2) %>%
  mutate(busi_den = sum(business)/nrow(stark_oak_retail_2010))

nw_everett_retail_2010 <- nw_everett_retail_job[,c(1,74:82)]
colnames(nw_everett_retail_2010) <- c("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")
nw_everett_retail_2010 <-
  nw_everett_retail_2010 %>%
  mutate(business = CNS07 + CNS18) %>%
  mutate(service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + CNS17 + CNS18 + CNS19) %>%
  mutate(service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19) %>%
  mutate(busi_perc1 = business/service1) %>%
  mutate(busi_perc2 = business/service2) %>%
  mutate(busi_den = sum(business)/nrow(nw_everett_retail_2010))

t.test(stark_oak_retail_2010$busi_perc1,nw_everett_retail_2010$busi_perc1)
t.test(stark_oak_retail_2010$busi_perc2,nw_everett_retail_2010$busi_perc2)
t.test(stark_oak_retail_2010$busi_den,nw_everett_retail_2010$busi_den)
  
sw_alder_retail_2010 <- sw_alder_retail_job[,c(1,74:82)]
colnames(sw_alder_retail_2010) <- c("GEOID10","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")
sw_alder_retail_2010 <-
  sw_alder_retail_2010 %>%
  mutate(business = CNS07 + CNS18) %>%
  mutate(service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + CNS17 + CNS18 + CNS19) %>%
  mutate(service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19) %>%
  mutate(busi_perc1 = business/service1) %>%
  mutate(busi_perc2 = business/service2) %>%
  mutate(busi_den = sum(business)/nrow(sw_alder_retail_2010))

t.test(stark_oak_retail_2010$busi_perc1,sw_alder_retail_2010$busi_perc1)
t.test(stark_oak_retail_2010$busi_perc2,sw_alder_retail_2010$busi_perc2)
t.test(stark_oak_retail_2010$busi_den,sw_alder_retail_2010$busi_den)


# aggregatd annual growth rate comparison:CNS07
stark_oak_retail_CNS07_clean <- stark_oak_retail_CNS07[apply(stark_oak_retail_CNS07[,-1], 1, function(x) !all(x==0)),]
sw_alder_retail_CNS07_clean <- sw_alder_retail_CNS07[apply(sw_alder_retail_CNS07[,-1], 1, function(x) !all(x==0)),]
nw_everett_retail_CNS07_clean <- nw_everett_retail_CNS07[apply(nw_everett_retail_CNS07[,-1], 1, function(x) !all(x==0)),]

stark_oak_CNS07_agg <- colSums(stark_oak_retail_CNS07_clean[,2:14])
sw_alder_CNS07_agg <- colSums(sw_alder_retail_CNS07_clean[,2:14])
nw_everett_CNS07_agg <- colSums(nw_everett_retail_CNS07_clean[,2:14])

stark_oak__CNS07_agg_cbind <- cbind(stark_oak_CNS07_agg,sw_alder_CNS07_agg,nw_everett_CNS07_agg)

growth <- function(x)x/lag(x)-1
stark_oak_CNS07_growth <-
  data.frame(stark_oak__CNS07_agg_cbind) %>%
  mutate_each(funs(growth),stark_oak_CNS07_agg,sw_alder_CNS07_agg,nw_everett_CNS07_agg)

t.test(stark_oak_CNS07_growth[2:9,]$stark_oak_CNS07_agg,stark_oak_CNS07_growth[2:9,]$nw_everett_CNS07_agg)
t.test(stark_oak_CNS07_growth[2:9,]$stark_oak_CNS07_agg,stark_oak_CNS07_growth[2:9,]$sw_alder_CNS07_agg)

# aggregatd annual growth rate comparison:CNS18
stark_oak_retail_CNS18_clean <- stark_oak_retail_CNS18[apply(stark_oak_retail_CNS18[,-1], 1, function(x) !all(x==0)),]
sw_alder_retail_CNS18_clean <- sw_alder_retail_CNS18[apply(sw_alder_retail_CNS18[,-1], 1, function(x) !all(x==0)),]
nw_everett_retail_CNS18_clean <- nw_everett_retail_CNS18[apply(nw_everett_retail_CNS18[,-1], 1, function(x) !all(x==0)),]

stark_oak_CNS18_agg <- colSums(stark_oak_retail_CNS18_clean[,2:14])
sw_alder_CNS18_agg <- colSums(sw_alder_retail_CNS18_clean[,2:14])
nw_everett_CNS18_agg <- colSums(nw_everett_retail_CNS18_clean[,2:14])

stark_oak__CNS18_agg_cbind <- cbind(stark_oak_CNS18_agg,sw_alder_CNS18_agg,nw_everett_CNS18_agg)

growth <- function(x)x/lag(x)-1
stark_oak_CNS18_growth <-
  data.frame(stark_oak__CNS18_agg_cbind) %>%
  mutate_each(funs(growth),stark_oak_CNS18_agg,sw_alder_CNS18_agg,nw_everett_CNS18_agg)

t.test(stark_oak_CNS18_growth[2:9,]$stark_oak_CNS18_agg,stark_oak_CNS18_growth[2:9,]$nw_everett_CNS18_agg)
t.test(stark_oak_CNS18_growth[2:9,]$stark_oak_CNS18_agg,stark_oak_CNS18_growth[2:9,]$sw_alder_CNS18_agg)

# DID ---------------------------------------------------------------------
library(reshape)

# DID analysis: stark_oak and nw_everett (aggregate)
stark_oak_CNS07_did <- cbind(stark_oak_retail_CNS07_clean[,7:13])
stark_oak_CNS07_did$before <- rowMeans(stark_oak_CNS07_did[,1:3])
stark_oak_CNS07_did$after <- rowMeans(stark_oak_CNS07_did[,5:7])
stark_oak_CNS07_did <- melt(stark_oak_CNS07_did[,8:9])
stark_oak_CNS07_did$At <-c("treatment")

nw_everett_CNS07_did <- cbind(nw_everett_retail_CNS07_clean[,7:13])
nw_everett_CNS07_did$before <- rowMeans(nw_everett_CNS07_did[,1:3])
nw_everett_CNS07_did$after <- rowMeans(nw_everett_CNS07_did[,5:7])
nw_everett_CNS07_did <- melt(nw_everett_CNS07_did[,8:9])
nw_everett_CNS07_did$At <- c("control")

stark_oak_CNS07_DID_long <- rbind(stark_oak_CNS07_did,nw_everett_CNS07_did)
colnames(stark_oak_CNS07_DID_long) <- c("Tt","CNS07","At")

stark_oak_CNS07_DID_fit1 <- lm(CNS07~Tt*At,stark_oak_CNS07_DID_long)
summary(stark_oak_CNS07_DID_fit1)

# DID analysis: stark_oak and nw_everett (2008/2012)
stark_oak_CNS07_did <- cbind(stark_oak_retail_CNS07_clean[,7:13])
stark_oak_CNS07_did$before <- stark_oak_CNS07_did[,2]
stark_oak_CNS07_did$after <- stark_oak_CNS07_did[,6]
stark_oak_CNS07_did <- melt(stark_oak_CNS07_did[,8:9])
stark_oak_CNS07_did$At <-c("treatment")

nw_everett_CNS07_did <- cbind(nw_everett_retail_CNS07_clean[,7:13])
nw_everett_CNS07_did$before <- nw_everett_CNS07_did[,2]
nw_everett_CNS07_did$after <- nw_everett_CNS07_did[,6]
nw_everett_CNS07_did <- melt(nw_everett_CNS07_did[,8:9])
nw_everett_CNS07_did$At <- c("control")

stark_oak_CNS07_DID_long <- rbind(stark_oak_CNS07_did,nw_everett_CNS07_did)
colnames(stark_oak_CNS07_DID_long) <- c("Tt","CNS07","At")

stark_oak_CNS07_DID_fit2 <- lm(CNS07~Tt*At,stark_oak_CNS07_DID_long)
summary(stark_oak_CNS07_DID_fit2)

# DID in CNS18
# DID analysis: stark_oak and nw_everett (aggregate)
stark_oak_CNS18_did <- cbind(stark_oak_retail_CNS18_clean[,7:13])
stark_oak_CNS18_did$before <- rowMeans(stark_oak_CNS18_did[,1:3])
stark_oak_CNS18_did$after <- rowMeans(stark_oak_CNS18_did[,5:7])
stark_oak_CNS18_did <- melt(stark_oak_CNS18_did[,8:9])
stark_oak_CNS18_did$At <-c("treatment")

nw_everett_CNS18_did <- cbind(nw_everett_retail_CNS18_clean[,7:13])
nw_everett_CNS18_did$before <- rowMeans(nw_everett_CNS18_did[,1:3])
nw_everett_CNS18_did$after <- rowMeans(nw_everett_CNS18_did[,5:7])
nw_everett_CNS18_did <- melt(nw_everett_CNS18_did[,8:9])
nw_everett_CNS18_did$At <- c("control")

stark_oak_CNS18_DID_long <- rbind(stark_oak_CNS18_did,nw_everett_CNS18_did)
colnames(stark_oak_CNS18_DID_long) <- c("Tt","CNS18","At")

stark_oak_CNS18_DID_fit1 <- lm(CNS18~Tt*At,stark_oak_CNS18_DID_long)
summary(stark_oak_CNS18_DID_fit1)

# DID analysis: stark_oak and nw_everett (2008/2012)
stark_oak_CNS18_did <- cbind(stark_oak_retail_CNS18_clean[,7:13])
stark_oak_CNS18_did$before <- stark_oak_CNS18_did[,2]
stark_oak_CNS18_did$after <- stark_oak_CNS18_did[,6]
stark_oak_CNS18_did <- melt(stark_oak_CNS18_did[,8:9])
stark_oak_CNS18_did$At <-c("treatment")

nw_everett_CNS18_did <- cbind(nw_everett_retail_CNS18_clean[,7:13])
nw_everett_CNS18_did$before <- nw_everett_CNS18_did[,2]
nw_everett_CNS18_did$after <- nw_everett_CNS18_did[,6]
nw_everett_CNS18_did <- melt(nw_everett_CNS18_did[,8:9])
nw_everett_CNS18_did$At <- c("control")

stark_oak_CNS18_DID_long <- rbind(stark_oak_CNS18_did,nw_everett_CNS18_did)
colnames(stark_oak_CNS18_DID_long) <- c("Tt","CNS18","At")

stark_oak_CNS18_DID_fit2 <- lm(CNS18~Tt*At,stark_oak_CNS18_DID_long)
summary(stark_oak_CNS18_DID_fit2)

# Time series analysis ----------------------------------------------------

stark_oak_CNS00_agg <- colSums(stark_oak_retail_CNS00[,2:14])
stark_oak_CNS00.ts <- ts(stark_oak_CNS00_agg, start=c(2002), end=c(2014)) 
plot(stark_oak_CNS00.ts)

stark_oak_CNS07_agg <- colSums(stark_oak_retail_CNS07[,2:14])
df_stark_oak_CNS07 <- data.frame(stark_oak_CNS07_agg)
stark_oak_CNS07.ts <- ts(df_stark_oak_CNS07, start=c(2002), end=c(2014)) 
plot(stark_oak_CNS07.ts)

stark_oak_CNS18_agg <- colSums(stark_oak_retail_CNS18[,2:14])
stark_oak_CNS18.ts <- ts(stark_oak_CNS18_agg, start=c(2002), end=c(2014)) 
plot(stark_oak_CNS18.ts)

Acf(stark_oak_CNS07_agg,type="correlation")
Acf(stark_oak_CNS07_agg,type="partial")

# time series analysis: aggregated intervension analysis
D<-time(stark_oak_CNS07.ts)>2010  # structure break at 2010

library(forecast)
arma1<-auto.arima(stark_oak_CNS07_agg,xreg=D,trace=T)
summary(arma1)

arma2<-Arima(stark_oak_CNS07_agg,xreg=D,order=c(0,1,0),include.constant=T) 
summary(arma2)

D<-time(stark_oak_CNS18.ts)>2010  # structure break at 2010

arma1<-auto.arima(stark_oak_CNS18_agg,xreg=D,trace=T)
summary(arma1)

library("strucchange")
plot(Fstats(stark_oak_CNS00.ts~1))
plot(Fstats(stark_oak_CNS07.ts~1))

breakpoints(Fstats(stark_oak_CNS18.ts~1))
plot(Fstats(stark_oak_CNS18.ts~1))

# CNS07 time series analysis: disaggregate intervention analysis
# https://rpubs.com/kaz_yos/its1
stark_oak_retail_CNS07_clean <- stark_oak_retail_CNS07[apply(stark_oak_retail_CNS07[,-1], 1, function(x) !all(x==0)),]
library(reshape)
stark_oak_retail_CNS07_long <- melt(stark_oak_retail_CNS07_clean)
colnames(stark_oak_retail_CNS07_long) <- c("GEOID10","year","CNS07")
stark_oak_retail_CNS07_long$year <- as.numeric(stark_oak_retail_CNS07_long$year)
stark_oak_retail_CNS07_long$CNS07 <- as.numeric(stark_oak_retail_CNS07_long$CNS07)
stark_oak_retail_CNS07_long$Xt <- ifelse(stark_oak_retail_CNS07_long$year>9,"post","pre")

stark_oak_CNS07_fit <- lm(CNS07~year*Xt,stark_oak_retail_CNS07_long)
summary(stark_oak_CNS07_fit)

stark_oak_CNS07.ts <- ts(t(stark_oak_retail_CNS07[,2:14]), start=c(2002), end=c(2014)) 
D<-time(stark_oak_CNS07.ts)>2010
cpt.mean(stark_oak_CNS07.ts, penalty ="SIC", pen.value =0, method= "AMOC", Q=5, test.stat= "Normal")

# time series analysis: aggregate intervention analysis
stark_oak_retail_CNS07_its <- matrix(c(1:13),nrow=13)
stark_oak_retail_CNS07_its <- data.frame(stark_oak_retail_CNS07_its)
stark_oak_retail_CNS07_its$CNS07 <- stark_oak_CNS07_agg
colnames(stark_oak_retail_CNS07_its) <- c("year","CNS07")
stark_oak_retail_CNS07_its$Xt <- ifelse(stark_oak_retail_CNS07_its$year<10,"pre","post")
stark_oak_CNS07_fit2 <- lm(CNS07~year*Xt,stark_oak_retail_CNS07_its)
summary(stark_oak_CNS07_fit2)

# CNS18 time series analysis: disaggregate intervention analysis
stark_oak_retail_CNS18_clean <- stark_oak_retail_CNS18[apply(stark_oak_retail_CNS18[,-1], 1, function(x) !all(x==0)),]
library(reshape)
stark_oak_retail_CNS18_long <- melt(stark_oak_retail_CNS18_clean)
colnames(stark_oak_retail_CNS18_long) <- c("GEOID10","year","CNS18")
stark_oak_retail_CNS18_long$year <- as.numeric(stark_oak_retail_CNS18_long$year)
stark_oak_retail_CNS18_long$CNS18 <- as.numeric(stark_oak_retail_CNS18_long$CNS18)
stark_oak_retail_CNS18_long$Xt <- ifelse(stark_oak_retail_CNS18_long$year>9,"post","pre")

stark_oak_CNS18_fit <- lm(CNS18~year*Xt,stark_oak_retail_CNS18_long)
summary(stark_oak_CNS18_fit)

stark_oak_CNS18.ts <- ts(t(stark_oak_retail_CNS18[,2:14]), start=c(2002), end=c(2014)) 
D<-time(stark_oak_CNS18.ts)>2010
cpt.mean(stark_oak_CNS18.ts, penalty ="SIC", pen.value =0, method= "AMOC", Q=5, test.stat= "Normal")

# time series analysis: aggregate intervention analysis
stark_oak_retail_CNS18_its <- matrix(c(1:13),nrow=13)
stark_oak_retail_CNS18_its <- data.frame(stark_oak_retail_CNS07_its)
stark_oak_retail_CNS18_its$CNS18 <- stark_oak_CNS18_agg
colnames(stark_oak_retail_CNS18_its) <- c("year","CNS18")
stark_oak_retail_CNS18_its$Xt <- ifelse(stark_oak_retail_CNS18_its$year<10,"pre","post")
stark_oak_CNS18_fit2 <- lm(CNS18~year*Xt,stark_oak_retail_CNS18_its)
summary(stark_oak_CNS18_fit2)

# disaggregate

# AITS_DID ----------------------------------------------------------------
library(reshape)
stark_oak_retail_CNS07_clean <- stark_oak_retail_CNS07[apply(stark_oak_retail_CNS07[,-1], 1, function(x) !all(x==0)),]
stark_oak_retail_CNS07_long <- melt(stark_oak_retail_CNS07_clean)
colnames(stark_oak_retail_CNS07_long) <- c("GEOID10","year","CNS07")
stark_oak_retail_CNS07_long$year <- as.numeric(stark_oak_retail_CNS07_long$year)
stark_oak_retail_CNS07_long$CNS07 <- as.numeric(stark_oak_retail_CNS07_long$CNS07)
stark_oak_retail_CNS07_clean$prel <- rowMeans(stark_oak_retail_CNS07_clean[,2:10]) # calculate the pre-mean for each GEOID
stark_oak_retail_CNS07_clean$postl <- rowMeans(stark_oak_retail_CNS07_clean[,11:14]) # calculate the post-mean for each GEOID
stark_oak_retail_CNS07_long$prelevel <- c(rep(stark_oak_retail_CNS07_clean$prel,9),rep(0,4*nrow(stark_oak_retail_CNS07_clean)))
stark_oak_retail_CNS07_long$postlevel <- c(rep(0,9*nrow(stark_oak_retail_CNS07_clean)),rep(stark_oak_retail_CNS07_clean$postl,4))
stark_oak_retail_CNS07_long$pretrend <-  ifelse(stark_oak_retail_CNS07_long$year<10,stark_oak_retail_CNS07_long$year,0)
stark_oak_retail_CNS07_long$posttrend <-  ifelse(stark_oak_retail_CNS07_long$year>9,stark_oak_retail_CNS07_long$year-9,0)
# stark_oak_retail_CNS07_long$Xl <- c(rep(stark_oak_retail_CNS07_clean$prel,9),rep(stark_oak_retail_CNS07_clean$postl,4))
# stark_oak_retail_CNS07_long$Xt <- ifelse(stark_oak_retail_CNS07_long$year<10,stark_oak_retail_CNS07_long$year,stark_oak_retail_CNS07_long$year-9) # add pre/post trend indicator
stark_oak_retail_CNS07_long$Xtc <- "Treatment"
  
nw_everett_retail_CNS07_clean <- nw_everett_retail_CNS07[apply(nw_everett_retail_CNS07[,-1], 1, function(x) !all(x==0)),]
nw_everett_retail_CNS07_long <- melt(nw_everett_retail_CNS07_clean)
colnames(nw_everett_retail_CNS07_long) <- c("GEOID10","year","CNS07")
nw_everett_retail_CNS07_long$year <- as.numeric(nw_everett_retail_CNS07_long$year)
nw_everett_retail_CNS07_long$CNS07 <- as.numeric(nw_everett_retail_CNS07_long$CNS07)
nw_everett_retail_CNS07_clean$prel <- rowMeans(nw_everett_retail_CNS07_clean[,2:10]) # calculate the pre-mean for each GEOID
nw_everett_retail_CNS07_clean$postl <- rowMeans(nw_everett_retail_CNS07_clean[,11:14]) # calculate the post-mean for each GEOID
nw_everett_retail_CNS07_long$prelevel <-0
nw_everett_retail_CNS07_long$postlevel <- 0
nw_everett_retail_CNS07_long$pretrend <-  0
nw_everett_retail_CNS07_long$posttrend <-  0
# nw_everett_retail_CNS07_long$Xl <- c(rep(nw_everett_retail_CNS07_clean$prel,9),rep(nw_everett_retail_CNS07_clean$postl,4))
# nw_everett_retail_CNS07_long$Xt <- ifelse(nw_everett_retail_CNS07_long$year<10,nw_everett_retail_CNS07_long$year,nw_everett_retail_CNS07_long$year-9) # add pre/post trend indicator
nw_everett_retail_CNS07_long$Xtc <- "Control"

stark_oak_CNS07_aitsidi_long <- rbind(stark_oak_retail_CNS07_long,nw_everett_retail_CNS07_long)

stark_oak_aitsdid_fit1 <- lm(CNS07~(prelevel+postlevel+pretrend+posttrend)* Xtc +year,data=stark_oak_CNS07_aitsidi_long)
summary(stark_oak_aitsdid_fit1)

stark_oak_CNS07_aitsidi_long$trpost <- ifelse(stark_oak_CNS07_aitsidi_long$Xtc=="Treatment"&stark_oak_CNS07_aitsidi_long$year>9,1,0)
stark_oak_CNS07_aitsidi_long$tryear <- ifelse(stark_oak_CNS07_aitsidi_long$Xtc=="Treatment",stark_oak_CNS07_aitsidi_long$year,0)
stark_oak_CNS07_aitsidi_long$trpostyear <- ifelse(stark_oak_CNS07_aitsidi_long$Xtc=="Treatment"&stark_oak_CNS07_aitsidi_long$year>9,stark_oak_CNS07_aitsidi_long$year-9,0)

stark_oak_aitsdid_fit2 <- lm(CNS07~Xtc+trpost+tryear+trpostyear+year+posttrend,data=stark_oak_CNS07_aitsidi_long)
summary(stark_oak_aitsdid_fit2)

# CNS18
stark_oak_retail_CNS18_clean <- stark_oak_retail_CNS18[apply(stark_oak_retail_CNS18[,-1], 1, function(x) !all(x==0)),]
stark_oak_retail_CNS18_long <- melt(stark_oak_retail_CNS18_clean)
colnames(stark_oak_retail_CNS18_long) <- c("GEOID10","year","CNS18")
stark_oak_retail_CNS18_long$year <- as.numeric(stark_oak_retail_CNS18_long$year)
stark_oak_retail_CNS18_long$CNS18 <- as.numeric(stark_oak_retail_CNS18_long$CNS18)
stark_oak_retail_CNS18_clean$prel <- rowMeans(stark_oak_retail_CNS18_clean[,2:10]) # calculate the pre-mean for each GEOID
stark_oak_retail_CNS18_clean$postl <- rowMeans(stark_oak_retail_CNS18_clean[,11:14]) # calculate the post-mean for each GEOID
stark_oak_retail_CNS18_long$prelevel <- c(rep(stark_oak_retail_CNS18_clean$prel,9),rep(0,4*nrow(stark_oak_retail_CNS18_clean)))
stark_oak_retail_CNS18_long$postlevel <- c(rep(0,9*nrow(stark_oak_retail_CNS18_clean)),rep(stark_oak_retail_CNS18_clean$postl,4))
stark_oak_retail_CNS18_long$pretrend <-  ifelse(stark_oak_retail_CNS18_long$year<10,stark_oak_retail_CNS18_long$year,0)
stark_oak_retail_CNS18_long$posttrend <-  ifelse(stark_oak_retail_CNS18_long$year>9,stark_oak_retail_CNS18_long$year-9,0)
# stark_oak_retail_CNS18_long$Xl <- c(rep(stark_oak_retail_CNS18_clean$prel,9),rep(stark_oak_retail_CNS18_clean$postl,4))
# stark_oak_retail_CNS18_long$Xt <- ifelse(stark_oak_retail_CNS18_long$year<10,stark_oak_retail_CNS18_long$year,stark_oak_retail_CNS18_long$year-9) # add pre/post trend indicator
stark_oak_retail_CNS18_long$Xtc <- "Treatment"

nw_everett_retail_CNS18_clean <- nw_everett_retail_CNS18[apply(nw_everett_retail_CNS18[,-1], 1, function(x) !all(x==0)),]
nw_everett_retail_CNS18_long <- melt(nw_everett_retail_CNS18_clean)
colnames(nw_everett_retail_CNS18_long) <- c("GEOID10","year","CNS18")
nw_everett_retail_CNS18_long$year <- as.numeric(nw_everett_retail_CNS18_long$year)
nw_everett_retail_CNS18_long$CNS18 <- as.numeric(nw_everett_retail_CNS18_long$CNS18)
nw_everett_retail_CNS18_clean$prel <- rowMeans(nw_everett_retail_CNS18_clean[,2:10]) # calculate the pre-mean for each GEOID
nw_everett_retail_CNS18_clean$postl <- rowMeans(nw_everett_retail_CNS18_clean[,11:14]) # calculate the post-mean for each GEOID
nw_everett_retail_CNS18_long$prelevel <- c(rep(nw_everett_retail_CNS18_clean$prel,9),rep(0,4*nrow(nw_everett_retail_CNS18_clean)))
nw_everett_retail_CNS18_long$postlevel <- c(rep(0,9*nrow(nw_everett_retail_CNS18_clean)),rep(nw_everett_retail_CNS18_clean$postl,4))
nw_everett_retail_CNS18_long$pretrend <-  ifelse(nw_everett_retail_CNS18_long$year<10,nw_everett_retail_CNS18_long$year,0)
nw_everett_retail_CNS18_long$posttrend <-  ifelse(nw_everett_retail_CNS18_long$year>9,nw_everett_retail_CNS18_long$year-9,0)
# nw_everett_retail_CNS18_long$Xl <- c(rep(nw_everett_retail_CNS18_clean$prel,9),rep(nw_everett_retail_CNS18_clean$postl,4))
# nw_everett_retail_CNS18_long$Xt <- ifelse(nw_everett_retail_CNS18_long$year<10,nw_everett_retail_CNS18_long$year,nw_everett_retail_CNS18_long$year-9) # add pre/post trend indicator
nw_everett_retail_CNS18_long$Xtc <- "Control"

stark_oak_CNS18_aitsidi_long <- rbind(stark_oak_retail_CNS18_long,nw_everett_retail_CNS18_long)

stark_oak_aitsdid_fit1 <- lm(CNS18~(prelevel+postlevel+pretrend+posttrend)* Xtc +year,data=stark_oak_CNS18_aitsidi_long)
summary(stark_oak_aitsdid_fit1)

stark_oak_CNS18_aitsidi_long$trpost <- ifelse(stark_oak_CNS18_aitsidi_long$Xtc=="Treatment"&stark_oak_CNS18_aitsidi_long$year>9,1,0)
stark_oak_CNS18_aitsidi_long$tryear <- ifelse(stark_oak_CNS18_aitsidi_long$Xtc=="Treatment",stark_oak_CNS18_aitsidi_long$year,0)
stark_oak_CNS18_aitsidi_long$trpostyear <- ifelse(stark_oak_CNS18_aitsidi_long$Xtc=="Treatment"&stark_oak_CNS18_aitsidi_long$year>9,stark_oak_CNS18_aitsidi_long$year-9,0)

stark_oak_aitsdid_fit2 <- lm(CNS18~Xtc+trpost+tryear+trpostyear+year+posttrend,data=stark_oak_CNS18_aitsidi_long)
summary(stark_oak_aitsdid_fit2)

# Miscellanea -------------------------------------------------------------

multmerge = function(mypath){
  filenames=list.files(full.names=TRUE)
  Reduce(function(x,y) {merge(x,y)}, datalist)
}
a <- data.frame(matrix(1:9,nrow=3))
colnames(a)<-c("ID","A","AA")
b <- data.frame(matrix(c(1,2,3,4,5,7,8,9),nrow=4))
colnames(b)<-c("ID","B")
c <- data.frame(matrix(c(1,2,3,17,18,19),nrow=3))
colnames(c)<-c("ID","C")

Reduce(function(x,y) merge(x,y),list(a[,c("ID","A")],b,c))