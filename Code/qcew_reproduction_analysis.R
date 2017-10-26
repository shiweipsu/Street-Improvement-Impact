#qcew analysis reproduction for Wei
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(sf, stringr, ggplot2, dplyr)

files <- dir(path = "Data/processed_qcew_NAD83/", full.names = TRUE, pattern = "*.shp")
qcew_list <- lapply(files, st_read)

#bring in stark oak and nw_everett and sw alder----------- 
stark <- st_read("Data/Shapefile/.shp/Stark_Oak_NAD83.shp")

stark_inter <- function(shps) {
  st_intersection(shps, stark)
}

qcew_intersect <- lapply(qcew_list, stark_inter)

corridor_emp <- function(shps, corridor_name) {
  
  shps <- shps %>% filter(str_sub(NAICS, 1, 3) %in% c(441:448,451:454,722))
  if("YR" %in% colnames(shps)) {
    shps$YEAR <- as.character(shps$YR)}
      
  shps <- shps %>% mutate(AVG_EMP = (JAN + FEB + MAR + APR + MAY + JUN + JUL +
                                      AUG + SEP + OCT + NOV + DEC)/12,
                         CORRIDOR = corridor_name) %>% 
    select(NAICS, JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, 
           DEC, AVG_EMP, CORRIDOR, YEAR)
  
      shps$YEAR <- as.character(shps$YEAR)
  
  return(shps)
}

qcew_intersect <- lapply(qcew_intersect, corridor_emp, corridor_name = "Stark_Oak")
qcew_stark <- bind_rows(qcew_intersect)


# nw_Everett --------------------------------------------------------------


nw_ev <- st_read("Data/Shapefile/.shp/NW_Everett.shp")

nw_inter <- function(shps) {
  st_intersection(shps, nw_ev)
}

qcew_nw_ev_inter <- lapply(qcew_list, nw_inter)

qcew_nw_ev_inter <- lapply(qcew_nw_ev_inter, corridor_emp, corridor_name = "NW_Everett")

qcew_nw <- bind_rows(qcew_nw_ev_inter)

# sw alder -------------------------------------------------------------

sw_alder <- st_read("Data/Shapefile/.shp/SW_Alder.shp")

alder_inter <- function(shps) {
  st_intersection(shps, sw_alder)
}

qcew_sw_alder_inter <- lapply(qcew_list, alder_inter)

qcew_sw_alder_inter <- lapply(qcew_sw_alder_inter, corridor_emp, corridor_name = "SW_Alder")

qcew_sw <- bind_rows(qcew_sw_alder_inter)


##t-tests and the like on year over year growth

growth <- function(x) x/lag(x) - 1

stark_tab <- qcew_stark %>% as.data.frame() %>% group_by(YEAR) %>% summarise(AVG_EMP_SUM = sum(AVG_EMP)) %>% 
  mutate_if(is.numeric, funs(growth))

alder_tab <- qcew_sw %>% as.data.frame() %>% group_by(YEAR) %>% summarise(AVG_EMP_SUM = sum(AVG_EMP)) %>% 
  mutate_if(is.numeric, funs(growth))

everett_tab <- qcew_nw %>% as.data.frame() %>% group_by(YEAR) %>% summarise(AVG_EMP_SUM = sum(AVG_EMP)) %>% 
  mutate_if(is.numeric, funs(growth))

t.test(stark_tab$AVG_EMP_SUM, alder_tab$AVG_EMP_SUM)
t.test(stark_tab$AVG_EMP_SUM, alder_tab$AVG_EMP_SUM)

##DiD attempt