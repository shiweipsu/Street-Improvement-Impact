
# Stark_Oak_Portland ------------------------------------------------------


options(scipen = 999)
load("Data/wac.RData")
library(foreign)

Downtown_nb_shp <- read.dbf("Shapefile/Downtown_nb.dbf")
Downtown_nb_retail <- merge(Downtown_nb_shp,wac.S000.JT00.2002[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2003[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2004[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2005[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2006[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2007[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2008[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2009[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2011[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2012[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2013[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Downtown_nb_retail <- merge(Downtown_nb_retail,wac.S000.JT00.2014[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))

Downtown_nb_retail_job <- Downtown_nb_retail[,c(1,16:132)]

library(dplyr)
Downtown_nb_retail_CNS00 <- select(Downtown_nb_retail_job, GEOID10,starts_with("C00"))
colnames(Downtown_nb_retail_CNS00) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS07 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS07"))
colnames(Downtown_nb_retail_CNS07) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS12 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS12"))
colnames(Downtown_nb_retail_CNS12) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS14 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS14"))
colnames(Downtown_nb_retail_CNS12) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS15 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS15"))
colnames(Downtown_nb_retail_CNS15) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS16 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS16"))
colnames(Downtown_nb_retail_CNS16) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS17 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS17"))
colnames(Downtown_nb_retail_CNS17) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS18 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS18"))
colnames(Downtown_nb_retail_CNS18) <- c("GEOID10",2002:2014)
Downtown_nb_retail_CNS19 <- select(Downtown_nb_retail_job, GEOID10,starts_with("CNS19"))
colnames(Downtown_nb_retail_CNS19) <- c("GEOID10",2002:2014)

colnames(Downtown_nb_retail_job) <- c("GEOID10","CNS00.2002","CNS07.2002","CNS12.2002","CNS14.2002","CNS15.2002","CNS16.2002","CNS17.2002","CNS18.2002","CNS19.2002",
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

Downtown_nb_agg <- colSums(Downtown_nb_retail_job[,2:118])
Downtown_nb_agg
Downtown_nb_avg <- colMeans(Downtown_nb_retail_job[,2:118])
Downtown_nb_avg
Downtown_nb_retail_job[,c(1,74:82)]


Portland_shp <- read.dbf("Shapefile/Portland_blocks.dbf")
Portland_retail <- merge(Portland_shp,wac.S000.JT00.2010[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Portland_retail <- merge(Portland_retail,wac.S000.JT00.2011[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Portland_retail <- merge(Portland_retail,wac.S000.JT00.2012[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))
Portland_retail <- merge(Portland_retail,wac.S000.JT00.2013[,c("w_geocode","C000","CNS07","CNS12","CNS14","CNS15","CNS16","CNS17","CNS18","CNS19")],by.x=c("GEOID10"),by.y=c("w_geocode"))

Portland_retail_job <- Portland_retail[,c(1,22:57)]

colnames(Portland_retail_job) <- c("GEOID10","CNS00.2010","CNS07.2010","CNS12.2010","CNS14.2010","CNS15.2010","CNS16.2010","CNS17.2010","CNS18.2010","CNS19.2010",
                                      "CNS00.2011","CNS07.2011","CNS12.2011","CNS14.2011","CNS15.2011","CNS16.2011","CNS17.2011","CNS18.2011","CNS19.2011",
                                      "CNS00.2012","CNS07.2012","CNS12.2012","CNS14.2012","CNS15.2012","CNS16.2012","CNS17.2012","CNS18.2012","CNS19.2012",
                                      "CNS00.2013","CNS07.2013","CNS12.2013","CNS14.2013","CNS15.2013","CNS16.2013","CNS17.2013","CNS18.2013","CNS19.2013")
Portland_agg <- colSums(Portland_retail_job[,2:37])
Portland_agg


i<-2009
df_trt <- polk_2009_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_trt <- melt(df_trt %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_trt$NAICS <- substr(df_trt$variable,1,5)
df_trt$year <- substr(df_trt$variable,7,10)
df_trt$Corridor_group <- "Treatment"
df_trt$fill <- ifelse(df_trt$year==2010,"Construction",ifelse(df_trt$year>2010,"Post construction",NA))
df_trt$adj_value <- ifelse(df_trt$NAICS=="CNS00",df_trt$value*100/df_trt[i-2001,]$value,ifelse(df_trt$NAICS=="CNS07",df_trt$value*100/df_trt[i+13-2001,]$value,df_trt$value*100/df_trt[i+26-2001,]$value))

df_cp <- van_ness_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_cp <- melt(df_cp %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_cp$NAICS <- substr(df_cp$variable,1,5)
df_cp$year <- substr(df_cp$variable,7,10)
df_cp$Corridor_group <- "Comparison"
df_cp$fill <- ifelse(df_cp$year==2010,"Construction",ifelse(df_cp$year>2010,"Post construction",NA))
df_cp$adj_value <- ifelse(df_cp$NAICS=="CNS00",df_cp$value*100/df_cp[i-2001,]$value,ifelse(df_cp$NAICS=="CNS07",df_cp$value*100/df_cp[i+13-2001,]$value,df_cp$value*100/df_cp[i+26-2001,]$value))

df_sf <- sf_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_sf <- melt(df_sf %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_sf$NAICS <- substr(df_sf$variable,1,5)
df_sf$year <- substr(df_sf$variable,7,10)
df_sf$Corridor_group <- "City"
df_sf$fill <- ifelse(df_sf$year==2010,"Construction",ifelse(df_sf$year>2010,"Post construction",NA))
df_sf$adj_value <- ifelse(df_sf$NAICS=="CNS00",df_sf$value*100/df_sf[i-2001,]$value,ifelse(df_sf$NAICS=="CNS07",df_sf$value*100/df_sf[i+13-2001,]$value,df_sf$value*100/df_sf[i+26-2001,]$value))

df <- rbind(df_trt,df_cp,df_sf)

library(ggplot2)
ggplot(df[df$NAICS=="CNS07",]%>%mutate(year=as.numeric(year)), aes(x=year, y=adj_value, group=Corridor_group,colour=Corridor_group,shape=Corridor_group)) +
  geom_rect(aes(xmin = 2009, xmax = 2010, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_rect(aes(xmin = 2010, xmax = 2014, ymin = -Inf, ymax = Inf),fill = "darkolivegreen3",linetype=0,alpha = 0.03) +
  geom_text(x=2009.5,y=120,label="Construction",colour="grey20",size=5,angle=90)+
  geom_text(x=2011.5,y=120,label="Post \n construction",colour="grey20",size=5,angle=90)+
  geom_text(x=2003,y=95,label="Employment in 2009 = 100",colour="grey30",size=3,)+
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21,23))+
  scale_x_continuous(breaks=c(2002:2014)) +
  labs(title = "Retail Service Employment: Polk vs Van Ness", x="Year",y="Employment")

ggplot(df[df$NAICS=="CNS18",]%>%mutate(year=as.numeric(year)), aes(x=year, y=adj_value, group=Corridor_group,colour=Corridor_group,shape=Corridor_group)) +
  geom_rect(aes(xmin = 2009, xmax = 2010, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_rect(aes(xmin = 2010, xmax = 2014, ymin = -Inf, ymax = Inf),fill = "darkolivegreen3",linetype=0,alpha = 0.03) +
  geom_text(x=2009.5,y=100,label="Construction",colour="grey30",size=5, angle=90)+
  geom_text(x=2011.5,y=100,label="Post \n construction",colour="grey30",size=5, angle=90)+
  geom_text(x=2003,y=93,label="Employment in 2009 = 100",colour="grey30",size=3,)+
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21,23))+
  scale_x_continuous(breaks=c(2002:2014)) +
  labs(title = "Food & Accormodation Service Employment: Polk vs Van Ness ", x="Year",y="Employment") 

library(dplyr)
df_CNS07 <- df[df$year%in%c(2009:2012)&df$NAICS=="CNS07",]
emp_2009 <- df_CNS07[df_CNS07$year==2009,]$value
emp_2010 <- df_CNS07[df_CNS07$year==2010,]$value
emp_2011 <- df_CNS07[df_CNS07$year==2011,]$value
emp_2012 <- df_CNS07[df_CNS07$year==2012,]$value
df_tab_CNS07 <-cbind(group,data.frame(cbind( emp_2009,emp_2010,emp_2011,emp_2012)))
df_tab_CNS07 <- df_tab_CNS07 %>%
  mutate(first=(emp_2010-emp_2009)/emp_2009)%>%
  mutate(second=(emp_2011-emp_2010)/emp_2010)%>%
  mutate(third=(emp_2012-emp_2011)/emp_2011)
# colnames(df_tab_CNS07) <-c("Area","Baseline Employment","Employment (2010)","Employment (2011)","Employment (2012)",
"first year difference","second year difference","third year difference")
stargazer(data.frame(df_tab_CNS07[,c(1:2,6:8)]),type="text",summary=FALSE,rownames=FALSE)

df_CNS18 <- df[df$year%in%c(2009:2012)&df$NAICS=="CNS18",]
emp_2009 <- df_CNS18[df_CNS18$year==2009,]$value
emp_2010 <- df_CNS18[df_CNS18$year==2010,]$value
emp_2011 <- df_CNS18[df_CNS18$year==2011,]$value
emp_2012 <- df_CNS18[df_CNS18$year==2012,]$value
df_tab_CNS18 <-cbind(group,data.frame(cbind( emp_2009,emp_2010,emp_2011,emp_2012)))
df_tab_CNS18 <- df_tab_CNS18 %>%
  mutate(first=(emp_2010-emp_2009)/emp_2009)%>%
  mutate(second=(emp_2011-emp_2010)/emp_2010)%>%
  mutate(third=(emp_2012-emp_2011)/emp_2011)
stargazer(data.frame(df_tab_CNS18[,c(1:2,6:8)]),type="text",summary=FALSE,rownames=FALSE)

