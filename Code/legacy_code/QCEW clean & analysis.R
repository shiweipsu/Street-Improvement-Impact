setwd("C:/Users/shiwei/PDX Google Drive/Street Improvements/Data/Portland/QCEW/")

library(foreign)
library(dplyr)
library(reshape)
library(maptools)
library(rgdal)

# read & clean stark_oak data ---------------------------------------------

# read files
for (i in c(2005:2015)){
  myFiles <- paste0("Test/stark_oak_",i,".dbf")
  assign(paste0("stark_oak_",i),read.dbf(myFiles))
}

# stark_oak <- readOGR("Stark_oak/Stark_Oak.shp",layer="Stark_Oak")
# stark_oak <- stark_oak[,"GEOID10"]
# proj4string(stark_oak) <- proj4string(stark_oak_2015)
# stark_oak <- spTransform(stark_oak, proj4string(stark_oak_2015))
# stark_oak_2015$block_id <- over(stark_oak_2015,stark_oak)
# stark_oak_2015 <- data.frame(stark_oak_2015)
  
# clean data
names(stark_oak_2015)
stark_oak_2015 <- stark_oak_2015[(substr(stark_oak_2015$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2015 <- stark_oak_2015[-grep(c("WASHINGTON"),stark_oak_2015$ADDR1),]
stark_oak_2015 <- stark_oak_2015[-grep(c("BURNSIDE"),stark_oak_2015$ADDR1),]
stark_oak_2015$emp2015 <- rowMeans(subset(stark_oak_2015,select=c(which(colnames(stark_oak_2015)=="JAN"),which(colnames(stark_oak_2015)=="JAN")+11)))
emp <- aggregate(emp2015~GEOID10,data=stark_oak_2015,sum)

names(stark_oak_2014)
stark_oak_2014 <- stark_oak_2014[(substr(stark_oak_2014$naics,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2014 <- stark_oak_2014[-grep(c("WASHINGTON"),stark_oak_2014$street1),]
stark_oak_2014 <- stark_oak_2014[-grep(c("BURNSIDE"),stark_oak_2014$street1),]
stark_oak_2014$emp2014 <- rowMeans(subset(stark_oak_2014,select=c(which(colnames(stark_oak_2014)=="jan"),which(colnames(stark_oak_2014)=="jan")+11)))
emp$emp2014 <- aggregate(stark_oak_2014$emp2014, by=levels(stark_oak_2014$GEOID10),sum)

names(stark_oak_2013)
colnames(stark_oak_2013)[1:2] <- c("BIN","UI")
stark_oak_2013 <- stark_oak_2013[(substr(stark_oak_2013$naics,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2013 <- stark_oak_2013[-grep(c("WASHINGTON"),stark_oak_2013$street1),]
stark_oak_2013 <- stark_oak_2013[-grep(c("BURNSIDE"),stark_oak_2013$street1),]
stark_oak_2013$emp2013 <- rowMeans(subset(stark_oak_2013,select=c(which(colnames(stark_oak_2013)=="jan"),which(colnames(stark_oak_2013)=="jan")+11)))
emp2013 <- aggregate(emp2013~GEOID10,data=stark_oak_2013,sum)

names(stark_oak_2012)
colnames(stark_oak_2012)[3:4] <- c("BIN","UI")
stark_oak_2012 <- stark_oak_2012[(substr(stark_oak_2012$naics,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2012 <- stark_oak_2012[-grep(c("WASHINGTON"),stark_oak_2012$street1),]
stark_oak_2012 <- stark_oak_2012[-grep(c("BURNSIDE"),stark_oak_2012$street1),]
stark_oak_2012$emp2012 <- rowMeans(subset(stark_oak_2012,select=c(which(colnames(stark_oak_2012)=="jan"),which(colnames(stark_oak_2012)=="jan")+11)))
emp2012 <- aggregate(emp2012~GEOID10,data=stark_oak_2012,sum)

names(stark_oak_2011)
stark_oak_2011 <- stark_oak_2011[(substr(stark_oak_2011$naics,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2011 <- stark_oak_2011[-grep(c("WASHINGTON"),stark_oak_2011$street1),]
stark_oak_2011 <- stark_oak_2011[-grep(c("BURNSIDE"),stark_oak_2011$street1),]
stark_oak_2011$emp2011 <- rowMeans(subset(stark_oak_2011,select=c(which(colnames(stark_oak_2011)=="jan"),which(colnames(stark_oak_2011)=="jan")+11)))
emp2011 <- aggregate(emp2011~GEOID10,data=stark_oak_2011,sum)

names(stark_oak_2010)
stark_oak_2010 <- stark_oak_2010[(substr(stark_oak_2010$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2010 <- stark_oak_2010[-grep(c("WASHINGTON"),stark_oak_2010$ADDRESS),]
stark_oak_2010 <- stark_oak_2010[-grep(c("BURNSIDE"),stark_oak_2010$ADDRESS),]
stark_oak_2010$emp2010 <- rowMeans(subset(stark_oak_2010,select=c(which(colnames(stark_oak_2010)=="JAN"),which(colnames(stark_oak_2010)=="JAN")+11)))
emp2010 <- aggregate(emp2010~GEOID10,data=stark_oak_2010,sum)

names(stark_oak_2009)
stark_oak_2009$BIN <- paste0(stark_oak_2009$UI,stark_oak_2009$RU)
stark_oak_2009 <- stark_oak_2009[(substr(stark_oak_2009$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2009 <- stark_oak_2009[-grep(c("WASHINGTON"),stark_oak_2009$ADDRESS),]
stark_oak_2009 <- stark_oak_2009[-grep(c("BURNSIDE"),stark_oak_2009$ADDRESS),]
stark_oak_2009$emp2009 <- rowMeans(subset(stark_oak_2009,select=c(which(colnames(stark_oak_2009)=="JAN"),which(colnames(stark_oak_2009)=="JAN")+11)))
emp2009 <- aggregate(emp2009~GEOID10,data=stark_oak_2009,sum)

names(stark_oak_2008)
colnames(stark_oak_2008)[8]<-"UI"
stark_oak_2008$BIN <- paste0(stark_oak_2008$UI,stark_oak_2008$RUN)
stark_oak_2008 <- stark_oak_2008[(substr(stark_oak_2008$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2008 <- stark_oak_2008[-grep(c("WASHINGTON"),stark_oak_2008$ADDR1),]
stark_oak_2008 <- stark_oak_2008[-grep(c("BURNSIDE"),stark_oak_2008$ADDR1),]
stark_oak_2008$emp2008 <- rowMeans(subset(stark_oak_2008,select=c(which(colnames(stark_oak_2008)=="JAN"),which(colnames(stark_oak_2008)=="JAN")+11)))
emp2008 <- aggregate(emp2008~GEOID10,data=stark_oak_2008,sum)

names(stark_oak_2007)
stark_oak_2007 <- stark_oak_2007[stark_oak_2007$SIC2 %in% c(52:59),]
stark_oak_2007 <- stark_oak_2007[-grep(c("WASHINGTON"),stark_oak_2007$ADDRESS),]
stark_oak_2007 <- stark_oak_2007[-grep(c("BURNSIDE"),stark_oak_2007$ADDRESS),]
stark_oak_2007$emp2007 <- stark_oak_2007$EMPLOYEE
emp2007 <- aggregate(emp2007~GEOID10,data=stark_oak_2007,sum)

names(stark_oak_2006)
colnames(stark_oak_2006)[5]<-"UI"
stark_oak_2006$BIN <- paste0(stark_oak_2006$UI,stark_oak_2006$RUN)
stark_oak_2006 <- stark_oak_2006[(substr(stark_oak_2006$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2006 <- stark_oak_2006[-grep(c("WASHINGTON"),stark_oak_2006$ADDRESS),]
stark_oak_2006 <- stark_oak_2006[-grep(c("BURNSIDE"),stark_oak_2006$ADDRESS),]
stark_oak_2006$emp2006 <- rowMeans(subset(stark_oak_2006,select=c(which(colnames(stark_oak_2006)=="JAN"),which(colnames(stark_oak_2006)=="JAN")+11)))
emp2006 <- aggregate(emp2006~GEOID10,data=stark_oak_2006,sum)

names(stark_oak_2005)
colnames(stark_oak_2005)[5]<-"UI"
stark_oak_2005$BIN <- paste0(stark_oak_2005$UI,stark_oak_2005$RUN)
stark_oak_2005 <- stark_oak_2005[(substr(stark_oak_2005$NAICS,1,3)) %in% c(441:448,451:454,722),]
stark_oak_2005 <- stark_oak_2005[-grep(c("WASHINGTON"),stark_oak_2005$ADDRESS),]
stark_oak_2005 <- stark_oak_2005[-grep(c("BURNSIDE"),stark_oak_2005$ADDRESS),]
stark_oak_2005$emp2005 <- rowMeans(subset(stark_oak_2005,select=c(which(colnames(stark_oak_2005)=="JAN"),which(colnames(stark_oak_2005)=="JAN")+11)))
emp2005 <- aggregate(emp2005~GEOID10,data=stark_oak_2005,sum)


stark_oak <- Reduce(function(x, y) merge(x, y, by="BIN",all=TRUE), 
            list(stark_oak_2005[,c("BIN","emp2005")],stark_oak_2006[,c("BIN","emp2006")],stark_oak_2008[,c("BIN","emp2008")],stark_oak_2009[,c("BIN","emp2009")],
                 stark_oak_2010[,c("BIN","emp2010")],stark_oak_2011[,c("BIN","emp2011")],stark_oak_2012[,c("BIN","emp2012")],stark_oak_2013[,c("BIN","emp2013")],
                 stark_oak_2014[,c("BIN","emp2014")],stark_oak_2015[,c("BIN","emp2015")]))
stark_oak[is.na(stark_oak)] <- 0
stark_oak <- stark_oak[apply(stark_oak[,-1], 1, function(x) !all(x<=1)),] # delete 0 or 1 values
stark_oak <- stark_oak[apply(stark_oak[,-c(1:3,10:11)], 1, function(x) !all(x<=1)),] # delete stores closed or have 1 employee before 2008 and open after 2013
stark_oak_cont <- stark_oak[apply(stark_oak[,-c(1:3,10:11)], 1, function(x) all(x!=0)),] # select the ones opens through 2008 to 2013
write.csv(stark_oak, "stark_oak_qcew.csv",sep=",",row.names = F)


# read & clean nw everett data --------------------------------------------

# read files
for (i in c(2005:2015)){
  myFiles <- paste0("NW_everett/nw_everett_",i,".dbf")
  assign(paste0("nw_everett_",i),read.dbf(myFiles))
}

# clean data
names(nw_everett_2015)
nw_everett_2015 <- nw_everett_2015[(substr(nw_everett_2015$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2015 <- nw_everett_2015[-grep(c("FLANDERS"),nw_everett_2015$ADDR1),]
nw_everett_2015 <- nw_everett_2015[-grep(c("DAVIS"),nw_everett_2015$ADDR1),]
nw_everett_2015$emp2015 <- rowMeans(subset(nw_everett_2015,select=c(which(colnames(nw_everett_2015)=="JAN"),which(colnames(nw_everett_2015)=="JAN")+11)))

names(nw_everett_2014)
nw_everett_2014 <- nw_everett_2014[(substr(nw_everett_2014$naics,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2014 <- nw_everett_2014[-grep(c("FLANDERS"),nw_everett_2014$street1),]
nw_everett_2014 <- nw_everett_2014[-grep(c("DAVIS"),nw_everett_2014$street1),]
nw_everett_2014$emp2014 <- rowMeans(subset(nw_everett_2014,select=c(which(colnames(nw_everett_2014)=="jan"),which(colnames(nw_everett_2014)=="jan")+11)))

names(nw_everett_2013)
colnames(nw_everett_2013)[1:2] <- c("BIN","UI")
nw_everett_2013 <- nw_everett_2013[(substr(nw_everett_2013$naics,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2013 <- nw_everett_2013[-grep(c("FLANDERS"),nw_everett_2013$street1),]
nw_everett_2013 <- nw_everett_2013[-grep(c("DAVIS"),nw_everett_2013$street1),]
nw_everett_2013$emp2013 <- rowMeans(subset(nw_everett_2013,select=c(which(colnames(nw_everett_2013)=="jan"),which(colnames(nw_everett_2013)=="jan")+11)))

names(nw_everett_2012)
colnames(nw_everett_2012)[3:4] <- c("BIN","UI")
nw_everett_2012 <- nw_everett_2012[(substr(nw_everett_2012$naics,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2012 <- nw_everett_2012[-grep(c("FLANDERS"),nw_everett_2012$street1),]
nw_everett_2012 <- nw_everett_2012[-grep(c("DAVIS"),nw_everett_2012$street1),]
nw_everett_2012$emp2012 <- rowMeans(subset(nw_everett_2012,select=c(which(colnames(nw_everett_2012)=="jan"),which(colnames(nw_everett_2012)=="jan")+11)))

names(nw_everett_2011)
nw_everett_2011 <- nw_everett_2011[(substr(nw_everett_2011$naics,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2011 <- nw_everett_2011[-grep(c("FLANDERS"),nw_everett_2011$street1),]
nw_everett_2011 <- nw_everett_2011[-grep(c("DAVIS"),nw_everett_2011$street1),]
nw_everett_2011$emp2011 <- rowMeans(subset(nw_everett_2011,select=c(which(colnames(nw_everett_2011)=="jan"),which(colnames(nw_everett_2011)=="jan")+11)))

names(nw_everett_2010)
nw_everett_2010 <- nw_everett_2010[(substr(nw_everett_2010$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2010 <- nw_everett_2010[-grep(c("FLANDERS"),nw_everett_2010$ADDRESS),]
nw_everett_2010 <- nw_everett_2010[-grep(c("DAVIS"),nw_everett_2010$ADDRESS),]
nw_everett_2010$emp2010 <- rowMeans(subset(nw_everett_2010,select=c(which(colnames(nw_everett_2010)=="JAN"),which(colnames(nw_everett_2010)=="JAN")+11)))

names(nw_everett_2009)
nw_everett_2009$BIN <- paste0(nw_everett_2009$UI,nw_everett_2009$RU)
nw_everett_2009 <- nw_everett_2009[(substr(nw_everett_2009$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2009 <- nw_everett_2009[-grep(c("FLANDERS"),nw_everett_2009$ADDRESS),]
nw_everett_2009 <- nw_everett_2009[-grep(c("DAVIS"),nw_everett_2009$ADDRESS),]
nw_everett_2009$emp2009 <- rowMeans(subset(nw_everett_2009,select=c(which(colnames(nw_everett_2009)=="JAN"),which(colnames(nw_everett_2009)=="JAN")+11)))

names(nw_everett_2008)
colnames(nw_everett_2008)[8]<-"UI"
nw_everett_2008$BIN <- paste0(nw_everett_2008$UI,nw_everett_2008$RUN)
nw_everett_2008 <- nw_everett_2008[(substr(nw_everett_2008$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2008 <- nw_everett_2008[-grep(c("FLANDERS"),nw_everett_2008$ADDR1),]
nw_everett_2008 <- nw_everett_2008[-grep(c("DAVIS"),nw_everett_2008$ADDR1),]
nw_everett_2008$emp2008 <- rowMeans(subset(nw_everett_2008,select=c(which(colnames(nw_everett_2008)=="JAN"),which(colnames(nw_everett_2008)=="JAN")+11)))

names(nw_everett_2007)
nw_everett_2007 <- nw_everett_2007[nw_everett_2007$SIC2 %in% c(52:59),]
nw_everett_2007 <- nw_everett_2007[-grep(c("FLANDERS"),nw_everett_2007$ADDRESS),]
nw_everett_2007 <- nw_everett_2007[-grep(c("DAVIS"),nw_everett_2007$ADDRESS),]
nw_everett_2007$emp2007 <- nw_everett_2007$EMPLOYEE

names(nw_everett_2006)
colnames(nw_everett_2006)[5]<-"UI"
nw_everett_2006$BIN <- paste0(nw_everett_2006$UI,nw_everett_2006$RUN)
nw_everett_2006 <- nw_everett_2006[(substr(nw_everett_2006$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2006 <- nw_everett_2006[-grep(c("FLANDERS"),nw_everett_2006$ADDRESS),]
nw_everett_2006 <- nw_everett_2006[-grep(c("DAVIS"),nw_everett_2006$ADDRESS),]
nw_everett_2006$emp2006 <- rowMeans(subset(nw_everett_2006,select=c(which(colnames(nw_everett_2006)=="JAN"),which(colnames(nw_everett_2006)=="JAN")+11)))

names(nw_everett_2005)
colnames(nw_everett_2005)[5]<-"UI"
nw_everett_2005$BIN <- paste0(nw_everett_2005$UI,nw_everett_2005$RUN)
nw_everett_2005 <- nw_everett_2005[(substr(nw_everett_2005$NAICS,1,3)) %in% c(441:448,451:454,722),]
nw_everett_2005 <- nw_everett_2005[-grep(c("FLANDERS"),nw_everett_2005$ADDRESS),]
nw_everett_2005 <- nw_everett_2005[-grep(c("DAVIS"),nw_everett_2005$ADDRESS),]
nw_everett_2005$emp2005 <- rowMeans(subset(nw_everett_2005,select=c(which(colnames(nw_everett_2005)=="JAN"),which(colnames(nw_everett_2005)=="JAN")+11)))

nw_everett <- Reduce(function(x, y) merge(x, y, by="BIN",all=TRUE), 
                    list(nw_everett_2005[,c("BIN","emp2005")],nw_everett_2006[,c("BIN","emp2006")],nw_everett_2008[,c("BIN","emp2008")],nw_everett_2009[,c("BIN","emp2009")],
                         nw_everett_2010[,c("BIN","emp2010")],nw_everett_2011[,c("BIN","emp2011")],nw_everett_2012[,c("BIN","emp2012")],nw_everett_2013[,c("BIN","emp2013")],
                         nw_everett_2014[,c("BIN","emp2014")],nw_everett_2015[,c("BIN","emp2015")]))
nw_everett[is.na(nw_everett)] <- 0
nw_everett <- nw_everett[apply(nw_everett[,-1], 1, function(x) !all(x<=1)),] # delete 0 or 1 values
nw_everett <- nw_everett[apply(nw_everett[,-c(1:3,10:11)], 1, function(x) !all(x<=1)),] # delete stores closed or have 1 employee before 2008 and open after 2013
nw_everett_cont <- nw_everett[apply(nw_everett[,-c(1:3,10:11)], 1, function(x) all(x!=0)),] # select the ones opens through 2008 to 2013
write.csv(nw_everett, "nw_everett_qcew.csv",sep=",",row.names = F)


# read & clean sw_alder data ----------------------------------------------

# read files
for (i in c(2005:2015)){
  myFiles <- paste0("SW_alder/sw_alder_",i,".dbf")
  assign(paste0("sw_alder_",i),read.dbf(myFiles))
}

# clean data
names(sw_alder_2015)
sw_alder_2015 <- sw_alder_2015[(substr(sw_alder_2015$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2015 <- sw_alder_2015[-grep(c("WASHINGTON"),sw_alder_2015$ADDR1),]
sw_alder_2015 <- sw_alder_2015[-grep(c("MORRISON"),sw_alder_2015$ADDR1),]
sw_alder_2015$emp2015 <- rowMeans(subset(sw_alder_2015,select=c(which(colnames(sw_alder_2015)=="JAN"),which(colnames(sw_alder_2015)=="JAN")+11)))

names(sw_alder_2014)
sw_alder_2014 <- sw_alder_2014[(substr(sw_alder_2014$naics,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2014 <- sw_alder_2014[-grep(c("WASHINGTON"),sw_alder_2014$street1),]
sw_alder_2014 <- sw_alder_2014[-grep(c("MORRISON"),sw_alder_2014$street1),]
sw_alder_2014$emp2014 <- rowMeans(subset(sw_alder_2014,select=c(which(colnames(sw_alder_2014)=="jan"),which(colnames(sw_alder_2014)=="jan")+11)))

names(sw_alder_2013)
colnames(sw_alder_2013)[1:2] <- c("BIN","UI")
sw_alder_2013 <- sw_alder_2013[(substr(sw_alder_2013$naics,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2013 <- sw_alder_2013[-grep(c("WASHINGTON"),sw_alder_2013$street1),]
sw_alder_2013 <- sw_alder_2013[-grep(c("MORRISON"),sw_alder_2013$street1),]
sw_alder_2013$emp2013 <- rowMeans(subset(sw_alder_2013,select=c(which(colnames(sw_alder_2013)=="jan"),which(colnames(sw_alder_2013)=="jan")+11)))

names(sw_alder_2012)
colnames(sw_alder_2012)[3:4] <- c("BIN","UI")
sw_alder_2012 <- sw_alder_2012[(substr(sw_alder_2012$naics,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2012 <- sw_alder_2012[-grep(c("WASHINGTON"),sw_alder_2012$street1),]
sw_alder_2012 <- sw_alder_2012[-grep(c("MORRISON"),sw_alder_2012$street1),]
sw_alder_2012$emp2012 <- rowMeans(subset(sw_alder_2012,select=c(which(colnames(sw_alder_2012)=="jan"),which(colnames(sw_alder_2012)=="jan")+11)))

names(sw_alder_2011)
sw_alder_2011 <- sw_alder_2011[(substr(sw_alder_2011$naics,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2011 <- sw_alder_2011[-grep(c("WASHINGTON"),sw_alder_2011$street1),]
sw_alder_2011 <- sw_alder_2011[-grep(c("MORRISON"),sw_alder_2011$street1),]
sw_alder_2011$emp2011 <- rowMeans(subset(sw_alder_2011,select=c(which(colnames(sw_alder_2011)=="jan"),which(colnames(sw_alder_2011)=="jan")+11)))

names(sw_alder_2010)
sw_alder_2010 <- sw_alder_2010[(substr(sw_alder_2010$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2010 <- sw_alder_2010[-grep(c("WASHINGTON"),sw_alder_2010$ADDRESS),]
sw_alder_2010 <- sw_alder_2010[-grep(c("MORRISON"),sw_alder_2010$ADDRESS),]
sw_alder_2010$emp2010 <- rowMeans(subset(sw_alder_2010,select=c(which(colnames(sw_alder_2010)=="JAN"),which(colnames(sw_alder_2010)=="JAN")+11)))

names(sw_alder_2009)
sw_alder_2009$BIN <- paste0(sw_alder_2009$UI,sw_alder_2009$RU)
sw_alder_2009 <- sw_alder_2009[(substr(sw_alder_2009$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2009 <- sw_alder_2009[-grep(c("WASHINGTON"),sw_alder_2009$ADDRESS),]
sw_alder_2009 <- sw_alder_2009[-grep(c("MORRISON"),sw_alder_2009$ADDRESS),]
sw_alder_2009$emp2009 <- rowMeans(subset(sw_alder_2009,select=c(which(colnames(sw_alder_2009)=="JAN"),which(colnames(sw_alder_2009)=="JAN")+11)))

names(sw_alder_2008)
colnames(sw_alder_2008)[8]<-"UI"
sw_alder_2008$BIN <- paste0(sw_alder_2008$UI,sw_alder_2008$RUN)
sw_alder_2008 <- sw_alder_2008[(substr(sw_alder_2008$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2008 <- sw_alder_2008[-grep(c("WASHINGTON"),sw_alder_2008$ADDR1),]
sw_alder_2008 <- sw_alder_2008[-grep(c("MORRISON"),sw_alder_2008$ADDR1),]
sw_alder_2008$emp2008 <- rowMeans(subset(sw_alder_2008,select=c(which(colnames(sw_alder_2008)=="JAN"),which(colnames(sw_alder_2008)=="JAN")+11)))

names(sw_alder_2007)
sw_alder_2007 <- sw_alder_2007[sw_alder_2007$SIC2 %in% c(52:59),]
sw_alder_2007 <- sw_alder_2007[-grep(c("WASHINGTON"),sw_alder_2007$ADDRESS),]
sw_alder_2007 <- sw_alder_2007[-grep(c("MORRISON"),sw_alder_2007$ADDRESS),]
sw_alder_2007$emp2007 <- sw_alder_2007$EMPLOYEE

names(sw_alder_2006)
colnames(sw_alder_2006)[5]<-"UI"
sw_alder_2006$BIN <- paste0(sw_alder_2006$UI,sw_alder_2006$RUN)
sw_alder_2006 <- sw_alder_2006[(substr(sw_alder_2006$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2006 <- sw_alder_2006[-grep(c("WASHINGTON"),sw_alder_2006$ADDRESS),]
sw_alder_2006 <- sw_alder_2006[-grep(c("MORRISON"),sw_alder_2006$ADDRESS),]
sw_alder_2006$emp2006 <- rowMeans(subset(sw_alder_2006,select=c(which(colnames(sw_alder_2006)=="JAN"),which(colnames(sw_alder_2006)=="JAN")+11)))

names(sw_alder_2005)
colnames(sw_alder_2005)[5]<-"UI"
sw_alder_2005$BIN <- paste0(sw_alder_2005$UI,sw_alder_2005$RUN)
sw_alder_2005 <- sw_alder_2005[(substr(sw_alder_2005$NAICS,1,3)) %in% c(441:448,451:454,722),]
sw_alder_2005 <- sw_alder_2005[-grep(c("WASHINGTON"),sw_alder_2005$ADDRESS),]
sw_alder_2005 <- sw_alder_2005[-grep(c("MORRISON"),sw_alder_2005$ADDRESS),]
sw_alder_2005$emp2005 <- rowMeans(subset(sw_alder_2005,select=c(which(colnames(sw_alder_2005)=="JAN"),which(colnames(sw_alder_2005)=="JAN")+11)))

sw_alder <- Reduce(function(x, y) merge(x, y, by="BIN",all=TRUE), 
                    list(sw_alder_2005[,c("BIN","emp2005")],sw_alder_2006[,c("BIN","emp2006")],sw_alder_2008[,c("BIN","emp2008")],sw_alder_2009[,c("BIN","emp2009")],
                         sw_alder_2010[,c("BIN","emp2010")],sw_alder_2011[,c("BIN","emp2011")],sw_alder_2012[,c("BIN","emp2012")],sw_alder_2013[,c("BIN","emp2013")],
                         sw_alder_2014[,c("BIN","emp2014")],sw_alder_2015[,c("BIN","emp2015")]))
sw_alder[is.na(sw_alder)] <- 0
sw_alder <- sw_alder[apply(sw_alder[,-1], 1, function(x) !all(x<=1)),] # delete 0 or 1 values
sw_alder <- sw_alder[apply(sw_alder[,-c(1:3,10:11)], 1, function(x) !all(x<=1)),] # delete stores closed or have 1 employee before 2008 and open after 2013
sw_alder_cont <- sw_alder[apply(sw_alder[,-c(1:3,10:11)], 1, function(x) all(x!=0)),] # select the ones opens through 2008 to 2013
write.csv(sw_alder, "sw_alder_qcew.csv",sep=",",row.names = F)


# ANALYSIS ----------------------------------------------------------------

# aggregatd annual growth rate comparison

stark_oak_agg <- colSums(stark_oak[,2:11])
sw_alder_agg <- colSums(sw_alder[,2:11])
nw_everett_agg <- colSums(nw_everett[,2:11])

stark_oak_cbind <- cbind(stark_oak_agg,sw_alder_agg,nw_everett_agg)

growth <- function(x)x/lag(x)-1
stark_oak_growth <-
  data.frame(stark_oak_cbind) %>%
  mutate_each(funs(growth),stark_oak_agg,sw_alder_agg,nw_everett_agg)

t.test(stark_oak_growth[2:5,]$stark_oak_agg,stark_oak_growth[2:5,]$nw_everett_agg)
t.test(stark_oak_growth[2:5,]$stark_oak_agg,stark_oak_growth[2:5,]$sw_alder_agg)


# DID

# DID analysis: stark_oak and nw_everett (aggregate)
stark_oak_did <- cbind(stark_oak[,3:9])
stark_oak_did$before <- rowMeans(stark_oak_did[,1:3])
stark_oak_did$after <- rowMeans(stark_oak_did[,5:7])
stark_oak_did <- melt(stark_oak_did[,8:9])
stark_oak_did$At <-c("treatment")

nw_everett_did <- cbind(nw_everett[,3:9])
nw_everett_did$before <- rowMeans(nw_everett_did[,1:3])
nw_everett_did$after <- rowMeans(nw_everett_did[,5:7])
nw_everett_did <- melt(nw_everett_did[,8:9])
nw_everett_did$At <- c("control")

stark_oak_DID_long <- rbind(stark_oak_did,nw_everett_did)
colnames(stark_oak_DID_long) <- c("Tt","CNS07","At")

stark_oak_DID_fit1 <- lm(CNS07~Tt*At,stark_oak_DID_long)
summary(stark_oak_DID_fit1)

# DID analysis: stark_oak and nw_everett (2008/2012)
stark_oak_did <- cbind(stark_oak[,3:9])
stark_oak_did$before <- stark_oak_did[,2]
stark_oak_did$after <- stark_oak_did[,6]
stark_oak_did <- melt(stark_oak_did[,8:9])
stark_oak_did$At <-c("treatment")

nw_everett_did <- cbind(nw_everett[,3:9])
nw_everett_did$before <- nw_everett_did[,2]
nw_everett_did$after <- nw_everett_did[,6]
nw_everett_did <- melt(nw_everett_did[,8:9])
nw_everett_did$At <- c("control")

stark_oak_DID_long <- rbind(stark_oak_did,nw_everett_did)
colnames(stark_oak_DID_long) <- c("Tt","CNS07","At")

stark_oak_DID_fit2 <- lm(CNS07~Tt*At,stark_oak_DID_long)
summary(stark_oak_DID_fit2)



# DID analysis: stark_oak and sw_alder (aggregate)
stark_oak_did <- cbind(stark_oak[,3:9])
stark_oak_did$before <- rowMeans(stark_oak_did[,1:3])
stark_oak_did$after <- rowMeans(stark_oak_did[,5:7])
stark_oak_did <- melt(stark_oak_did[,8:9])
stark_oak_did$At <-c("treatment")

sw_alder_did <- cbind(sw_alder[,3:9])
sw_alder_did$before <- rowMeans(sw_alder_did[,1:3])
sw_alder_did$after <- rowMeans(sw_alder_did[,5:7])
sw_alder_did <- melt(sw_alder_did[,8:9])
sw_alder_did$At <- c("control")

stark_oak_DID_long <- rbind(stark_oak_did,sw_alder_did)
colnames(stark_oak_DID_long) <- c("Tt","CNS07","At")

stark_oak_DID_fit1 <- lm(CNS07~Tt*At,stark_oak_DID_long)
summary(stark_oak_DID_fit1)

# DID analysis: stark_oak and sw_alder (2008/2012)
stark_oak_did <- cbind(stark_oak[,3:9])
stark_oak_did$before <- stark_oak_did[,2]
stark_oak_did$after <- stark_oak_did[,6]
stark_oak_did <- melt(stark_oak_did[,8:9])
stark_oak_did$At <-c("treatment")

sw_alder_did <- cbind(sw_alder[,3:9])
sw_alder_did$before <- sw_alder_did[,2]
sw_alder_did$after <- sw_alder_did[,6]
sw_alder_did <- melt(sw_alder_did[,8:9])
sw_alder_did$At <- c("control")

stark_oak_DID_long <- rbind(stark_oak_did,sw_alder_did)
colnames(stark_oak_DID_long) <- c("Tt","CNS07","At")

stark_oak_DID_fit2 <- lm(CNS07~Tt*At,stark_oak_DID_long)
summary(stark_oak_DID_fit2)


# ITS
# CNS07 time series analysis: disaggregate intervention analysis
# https://rpubs.com/kaz_yos/its1

stark_oak_long <- melt(stark_oak)
colnames(stark_oak_long) <- c("GEOID10","year","emp")
stark_oak_long$year <- as.numeric(substr(stark_oak_long$year,4,7)) -2004
stark_oak_long$emp <- as.numeric(stark_oak_long$emp)
stark_oak_long$Xt <- ifelse(stark_oak_long$year>5,"post","pre")

stark_oak_fit <- lm(emp~year*Xt,stark_oak_long)
summary(stark_oak_fit)

# time series analysis: aggregate intervention analysis
stark_oak_its <- matrix(c(1:10),nrow=10)
stark_oak_its <- data.frame(stark_oak_its)
stark_oak_its$emp <- stark_oak_agg
colnames(stark_oak_its) <- c("year","emp")
stark_oak_its$Xt <- ifelse(stark_oak_its$year<6,"pre","post")
stark_oak_fit2 <- lm(emp~year*Xt,stark_oak_its)
summary(stark_oak_fit2)
