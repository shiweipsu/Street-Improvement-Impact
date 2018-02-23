if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, purrr, dplyr)


#LEHD Corridor Comparisons-----

employ_ratio_test <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)

corridor_t <- corridor_df %>% mutate(Business = CNS07 + CNS18,
                                     Service1 = CNS07 + CNS12 + CNS14 + CNS15 + CNS16 + 
                                       CNS17 + CNS18 + CNS19,
                                     Service2 = CNS07 + CNS12 + CNS14 + CNS17 + CNS18 + CNS19,
                                     ratio1 = Business/Service1,
                                     ratio2 = Business/Service2)
return(corridor_t)  
}


growth_rate <- function(corridor_df) {
  
corridor_df <- as.data.frame(corridor_df)
  
corridor_grouped_df <- corridor_df %>%  group_by(Name, year) %>% 
  summarise_if(is.numeric, sum) %>% 
  ungroup() %>% 
  mutate(Business = CNS07 + CNS18,
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
