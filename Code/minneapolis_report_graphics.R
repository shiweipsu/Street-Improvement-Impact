minn_agg <- minn_lehd %>% 
group_by(year) %>% summarise_if(is.numeric, sum)  

minn_base <- minn_lehd %>% filter(year == 2011) %>% 
  select(CNS07sum = CNS07, CNS18sum = CNS18) %>% summarise_if(is.numeric, sum)


minn_agg <- cbind(minn_agg, minn_base)

minn_agg <- minn_agg %>% 
  mutate(retail_idx = CNS07/CNS07sum*100,
         accom_idx = CNS18/CNS18sum*100) %>% 
  select(year, CNS07, CNS18, CNS07sum, CNS18sum, retail_idx, accom_idx)

minn_agg <- minn_agg %>% filter(!is.na(year))

minn_agg$Type <- "city"

minn_agg <- minn_agg %>% select(Type, year, CNS07_sd = retail_idx, 
                                CNS18_sd= accom_idx)

readr::write_csv(minn_agg, "Data/minneapolis_city_index.csv")

riverside_agg <- agg_index_trend_table(minn_corridor, group = 2, 2011) %>% 
  filter(!is.na(year))

riverside_agg$business_sd <- NULL

riverside_agg <- bind_rows(riverside_agg, minn_agg)

#manually build plot----------------------------

riverside_agg$Type <- factor(riverside_agg$Type, 
                             levels = c("improvement", "control", "city"))

 retail <- ggplot(riverside_agg,aes(x=as.numeric(as.character(year)), 
                                                                 y=CNS07_sd,group=Type,colour=Type,shape=Type))+
  geom_rect(aes(xmin = 2011, xmax = 2012, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21, 23))+
  scale_x_discrete(breaks=c(2004,2006,2008,2010,2012,2014,2016)) +
  theme_minimal() +
  labs(title = "Retail Employment:\n Franklin Ave", x="Year",
       y="Employment Index",
       caption = "Employment is indexed to 2011 \n Shaded Area is Construction Period")



 
 accom <- ggplot(riverside_agg,aes(x=as.numeric(as.character(year)), 
                          y=CNS18_sd,group=Type,colour=Type,shape=Type))+
   geom_rect(aes(xmin = 2011, xmax = 2012, ymin = -Inf, ymax = Inf),fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
   geom_line() + 
   geom_point(size=3, fill="white") +
   scale_shape_manual(values=c(22,21, 23))+
   scale_x_discrete(breaks=c(2004,2006,2008,2010,2012,2014,2016)) +
   theme_minimal() +
   labs(title = "Food & Accommodations Employment:\n Franklin Ave", x="Year",
        y="Employment Index",
        caption = "Employment is indexed to 2011 \n Shaded Area is Construction Period")
 

 city_franklin <- plot_grid(retail, accom, align = "h")
