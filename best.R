
library(dplyr)


best <- function(data.dir, file.path, state, outcome){
  # read outcome data
  outcomeData <- read.csv( file.path(data.dir, file.path), colClasses = "character", fill = TRUE)
  
  try(if ( !any(outcomeData$State == state)) stop ( "invalid state") )
  
  v_possible_coutcome <- c("heart attack", "heart failure", 'pneumonia')
  
  try ( if( !any( v_possible_coutcome == outcome)) stop("invalid outcome") )
 
  if ( outcome == 'heart attack'){
    colname <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }else if( outcome == 'heart failure'){
    colname <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }else {
    colname <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  print ( colname)
  
  outcomeData[, colname] = as.numeric( outcomeData[, colname])
  
  outcome %>% select(Hospital.Name, State,colname) %>% filter( Sate == state ) %>%
  
}
  
