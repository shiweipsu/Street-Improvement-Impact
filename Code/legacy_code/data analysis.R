source("Code/corridor selection.R")

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