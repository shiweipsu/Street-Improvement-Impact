if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(here, svglite, stargazer, sf,  broom, dplyr)
extrafont::loadfonts(device = "win")

library(c("ggplot2", "ggthemes", "cowplot"))

source(here::here("Code/corridor_comparison_functions.R"))

minn_corridor <- st_read(here::here("Data/minneapolis/minn_corridor_lehd_wgs84.geojson"))


franklin_did <- did_agg_analysis(minn_corridor, group = 2,endyear = 2011)

franklin_retail <- franklin_did[[1]]
franklin_retail <- broom::tidy(franklin_retail)

franklin_retail <- franklin_retail %>% 
  filter(term != "(Intercept)") %>% 
  mutate(model = "Retail")

franklin_accom <- franklin_did[[2]]
franklin_accom <- broom::tidy(franklin_accom)

franklin_accom <- franklin_accom %>% 
  filter(term != "(Intercept)") %>% 
  mutate(model = "Accommodations")


franklin_full <- bind_rows(franklin_retail, franklin_accom)

franklin_full <- franklin_full %>% 
  mutate(coeff_lab = 
           case_when(term == "Typeimprovement" ~ "Treatment",
                     term == "prepost" ~ "Pre-Post",
                     term == "Typeimprovement:prepost" ~ "DiD",
                     TRUE ~ term))


franklin_did_plot <- ggplot(franklin_full, 
       aes(x = coeff_lab, y = estimate, color = model)) +
  geom_pointrange(aes(ymin = estimate - std.error, 
                      ymax = estimate + std.error), 
                  position = position_dodge(width = .5)) +
  coord_flip() +
  theme_tufte(base_size = 16) +
  xlab("Coefficient") + ylab("Estimate") +
  theme(legend.title  = element_blank()) 

ggsave(filename = "Memo/images/06-05_minn_franklin_DiD.png",
       franklin_did_plot,
       width = 11, height = 8.5, units = "in", device = "png",
       scale = .6)

franklin_retail_its <- agg_its_analysis(df_its = minn_corridor,
                                        group = 2, endyear = 2011)

franklin_retail_tbl <- agg_trend_table(minn_corridor, 2) %>% 
  filter(Type == "improvement" & !is.na(year))

franklin_retail_tbl$year <- as.Date(franklin_retail_tbl$year, "%Y")
rectangle <- data.frame(xmin = as.Date(c("01-01-2011")),
                        xmax = as.Date(c("31-12-2015")),
                        ymin = -Inf, ymax = Inf)

franklin_its_retail <-  ggplot(data = franklin_retail_tbl, 
                               aes(x = year, y = CNS07)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  theme_tufte(base_size = 16) + geom_rect(aes(xmin = as.Date("2011-06-05"), 
                              xmax = as.Date("2015-06-05"),
                              ymin = 0, ymax = 350), fill = "#adff2f",
                              alpha = .03) +
  xlab("Year") + theme(axis.title.y = element_blank())

  
  
  
franklin_its_accom <- ggplot(data = franklin_retail_tbl, 
                             aes(x = year, y = CNS18)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  theme_tufte(base_size = 16) + geom_rect(aes(xmin = as.Date("2011-06-05"), 
                                xmax = as.Date("2015-06-05"),
                                ymin = 0, ymax = 300), fill = "#adff2f",
                            alpha = .03) +
  xlab("Year") + theme(axis.title.y = element_blank())

ggsave(filename = "Memo/images/06-05_minn_franklin_retailITS.png",
       franklin_its_retail, width = 11, height = 8.5, units = "in", 
       device = "png", scale = .6)

ggsave(filename = "Memo/images/06-05_minn_franklin_accomITS.png",
       franklin_its_accom, width = 11, height = 8.5, units = "in", 
       device = "png", scale = .6)


franklin_retail_plot <- agg_trend_plot(franklin_retail_tbl,
                                       industry = "Retail", 
                                       corridor_name = "Franklin Ave.",
                                       industry_code = "CNS07",
                                       construct_year = 2011,
                                       end_year = 2012)
