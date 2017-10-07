load("Data/stark_oak_LEHD.RData")
library(ggplot2)
library(dplyr)

df_trt <- stark_oak_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_trt <- melt(df_trt %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_trt$NAICS <- substr(df_trt$variable,1,5)
df_trt$year <- substr(df_trt$variable,7,10)
df_trt$Corridor_group <- "Improvement Corridor"
df_trt$fill <- ifelse(df_trt$year==2010,"Construction",ifelse(df_trt$year>2010,"Post construction",NA))
df_trt$value_sd <- ifelse(df_trt$NAICS=="CNS00",df_trt$value/df_trt[9,]$value*100,
                          ifelse(df_trt$NAICS=="CNS07",df_trt$value/df_trt[22,]$value*100,df_trt$value/df_trt[35,]$value*100))

df_cp1 <- nw_everett_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_cp1 <- melt(df_cp1 %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_cp1$NAICS <- substr(df_cp1$variable,1,5)
df_cp1$year <- substr(df_cp1$variable,7,10)
df_cp1$Corridor_group <- "NW Everett"
df_cp1$fill <- ifelse(df_cp1$year==2010,"Construction",ifelse(df_cp1$year>2010,"Post construction",NA))
df_cp1$value_sd <- ifelse(df_cp1$NAICS=="CNS00",df_cp1$value/df_cp1[9,]$value*100,
                          ifelse(df_cp1$NAICS=="CNS07",df_cp1$value/df_cp1[22,]$value*100,df_cp1$value/df_cp1[35,]$value*100))


df_cp2 <- sw_alder_retail_job %>% 
  select (starts_with("C000."),starts_with("CNS07"),starts_with("CNS18")) 
df_cp2 <- melt(df_cp2 %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_cp2$NAICS <- substr(df_cp2$variable,1,5)
df_cp2$year <- substr(df_cp2$variable,7,10)
df_cp2$Corridor_group <- "SW Alder"
df_cp2$fill <- ifelse(df_cp2$year==2010,"Construction",ifelse(df_cp2$year>2010,"Post construction",NA))
df_cp2$value_sd <- ifelse(df_cp2$NAICS=="C000.",df_cp2$value/df_cp2[9,]$value*100,
                          ifelse(df_cp2$NAICS=="CNS07",df_cp2$value/df_cp2[22,]$value*100,df_cp2$value/df_cp2[35,]$value*100))

df_nb <- Downtown_nb_retail_job %>% 
  select (starts_with("CNS00"),starts_with("CNS07"),starts_with("CNS18")) 
df_nb <- melt(df_nb %>% summarise_each(funs(sum=sum(.,nr.rm=T))))
df_nb$NAICS <- substr(df_nb$variable,1,5)
df_nb$year <- substr(df_nb$variable,7,10)
df_nb$Corridor_group <- "Neighborhood"
df_nb$fill <- ifelse(df_nb$year==2010,"Construction",ifelse(df_nb$year>2010,"Post construction",NA))
df_nb$value_sd <- ifelse(df_nb$NAICS=="CNS00",df_nb$value/df_nb[9,]$value*100,
                          ifelse(df_nb$NAICS=="CNS07",df_nb$value/df_nb[22,]$value*100,df_nb$value/df_nb[35,]$value*100))

df <- rbind(df_trt,df_cp1,df_cp2,df_nb)

ggplot(df[df$NAICS=="CNS07",]%>%mutate(year=as.numeric(year)), aes(x=year, y=value_sd, group=Corridor_group,colour=Corridor_group,shape=Corridor_group)) +
  geom_rect(aes(xmin = 2010, xmax = 2011, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_rect(aes(xmin = 2011, xmax = 2014, ymin = -Inf, ymax = Inf),fill = "darkolivegreen3",linetype=0,alpha = 0.03) +
  geom_text(x=2010.5,y=150,label="Construction",colour="grey40",size=4)+
  geom_text(x=2012.5,y=150,label="Post \n construction",colour="grey40",size=4)+
  geom_text(x=2004,y=110,label="Employment in 2010 = 100",colour="grey40",size=4)+
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21,21,23))+
  scale_x_continuous(breaks=c(2002:2014)) +
  labs(title = "Retail Service Employment Comparison: SW Stark & Oak", x="Year",y="Employment Index")
  
ggplot(df[df$NAICS=="CNS18",]%>%mutate(year=as.numeric(year)), aes(x=year, y=value_sd, group=Corridor_group,colour=Corridor_group,shape=Corridor_group)) +
  geom_rect(aes(xmin = 2010, xmax = 2011, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_rect(aes(xmin = 2011, xmax = 2014, ymin = -Inf, ymax = Inf),fill = "darkolivegreen3",linetype=0,alpha = 0.03) +
  geom_text(x=2010.5,y=130,label="Construction",colour="grey40",size=4)+
  geom_text(x=2012.5,y=130,label="Post \n construction",colour="grey40",size=4)+
  geom_text(x=2004,y=110,label="Employment in 2010 = 100",colour="grey40",size=4)+
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21,21,23))+
  scale_x_continuous(breaks=c(2002:2014)) +
  labs(title = "Food & Accormodation Service Employment Comparison: SW Stark & Oak", x="Year",y="Employment Index") +
  
  


ggplot(df[df$NAICS%in%c("CNS07","CNS18"),]%>%mutate(year=as.numeric(year)), aes(x=year, y=value, group=group,colour=group,shape=group)) +
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21))


