library(sf)
library(gdata)
library(tidyverse)
options(scipen=999)

# read data ---------------------------------------------

# read files
for (i in c(2005:2015)){
  myFiles <- paste0("Data/Portland/QCEW/Stark_oak/stark_oak_",i,".shp")
  assign(paste0("stark_oak_",i),st_read(myFiles,layer=paste0("stark_oak_",i))%>% as.data.frame())
}

for (i in c(2005:2015)){
  myFiles <- paste0("Data/Portland/QCEW/NW_everett/nw_everett_",i,".dbf")
  assign(paste0("nw_everett_",i),st_read(myFiles,layer=paste0("nw_everett_",i))%>% as.data.frame())
}

for (i in c(2005:2015)){
  myFiles <- paste0("Data/Portland/QCEW/SW_alder/sw_alder_",i,".dbf")
  assign(paste0("sw_alder_",i),st_read(myFiles,layer=paste0("sw_alder_",i)) %>% as.data.frame())
}



# clean into corridor level quarterly retail & food employment and wage data ------------
# each file has different column names; 2007 file only has yearly employment

corridor_2015 <- gdata::combine(stark_oak_2015,nw_everett_2015,sw_alder_2015) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDR1),
         !grepl("BURNSIDE",ADDR1),
         !grepl("FLANDERS",ADDR1),
         !grepl("DAVIS",ADDR1),
         !grepl("MORRISON",ADDR1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year = 2015) %>% 
  group_by(source,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(PAYQ1), pay_q2 = sum(PAYQ2), pay_q3 = sum(PAYQ3), pay_q4 = sum (PAYQ4))


corridor_2014 <- gdata::combine(stark_oak_2014,nw_everett_2014,sw_alder_2014) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",STREET1),
         !grepl("BURNSIDE",STREET1),
         !grepl("FLANDERS",STREET1),
         !grepl("DAVIS",STREET1),
         !grepl("MORRISON",STREET1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2014) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(Q1PAY), pay_q2 = sum(Q2PAY), pay_q3 = sum(Q3PAY), pay_q4 = sum (Q4PAY)) %>% rename_all(tolower)
  

corridor_2013 <- gdata::combine(stark_oak_2013,nw_everett_2013,sw_alder_2013) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",STREET1),
         !grepl("BURNSIDE",STREET1),
         !grepl("FLANDERS",STREET1),
         !grepl("DAVIS",STREET1),
         !grepl("MORRISON",STREET1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2013) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(Q1PAY), pay_q2 = sum(Q2PAY), pay_q3 = sum(Q3PAY), pay_q4 = sum (Q4PAY)) %>% rename_all(tolower)


corridor_2012 <- gdata::combine(stark_oak_2012,nw_everett_2012,sw_alder_2012) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",STREET1),
         !grepl("BURNSIDE",STREET1),
         !grepl("FLANDERS",STREET1),
         !grepl("DAVIS",STREET1),
         !grepl("MORRISON",STREET1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2012) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(Q1PAY), pay_q2 = sum(Q2PAY), pay_q3 = sum(Q3PAY), pay_q4 = sum (Q4PAY)) %>% rename_all(tolower)

corridor_2011 <- gdata::combine(stark_oak_2011,nw_everett_2011,sw_alder_2011) %>% 
  select(-"Source") %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",STREET1),
         !grepl("BURNSIDE",STREET1),
         !grepl("FLANDERS",STREET1),
         !grepl("DAVIS",STREET1),
         !grepl("MORRISON",STREET1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2011) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(Q1PAY), pay_q2 = sum(Q2PAY), pay_q3 = sum(Q3PAY), pay_q4 = sum (Q4PAY)) %>% rename_all(tolower)


corridor_2010 <- gdata::combine(stark_oak_2010,nw_everett_2010,sw_alder_2010) %>% 
  select(-"SOURCE") %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDRESS),
         !grepl("BURNSIDE",ADDRESS),
         !grepl("FLANDERS",ADDRESS),
         !grepl("DAVIS",ADDRESS),
         !grepl("MORRISON",ADDRESS)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2010) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(PAYQ1), pay_q2 = sum(PAYQ2), pay_q3 = sum(PAYQ3), pay_q4 = sum (PAYQ4)) %>% rename_all(tolower)


corridor_2009 <- gdata::combine(stark_oak_2009,nw_everett_2009,sw_alder_2009) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDRESS),
         !grepl("BURNSIDE",ADDRESS),
         !grepl("FLANDERS",ADDRESS),
         !grepl("DAVIS",ADDRESS),
         !grepl("MORRISON",ADDRESS)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2009) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(WAGESQ1), pay_q2 = sum(WAGESQ2), pay_q3 = sum(WAGESQ3), pay_q4 = sum (WAGESQ4)) %>% rename_all(tolower)


corridor_2008 <- gdata::combine(stark_oak_2008,nw_everett_2008,sw_alder_2008) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDR1),
         !grepl("BURNSIDE",ADDR1),
         !grepl("FLANDERS",ADDR1),
         !grepl("DAVIS",ADDR1),
         !grepl("MORRISON",ADDR1)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         year=2008) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(PAY1), pay_q2 = sum(PAY2), pay_q3 = sum(PAY3), pay_q4 = sum (PAY4)) %>% rename_all(tolower)


corridor_2007 <- gdata::combine(stark_oak_2007,nw_everett_2007,sw_alder_2007) %>% 
  select(-"YEAR") %>% 
  rename_all(toupper) %>% 
  filter(SIC2 %in% c(52:54,56:59),
         !grepl("WASHINGTON",ADDRESS),
         !grepl("BURNSIDE",ADDRESS),
         !grepl("FLANDERS",ADDRESS),
         !grepl("DAVIS",ADDRESS),
         !grepl("MORRISON",ADDRESS)) %>% 
  mutate(busi_type = ifelse(SIC2==58, "Food", "Retail"),
         year = 2007) %>% 
  group_by(SOURCE,year,busi_type) %>% 
  summarise(emp = sum (EMPLOYEE)) %>% rename_all(tolower)


corridor_2006 <- gdata::combine(as.data.frame(stark_oak_2006[1:60]),as.data.frame(nw_everett_2006[1:60]),as.data.frame(sw_alder_2006[1:60])) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDRESS),
         !grepl("BURNSIDE",ADDRESS),
         !grepl("FLANDERS",ADDRESS),
         !grepl("DAVIS",ADDRESS),
         !grepl("MORRISON",ADDRESS)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         YEAR=2006) %>% 
  group_by(SOURCE,YEAR,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(PAYQ1), pay_q2 = sum(PAYQ2), pay_q3 = sum(PAYQ3), pay_q4 = sum (PAYQ4)) %>% rename_all(tolower)


corridor_2005 <- gdata::combine(as.data.frame(stark_oak_2005),as.data.frame(nw_everett_2005),as.data.frame(sw_alder_2005)) %>% 
  rename_all(toupper) %>% 
  mutate(NAICS_3 = substr(NAICS,1,3)) %>% 
  filter(NAICS_3 %in% c(441:448,451:454,722),
         !grepl("WASHINGTON",ADDRESS),
         !grepl("BURNSIDE",ADDRESS),
         !grepl("FLANDERS",ADDRESS),
         !grepl("DAVIS",ADDRESS),
         !grepl("MORRISON",ADDRESS)) %>% 
  mutate(busi_type = ifelse(NAICS_3 ==722, "Food", "Retail"),
         EMPQ1 = rowSums(.[c("JAN","FEB","MAR")]/3),
         EMPQ2 = rowSums(.[c("APR","MAY","JUN")]/3),
         EMPQ3 = rowSums(.[c("JUL","AUG","SEP")]/3),
         EMPQ4 = rowSums(.[c("OCT","NOV","DEC")]/3),
         YEAR=2005) %>% 
  group_by(SOURCE,YEAR,busi_type) %>% 
  summarise(emp_q1 = sum(EMPQ1), emp_q2 = sum(EMPQ2), emp_q3 = sum(EMPQ3), emp_q4 = sum (EMPQ4),
            pay_q1 = sum(PAYQ1), pay_q2 = sum(PAYQ2), pay_q3 = sum(PAYQ3), pay_q4 = sum (PAYQ4)) %>% rename_all(tolower)


# combine quarter data together and tidy them
corridor <- gdata::combine(corridor_2015, corridor_2014, corridor_2013, corridor_2012, corridor_2011, 
                          corridor_2010, corridor_2009, corridor_2008, corridor_2006, corridor_2005) %>% 
  mutate(name = case_when(grepl("stark_oak", source) ~ "Stark & Oak",
                          grepl("nw_everett", source) ~ "Everett",
                          grepl("sw_alder", source) ~ "Alder")) %>% 
  select(name,year:pay_q4)


stark_corridor <- corridor  %>% 
  gather(quarter, value, 4:11) %>% 
  mutate(eco = substr(quarter,1,3),
         quarter = substr(quarter,5,6)) %>% 
  select(name, year, quarter, busi_type, eco, value) %>% 
  spread(eco, value) %>% 
  arrange(name, busi_type, year,quarter)

stark_corridor_annual <- stark_corridor %>% 
  group_by(name, year, busi_type) %>% 
  summarise(emp = mean(emp),
            pay = sum(pay))

corridor_2007 <- corridor_2007 %>% 
  mutate(name = case_when(grepl("stark_oak", source) ~ "Stark & Oak",
                          grepl("nw_everett", source) ~ "Everett",
                          grepl("sw_alder", source) ~ "Alder"),
         pay=NA) %>% 
  select(-"source")

stark_corridor_annual <- rbind(as.data.frame(stark_corridor_annual), as.data.frame(as.data.frame(corridor_2007)[,2:6])) %>% 
  arrange(name, busi_type, year)

rm(list= ls()[!(ls() %in% c('stark_corridor_annual'))])
