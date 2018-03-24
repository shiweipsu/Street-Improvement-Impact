if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, purrr,glue, ggthemes, ggplot2, lubridate, dplyr)


#LEHD Corridor Comparisons-----

employ_ratio_test <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)

corridor_t <- corridor_df %>% mutate(Retail=CNS07,
                                     Food_Accom=CNS18,
                                     Business = CNS07 + CNS18,
                                     Service = CNS07 +  CNS12 + CNS14 + CNS15 + CNS16 + CNS17 + CNS18 + CNS19,
                                     ratio1 = Business/Service)
return(corridor_t)  
}

# Definition of Service is from EPA Smart Location Database, 5-tier employment classification scheme, adding retail, service, and entertainment

growth_rate <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)
  
corridor_grouped_df <- corridor_df %>%  group_by(Name, year) %>% 
  summarise_if(is.numeric, sum) %>% 
  ungroup() %>% 
  mutate(Retail = CNS07,
         Food_Accom = CNS18,
         Business = CNS07 + CNS18,
         Service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + 
           CNS17 + CNS18 + CNS19,
         Service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19,
         ratio1 = Business/Service1,
         ratio2 = Business/Service2) %>% 
  ungroup() %>% group_by(Name) %>% 
  mutate(biz_growth = Business/lag(Business),
         service_growth1 = Service1/lag(Service1),
         service_growth2 = Service2/lag(Service2))

return(corridor_grouped_df)

}


#Sales Tax Corridor Comparisons------





#QCEW Corridor Comparisons-------



#Aggregated trend plots

make_agg_trend_table <- function(df, group, construct_year) {
  
  #prepare tables for plotting
  df <- as.data.frame(df, stringsAsFactors = FALSE) %>% select(-geometry)

  df <- df %>% filter(Group == group) %>%
    mutate(business = CNS07 + CNS18)
  

  df_agg <- df %>% group_by(year, Type) %>%
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business))
  
  base_year <-  df_agg %>% filter(year == as.character(construct_year)) %>% 
    select(CNS07_base = CNS07, CNS18_base = CNS18, business_base = business, Type, year)
  
  
  df_plot <- df_agg %>%  
    left_join(base_year, by = "Type") %>%
    mutate(CNS07_sd = CNS07/CNS07_base*100,
           CNS18_sd = CNS18/CNS18_base*100,
           business_sd = business/business_base*100) %>%
    select(Type, year = year.x, CNS07_sd, CNS18_sd, business_sd) %>% filter(!is.na(CNS07_sd))
  
  return(df_plot)
  
}

make_agg_trend_plot <- function(df_plot, industry, corridor_name, 
                                industry_code = c("CNS07_sd", "CNS18_sd", "business_sd"), 
                                construct_year, end_year) {
  
  df_plot$Type <- factor(df_plot$Type, levels = rev(levels(df_plot$Type)))
  
  #convert year to proper date
  
  df_plot$year <-as.character(paste0(df_plot$year, "-01-01"))
  df_plot$year <- as.Date(df_plot$year, "%Y-%m-%d")
  
  #df_plot$year <- year(df_plot$year)
  
  #prepare construct_year and end_year as a date
  
  construct_date <- as.character(paste0(construct_year, "-01-01"))
  construct_date <- as.Date(construct_date, "%Y-%m-%d")
  
  #construct_date <- year(construct_year)
  
  end_date <- as.character(paste0(end_year, "-01-01"))
  end_date <- as.Date(end_date, "%Y-%m-%d")
  
  #end_date <- year(end_year)
  
  #making the plot
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), shape = Type, group = Type, colour = Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), xmax = as.Date(end_date, "%Y"), ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    geom_rect(aes(xmin = as.Date(end_date, "%Y") + 1, xmax = as.Date("2015-01-01", "%Y"), ymin = -Inf, ymax = Inf),
              fill = "#7cfc00", linetype=0,alpha = 0.03) +
    geom_text(x= construct_date, y = 150,label="Construction",colour="grey40",size = 4, hjust = 0) +
    geom_text(x= end_date, y= 150,label="Post \n construction",colour="grey40",size = 4, hjust = 0) +
    geom_point(size = 3, fill="white") +
    scale_shape_manual(values=c(22,21,21,23))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} Services Employment Comparison: {corridor_name}"), x="Year",y="Employment Index",
         caption = glue("Employment is indexed to {construct_year}")) +
    guides(title = "Street Type")
  
  
  plot(ats_df)
}


