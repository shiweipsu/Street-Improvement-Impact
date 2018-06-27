if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here,sf, ggplot2, readr, ggthemes, cowplot, dplyr)

source(here::here("Code/corridor_comparison_functions.R"))


minn_agg <- read_csv("Data/minneapolis_city_index.csv", 
                            col_types =  cols(Type = "c", 
                                             year = "c",
                                              .default = "n"))

minn_corridor <- st_read(here::here("Data/minneapolis/minn_corridor_lehd_wgs84.geojson")) %>% 
  as.data.frame()

central_agg <- agg_index_trend_table(minn_corridor, group = 3, 2012) %>% 
  filter(!is.na(year))

central_agg$business_sd <- NULL

central_agg <- bind_rows(central_agg, minn_agg)

#manually build plot----------------------------

central_agg$Type <- factor(central_agg$Type, 
                             levels = c("improvement", "control", "city"))

 retail <- ggplot(central_agg,
                  aes(x=as.numeric(as.character(year)), y=CNS07_sd,
                      group=Type,colour=Type,shape=Type))+
  geom_rect(aes(xmin = 2008, xmax = 2009, ymin = -Inf, ymax = Inf),
            fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
  geom_line() + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21, 23))+
  scale_x_discrete(breaks=c(2004,2006,2008,2010,2012,2014,2016)) +
  theme_minimal() +
  labs(title = "Retail Employment:\ncentral Ave.", x="Year",
       y="Employment Index",
       caption = "Employment is indexed to 2011 \n 
       Shaded Area is Construction Period")



 
 accom <- ggplot(central_agg,aes(x=as.numeric(as.character(year)), 
                          y=CNS18_sd,group=Type,colour=Type,shape=Type))+
   geom_rect(aes(xmin = 2008, xmax = 2009, ymin = -Inf, ymax = Inf),
             fill = "darkolivegreen1",linetype=0,alpha = 0.03) +
   geom_line() + 
   geom_point(size=3, fill="white") +
   scale_shape_manual(values=c(22,21, 23))+
   scale_x_discrete(breaks=c(2004,2006,2008,2010,2012,2014,2016)) +
   theme_minimal() +
   labs(title = "Food & Accommodations Employment:\ncentral Ave.", 
        x="Year",
        y="Employment Index",
        caption = "Employment is indexed to 2011 \n 
        Shaded Area is Construction Period")
 

 city_central <- plot_grid(retail, accom, align = "h")
 
 
