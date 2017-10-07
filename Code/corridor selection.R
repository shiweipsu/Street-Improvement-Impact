source("Code/data extraction.R")

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
