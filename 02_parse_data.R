library(dplyr)
library(lubridate)

parse_data <- function(directory = "~/R/weatherviz/data") {
  
  files = list.files(directory, full.names = TRUE)
  
  data = data.frame(stringsAsFactors = FALSE)
  
  for (file in files) {
    
    df = read.csv(file, stringsAsFactors = FALSE)
    
    df = df %>% 
      select(date.year:date.min, tempm) %>% 
      mutate(date = paste(date.year, date.mon, date.mday, sep = "-"),
             time = paste(date.hour, date.min, sep = ":"),
             datetime = paste(date, time)) %>% 
      select(date, datetime, tempm)
    
    data = rbind.data.frame(data, df)
    
    
  }
  
  data = data %>% 
    mutate(date = as.Date(date), 
           datetime = as.POSIXct(strftime(datetime)),
           month = month(date, label = TRUE, abbr = FALSE))
  
  data$month = factor(data$month, 
                      levels = levels(data$month),
                      labels = c("січень", "лютий", "березень", "квітень",
                                 "травень", "червень", "липень", "серпень",
                                 "вересень", "жовтень", "листопад", "грудень"))
  
  return(data)
   
}

df <- parse_data()
