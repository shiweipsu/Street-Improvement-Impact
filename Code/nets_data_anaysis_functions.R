# NETS data analysis functions

# agg index plot

trend_plot <- function(df_plot, industry, corridor_name, 
                                 industry_code = c("CNS07", "CNS07_sd", "CNS18", "CNS18_sd","CNS07_pest", "CNS18_pest",
                                                   "business", "gross_sales", "business_sd", "sales_sd", "n", "n_sd"),
                                 y_lable = c("Employment", "Sales", "Establishments"), index = c("Total", "Indexed","Per Establishment"),
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
  
  ats_df <- ggplot(df_plot, aes(x = year, y = get(industry_code), shape = Type, group = Type, colour = Type)) + 
    geom_line()  +
    geom_rect(aes(xmin = as.Date(construct_date, "%Y"), xmax = as.Date(end_date, "%Y"), ymin = -Inf, ymax = Inf),
              fill = "#adff2f",linetype=0,alpha = 0.03) +
    geom_point(size = 3, fill="white") +
    scale_shape_manual(values=c(22,21,21,21,21))+
    scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
    theme_minimal() +
    labs(title = glue("{industry} {y_lable} Comparison:\n {corridor_name}"), x="Year",y=glue("{index} {y_lable}"),
         caption = "Shaded area represents the construction period") +
    guides(title = "Street Type") +
    theme(legend.position = "bottom", legend.justification = "center")
  
  
  return(ats_df)
}
