getwd()
dataDir <- "./data/"
outcome <- "outcome-of-care-measures.csv"
hospital <- "hospital-data"


outcomeData <- read.csv (file.path(dataDir, outcome), colClasses = 'character'  ,fill=TRUE )
str( outcomeData)
head(outcomeData)
names(outcomeData)
outcomeData[,11] <- as.numeric(outcomeData[,11])

hist(outcomeData[,11])

min(outcomeData[,11], na.rm= TRUE)

source ("./best.R")
best(dataDir, outcome, "TX", "heart attack")
any(outcomeData$State == "TX")

state <- "TX"

colname <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"

outcomeData[, colname] = as.numeric( outcomeData[, colname])

value <- min(outcomeData[, colname], na.rm= TRUE)
value

outcomeData %>% select(State, !!colname ) %>% group_by ( State) %>%
  summarize(min(colname, na.rm = TRUE))

  filter(!!colname <= value)

%>% filter ( State == state) %>% 
  filter_(.dots = list(colname) <=  4)

ll <- list("Hospital.Name", "State", colname)

colname_quo = enquo(colname)

%>% filter( Sate == state ) %>% 
  filter_( colname <= min(colname , na.rm = TRUE))


