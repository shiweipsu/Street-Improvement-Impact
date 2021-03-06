if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(glue, ggthemes, ggplot2, lubridate, dplyr)


#LEHD Corridor Comparisons-----

employ_ratio_test <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)

corridor_t <- corridor_df %>% mutate(Retail=CNS07,
                                     Food_Accom=CNS18,
                                     Business = CNS07 + CNS18,
                                     Service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + 
                                       CNS17 + CNS18 + CNS19,
                                     Service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19,
                                     ratio1 = Business/Service1,
                                     ratio2 = Business/Service2)
return(corridor_t)  
}


# Definition of Service is from EPA Smart Location Database, 5-tier employment classification scheme, adding retail, service, and entertainment

growth_rate <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)
  
corridor_grouped_df <- corridor_df %>%  
  mutate(Group=as.factor(Group),
         BuildStart=as.factor(BuildStart),
         BuildEnd=as.factor(BuildEnd)) %>% 
  group_by(Name, year) %>% 
  summarise_each(funs(if(is.numeric(.)) sum(., na.rm = TRUE) else first(.))) %>% 
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
         retail_growth = Retail/lag(Retail),
         food_accom_growth = Food_Accom/lag(Food_Accom),
         service_growth1 = Service1/lag(Service1),
         service_growth2 = Service2/lag(Service2))

return(corridor_grouped_df)

}


#Sales Tax Corridor Comparisons------



#QCEW Corridor Comparisons-------



#Aggregated trend tables and plots---------------------------------------------

agg_trend_table <- function(df, group) {
  
  df <- if(class(df) == "sf") {
    
    df <- as.data.frame(df, stringsAsFactors = FALSE) %>% select(-starts_with("geom"))
    
  } else {
    
    df
  }
  
  df <- df %>% filter(Group == group) %>%
    mutate(business = CNS07 + CNS18)
  
  
  df_plot <- df %>% group_by(year, Type) %>%
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business))
  
  return(df_plot)
  
}

agg_trend_plot <- function(df_plot, industry, corridor_name, 
                                 industry_code = c("CNS07", "CNS18", "business"), 
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
    geom_point(size = 3, fill="white") +
    scale_shape_manual(values=c(22,21,21,23))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} Employment Comparison:\n {corridor_name}"), x="Year",y="Employment",
         caption = "Shaded area represents the construction period") +
    guides(title = "Street Type")
  
  
  return(ats_df)
}

#aggregated trend index tables and plots------------------------------

agg_index_trend_table <- function(df, group, construct_year) {
  
  #prepare tables for plotting
  df <- as.data.frame(df, stringsAsFactors = FALSE)
  df <- df %>% filter(Group == group)
  
  start= construct_year-3
  end=construct_year-1
  
  df <- df %>% 
    mutate(business = CNS07 + CNS18)
  
  df_agg <- df %>% group_by(year, Type) %>%
    summarise(CNS07 = sum(CNS07, na.rm = TRUE),
              CNS18 = sum(CNS18, na.rm = TRUE),
              business = sum(business, na.rm = TRUE))
  
  base_year <-  df_agg %>% filter(year %in% c(start:end)) %>% group_by(Type) %>% 
    summarise(CNS07_base = mean(CNS07), CNS18_base = mean(CNS18), business_base = mean(business))
  
  df_plot <- df_agg %>%  
    left_join(base_year, by = "Type") %>%
    mutate(CNS07_sd = CNS07/CNS07_base*100,
           CNS18_sd = CNS18/CNS18_base*100,
           business_sd = business/business_base*100) %>%
    select(Type, year = year, CNS07_sd, CNS18_sd, business_sd) %>% filter(!is.na(CNS07_sd))
  
  return(df_plot)
  
}

agg_index_trend_plot <- function(df_plot, industry, corridor_name, 
                                industry_code = c("CNS07_sd", "CNS18_sd", "business_sd"), 
                                construct_year, end_year) {
  
  df_plot$Type <- factor(df_plot$Type, levels = rev(levels(df_plot$Type)))
  
  #convert year to proper date
  
  df_plot$year <-as.character(paste0(df_plot$year, "-01-01"))
  df_plot$year <- as.Date(df_plot$year, "%Y-%m-%d")
  
  
  construct_date <- as.character(paste0(construct_year, "-01-01"))
  construct_date <- as.Date(construct_date, "%Y-%m-%d")
  

  end_date <- as.character(paste0(end_year, "-01-01"))
  end_date <- as.Date(end_date, "%Y-%m-%d")
  

  #making the plot
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), 
                                shape = Type, group = Type, colour = Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), 
                  xmax = as.Date(end_date, "%Y"), 
                  ymin = -Inf, ymax = Inf),
                  fill = "#adff2f",linetype=0,alpha = 0.03) +
    geom_point(size = 3, fill="white") +
    scale_shape_manual(values=c(22,21,21,23))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} Employment Comparison:\n {corridor_name}"), x="Year",y="Employment Index",
         caption = glue("Employment is indexed to {construct_year}\n Shaded Area is Construction Period")) +
    guides(title = "Street Type")
  
  
  return(ats_df)
}


# DID ---------------------------------------------------------------------

did_analysis <- function(df_did, group, endyear){
  df_did <- df_did %>% filter(group==Group) %>% 
    mutate(prepost=ifelse(as.numeric(as.character(year))>endyear,1,0),
           business=CNS07+CNS18)
  did_CNS07 <- lm(CNS07~Type + prepost + Type*prepost, data=df_did)
  did_CNS18 <- lm(CNS18~Type + prepost + Type*prepost, data=df_did)
  did_busi <- lm(business ~ Type + prepost + Type*prepost, data=df_did)
  
  did_final <- list(did_CNS07, did_CNS18, did_busi)
  
  return(did_final)
  
  #did_CNS07
  #return(did_CNS18)
  #return(did_busi)
}

did_agg_analysis <- function(df_did, group, endyear){
  df_did <- df_did %>% filter(group==Group) %>% 
    mutate(business=CNS07+CNS18) %>% 
    group_by(Type, year) %>% 
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business)) %>% 
    mutate(prepost=ifelse(as.numeric(as.character(year))>endyear,1,0))
 
   did_CNS07 <- lm(CNS07~Type + prepost + Type*prepost, data=df_did)
  did_CNS18 <- lm(CNS18~Type + prepost + Type*prepost, data=df_did)
  did_busi <- lm(business ~ Type + prepost + Type*prepost, data=df_did)
  
  did_final <- list(did_CNS07, did_CNS18, did_busi)
  
  return(did_final)
  
  #did_CNS07
  #return(did_CNS18)
  #return(did_busi)
}


# ITS ---------------------------------------------------------------------


its_analysis <- function(df_its, group, endyear){
  df_its <- df_its %>% filter(group==Group,Type=="Study" | Type == "improvement") %>% 
    mutate(prepost=ifelse(as.numeric(as.character(year))>endyear,1,0),
           ts_year=as.numeric(as.character(year))-2003,
           business=CNS07+CNS18)
  its_CNS07 <- lm(CNS07~ts_year + prepost + ts_year*prepost + GEOID10, data=df_its)
  its_CNS18 <- lm(CNS18~ts_year + prepost + ts_year*prepost + GEOID10, data=df_its)
  its_busi <- lm(business ~ ts_year + prepost + ts_year*prepost + GEOID10, data=df_its)
  
  its_final <- list(its_CNS07, its_CNS18, its_busi)
  
  return(its_final)
  
}


agg_its_analysis <- function(df_its, group, endyear){
  df_its <- df_its %>% filter(group==Group,Type=="Study" | Type == "improvement" | Type == "Treatment") %>% 
    mutate(business=CNS07+CNS18) %>% 
    group_by(year) %>%
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business)) %>% 
    mutate(prepost=ifelse(as.numeric(as.character(year))>endyear,1,0),
           ts_year=as.numeric(as.character(year))-2003)
    
  its_CNS07 <- lm(CNS07~ts_year + prepost + ts_year*prepost, data=df_its)
  its_CNS18 <- lm(CNS18~ts_year + prepost + ts_year*prepost, data=df_its)
  its_busi <- lm(business ~ ts_year + prepost + ts_year*prepost, data=df_its)
  
  its_final <- list(its_CNS07, its_CNS18, its_busi)
  
  return(its_final)
  
}


# city index table and plot -----------------------------------------------------

city_agg_index_trend_table <- function(df, construct_year) {
  
  if(class(df) == "sf") {
    
    df <- as.data.frame(df, stringsAsFactors = FALSE) %>% select(-geometry)
    
  } else {
    
    df
  }
  
  df <- df %>% mutate(business = CNS07 + CNS18)
  
  
  df_agg <- df %>% group_by(year) %>%
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business)) %>% 
    mutate(Type = "city")
  
  base_year <-  df_agg %>% filter(year == as.character(construct_year)) %>% 
    select(CNS07_base = CNS07, CNS18_base = CNS18, business_base = business,  Type)
  
  df_plot <- df_agg %>%  
    left_join(base_year,by="Type") %>%
    mutate(CNS07_sd = CNS07/CNS07_base*100,
           CNS18_sd = CNS18/CNS18_base*100,
           business_sd = business/business_base*100,
           Type = "city") %>%
    select(Type, year, CNS07_sd, CNS18_sd, business_sd) %>% filter(!is.na(CNS07_sd))
  
  return(df_plot)
  
}

city_agg_index_trend_plot <- function(df_plot, industry, corridor_name, 
                                 industry_code = c("CNS07_sd", "CNS18_sd", "business_sd"), 
                                 construct_year, end_year) {
  
  #convert year to proper date
  
  df_plot$year <-as.character(paste0(df_plot$year, "-01-01"))
  df_plot$year <- as.Date(df_plot$year, "%Y-%m-%d")
  
  
  construct_date <- as.character(paste0(construct_year, "-01-01"))
  construct_date <- as.Date(construct_date, "%Y-%m-%d")
  
  
  end_date <- as.character(paste0(end_year, "-01-01"))
  end_date <- as.Date(end_date, "%Y-%m-%d")
  
  
  #making the plot
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), 
                                group = Type, colour = Type, shape=Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), 
                  xmax = as.Date(end_date, "%Y"), 
                  ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    
    geom_point(size = 3, fill="white") +
    scale_shape_discrete(breaks=c("improvement","control","city"))+
    scale_colour_discrete(breaks=c("improvement","control","city"))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} Employment Comparison:\n {corridor_name}"), x="Year",y="Employment Index",
         caption = glue("Employment is indexed to {construct_year}\n Shaded Area is Construction Period")) +
    guides(title = "Street Type") 
  
  return(ats_df)
}

city_agg_index_trend_one_control_plot <- function(df_plot, industry, corridor_name, control_corridor, 
                                      industry_code = c("CNS07_sd", "CNS18_sd", "business_sd"), 
                                      construct_year, end_year) {
  
df_plot <- df_plot %>% 
    mutate(Type = case_when(Type == "improvement" ~ "Treatment",
                            Type == "control" ~ paste0("Control: ", control_corridor),
                            Type == "city" ~ "City"))

df_plot$Type <- factor(df_plot$Type, 
                       levels = c("Treatment", paste0("Control: ", control_corridor), "City"))
  
  #convert year to proper date
  
  df_plot$year <-as.character(paste0(df_plot$year, "-01-01"))
  df_plot$year <- as.Date(df_plot$year, "%Y-%m-%d")
  
  
  construct_date <- as.character(paste0(construct_year, "-01-01"))
  construct_date <- as.Date(construct_date, "%Y-%m-%d")
  
  
  end_date <- as.character(paste0(end_year, "-01-01"))
  end_date <- as.Date(end_date, "%Y-%m-%d")
  
  
  #making the plot
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), 
                                group = Type, colour = Type, shape=Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), 
                  xmax = as.Date(end_date, "%Y"), 
                  ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    
    geom_point(size = 3, fill="white") +
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} Employment Comparison:\n {corridor_name}"), x="Year",y="Employment Index",
         caption = glue("Employment is indexed to {construct_year}\n Shaded Area is Construction Period")) +
    guides(title = "Street Type") 
  
  return(ats_df)
}

#city aggregate employment growth table and chart--------------------

city_agg_trend_table <- function(df) {
  
  #prepare tables for plotting
  
  df <- if(class(df) == "sf") {
    
    df <-as.data.frame(df, stringsAsFactors = FALSE) %>% select(-geometry)
  } else {
    
    df
  }
  
  df <- df %>% mutate(business = CNS07 + CNS18)
  
  
  df_plot <- df %>% group_by(year) %>%
    summarise(CNS07 = sum(CNS07),
              CNS18 = sum(CNS18),
              business = sum(business))
  
  df_plot <- df_plot %>% mutate(Type = "city") %>% 
    filter(!is.na(year)) %>% 
    select(Type, year, CNS07, CNS18, business)
  
  return(df_plot)
  
}

city_agg_trend_plot <- function(df_plot, industry, corridor_name, 
                           industry_code = c("CNS07", "CNS18", "business"), 
                           construct_year, end_year) {
  
  df_plot$Type <- factor(df_plot$Type, 
                         levels = c("improvement", "control", "city"))
  
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
    geom_point(size = 3, fill="white") +
    scale_shape_manual(values=c(22,21, 23))+
    scale_x_discrete(breaks=c(2004,2006,2008,2010,2012,2014,2016)) +
    theme_minimal() +
    labs(title = glue("{industry} Employment Comparison:\n {corridor_name}"), x="Year",y="Employment",
         caption = "Shaded area represents the construction period") +
    guides(title = "Employment Scale")
  
  
  return(ats_df)
}


# plot for distributional analysis


dist_trend_plot <- function(df_plot, demo, corridor_name, cat,
                           demo_code = c("low_inc_perc", "white_perc","black_perc","ameindian_perc", "asian_perc",
                                         "hawaii_perc", "other_perc","hisch_under_perc", "hisch_perc", "col_perc",
                                         "bach_perc","female_perc", "bach_col_perc"), 
                           construct_year, end_year, ylim_low, ylim_high) {
  
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
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(demo_code), shape = Type, group = Type, colour = Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), xmax = as.Date(end_date, "%Y"), ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    geom_point(aes(fill= Type),size=3) +
    scale_shape_manual(values=c(22,21,21,23))+
    scale_fill_manual(values = c("white", "white", "white", "orchid"))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("Percentage of {demo} {cat}:\n {corridor_name}"), x="Year",y="Percentage",
         caption = "Shaded area represents the construction period") +
    guides(title = "Street Type") +
    ylim(ylim_low, ylim_high) +
    theme(legend.position = "bottom")
  
  
  return(ats_df)
}


# trend plot - for nets data
trend_plot <- function(df_plot, industry, corridor_name, 
                       industry_code = c("CNS07", "CNS07_sd", "CNS18", "CNS18_sd","CNS07_pest", "CNS18_pest",
                                         "business", "gross_sales", "business_sd", "sales_sd", "n", "n_sd"),
                       y_lable = c("Employment", "Sales", "Establishments"),
                       index = c("Total", "Indexed","Per Establishment"),
                       unit = c("", "in millions"), index2=ifelse(index=="Indexed",glue("{y_lable} is indexed to the baseline years (3 years pre-construction)"),""),
                       construct_year, end_year, construct_year2, end_year2) {
  
  df_plot$Type <- factor(df_plot$Type, levels = rev(levels(df_plot$Type)))
  
  ##convert year to proper date
  
  df_plot$year <-as.character(paste0(df_plot$year, "-01-01"))
  df_plot$year <- as.Date(df_plot$year, "%Y-%m-%d")
  
  construct_date <- as.character(paste0(construct_year-1, "-07-01"))
  construct_date <- as.Date(construct_date, "%Y-%m-%d")
  
  end_date <- as.character(paste0(end_year-1, "-07-01"))
  end_date <- as.Date(end_date, "%Y-%m-%d")
  
  construct_date2 <- as.character(paste0(construct_year-4, "-07-01"))
  construct_date2 <- as.Date(construct_date2, "%Y-%m-%d")
  
  end_date2 <- as.character(paste0(end_year-2, "-07-01"))
  end_date2 <- as.Date(end_date2, "%Y-%m-%d")
  
  ##making the plot
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), group = Type, colour = Type, shape = Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), 
                  xmax = as.Date(end_date, "%Y"), 
                  ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    
    geom_rect(aes(xmin = as.Date(construct_date2, "%Y"), 
                  xmax = as.Date(end_date2, "%Y"), 
                  ymin = -Inf, ymax = Inf),
              fill = "grey",linetype=0,alpha = 0.03) +
    
    geom_point(size = 3, fill="white") +
    scale_x_date(date_breaks = "2 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} {y_lable} Comparison:\n {corridor_name}"), x="Year", y=glue("{index} {y_lable} {unit}"),
         caption = glue("Gray shaded area is pre-construction period\n Green shaded area is construction period\n {index2}")) +
    guides(title = "Street Type") +
    theme(legend.position = "bottom", legend.justification = "center")
  
  return(ats_df)
}
  
