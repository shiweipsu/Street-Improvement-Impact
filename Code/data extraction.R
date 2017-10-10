
options(scipen = 999)
load("Data/wac.RData")
library(foreign)


# Load Stark_Oak Data -----------------------------------------------------

stark_oak_shp <- read.dbf("Data/Shapefile/Stark_Oak.dbf")

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
sw_alder_shp <- read.dbf("Data/Shapefile/SW_Alder.dbf")

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
nw_everett_shp <- read.dbf("Data/Shapefile/NW_Everett.dbf")

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
