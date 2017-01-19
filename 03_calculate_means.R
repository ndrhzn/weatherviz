library(dplyr)

calculate_medians <- function(df) {
  
  medians <- df %>% 
    group_by(month) %>% 
    summarise(median = median(tempm))
  
  densities <- df %>% 
    group_by(month) %>% 
    ggvis::compute_density(x_var = ~tempm)
  
  medians$y = NA
  
  for (i in 1:nrow(medians)) {
    
    bar = medians$median[i]
    
    foo = densities[densities$month == as.character(medians$month[i]), ]
    foo = foo[which.min(abs(foo$pred_ -  bar)), ]
    
    medians$y[i] = foo$resp_
  
  }
  
  return(medians)
  
}

medians_df <- calculate_medians(df)