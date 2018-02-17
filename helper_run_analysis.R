# This R script defines helper functions for main script run_analysis.R 

check.file <- function(full.file.path){
  #check if file exists and return numeric flag
  # 0 : if file exists , 1 if file doesn't exists
  
  if(file.exists(full.file.path)){
    ret_flag = 0
  }else
    ret_flag = 1
  
  ret_flag
}



merge.data <- function(dir.path, file.path.train, file.path.test){
  #Merge two data sets Training and Test data sets
  #Return combine data set
  
  #combine data directory and file names
  full.file.path.train <- file.path(dir.path, file.path.train)
  full.file.path.test <- file.path (dir.path, file.path.test)

  
  #Check the file paths of train and test data files
  file_exist_flag <- sum( check.file(full.file.path.train ) ,
                          check.file (full.file.path.test ))
  
  if (file_exist_flag > 0 ){
    return("Check location of input directory and files")
  }
  
  #Train Data Frame
  train.data <- read.table(full.file.path.train, header = FALSE, fill = TRUE)
  
  #Test Data Frame
  test.data <- read.table(full.file.path.test, header = FALSE, fill = TRUE) 
  
  #Rowbind Train and Test data sets and return
  combine.data <- rbind( train.data, test.data)
  
}


extract.measures <- function(data.dir, feature.file){
  # Extract features with contain mean and std words in it
  # and retrun list with elements as index of columns and name of columns
  
  full.feature.file = file.path(data.dir, feature.file)
  
  # Check for existance of file and directories
  file_exist_flag = check.file(full.feature.file)
  if(file_exist_flag > 0 ){
    return("Check location of input directory and files")
  }
  
  #Read Mesaure file
  feature.data <- read.table(full.feature.file, header = FALSE, fill = TRUE)
  
  #Filter Feature names contaions "mean" and "std" in names
  feature.filtered.index <- grep("mean|std", feature.data[,2])
  feature.filtered.names <- grep("mean|std", feature.data[,2], value=TRUE)
  
  #Remove special characters "()" from feature names
  feature.filtered.names_mod <- gsub("[()]","", feature.filtered.names)
  
  #Return index and names of features with words mean and std in their names
  list(feature.filtered.index,feature.filtered.names_mod )
}



extract.activity.subject.labels <- function(data.dir, labels.train.file, 
                                            labels.test.file, activity.file, subject.train.file,
                                            subject.test.file){
  # combine activitiy names, subjects and  labels of data( Train and Tets)
  # Return combine dataset of mentioned above elements
  
  #Combine Data directory with files and generate full path
  full.labels.train.file <- file.path(data.dir, labels.train.file)
  full.labels.test.file <- file.path(data.dir, labels.test.file)
  full.activity.file <- file.path(data.dir, activity.file)
  full.subject.train.file <- file.path(data.dir, subject.train.file)
  full.subject.test.file <- file.path(data.dir, subject.test.file)
  
  #check if file exists
  files.exists.flag <- sum( check.file(full.labels.train.file ),
                           check.file(full.labels.test.file ),
                           check.file(full.activity.file ),
                           check.file(full.subject.train.file ),
                           check.file(full.subject.test.file ))
  
  
  if (files.exists.flag > 0 ){
    return("Check location of input directory and files")
    
  }
  
  #Read Subject(vlounters) data of train and test datasets
  subjectTrainData <- read.table(full.subject.train.file,header = FALSE, fill = TRUE )
  subjectTestData <- read.table(full.subject.test.file,header = FALSE, fill = TRUE )
  
  #Read activity labels and assign variable names
  activityNames <- read.table(full.activity.file, header = FALSE, fill = TRUE )
  colnames(activityNames) <- c("activity_id", "activity_name")
  
  
  #Combine Subject data with activity labels for train and test datasets
  trainDataLables <- read.table (full.labels.train.file, header = FALSE, fill = TRUE)
  trainDataLables <- cbind(subjectTrainData ,trainDataLables )
  
  testDataLables <- read.table(full.labels.test.file ,header = FALSE, fill = TRUE )
  testDataLables <- cbind( subjectTestData, testDataLables)
  
  combineDataLables <- rbind(trainDataLables, testDataLables)
  colnames(combineDataLables) <- c("subject_id", "activity_id")
 
  #finally merge activity labels, subjects and data labels ( of train and test data set) 
  activity_subject_labels <- merge(activityNames,combineDataLables, 
                                   by.x = 'activity_id',  by.y = 'activity_id')

}
  

