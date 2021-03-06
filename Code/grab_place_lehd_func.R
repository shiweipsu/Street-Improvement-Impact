if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(devtools, sf, tigris, glue, dplyr)

options(tigris_class = "sf")
install_github("jamgreen/lehdr")
library(lehdr)

nitc_lehd <- function(years, target_state, target_county, target_place) {
  
  state_lehd <- grab_lodes(state = target_state, year = years, lodes_type = "wac", 
                           job_type = "JT01", segment = "S000",
                           agg_geo = "block",
                           download_dir = glue::glue("Data/{target_state}_lehd"))
  
  place.sf <- places(state = target_state)
  place.sf <- place.sf %>% filter(NAME == target_place)
  
  state_blocks <- if(!is.null(target_county)){
    state_blocks <- blocks(state = target_state, county = target_county)
  } else {
    state_blocks <- blocks(state = target_state)
  }
  
  #place_blocks <- st_intersection(place.sf, state_blocks)
  place_blocks <- st_join(state_blocks, place.sf, left = FALSE)
  
  
  place_lehd <- place_blocks %>% left_join(state_lehd, 
                                           by = c("GEOID10" = "w_geocode"))
  
  place_lehd <- place_lehd %>% select(4:5, 21, 34:84, 86:88)
  
  return(place_lehd)
  
  st_write(place_lehd, glue::glue("Data/{target_place}_lehd.shp"), delete_dsn = TRUE)
  
  
}



nitc_rac <- function(years, target_state, target_county, target_place) {
  
  state_lehd <- grab_lodes(state = target_state, year = years, lodes_type = "rac", 
                           job_type = "JT01", segment = "S000",
                           agg_geo = "block",
                           download_dir = glue::glue("Data/{target_state}_lehd"))
  
  place.sf <- places(state = target_state)
  place.sf <- place.sf %>% filter(NAME == target_place)
  
  state_blocks <- if(!is.null(target_county)){
    state_blocks <- blocks(state = target_state, county = target_county)
  } else {
    state_blocks <- blocks(state = target_state)
  }
  
  #place_blocks <- st_intersection(place.sf, state_blocks)
  place_blocks <- st_join(state_blocks, place.sf, left = FALSE)
  
  
  place_lehd <- place_blocks %>% left_join(state_lehd, 
                                           by = c("GEOID10" = "h_geocode"))
  
  place_lehd <- place_lehd %>% select(4:5, 21, 34:74, 76:78)
  
  return(place_lehd)
  
  st_write(place_lehd, glue::glue("Data/{target_place}_rac.shp"), delete_dsn = TRUE)
  
  
}
