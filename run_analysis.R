# This script,run_analysis.R, does the following.

# 1. Merges the training and the test sets into one and creates final datasett.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

# check if package installed, if not install package 
# and load in memory
pkg <- installed.packages()[, 'Package']
if (length( pkg[pkg == 'dplyr']) == 0 ){
  install.packages('dplyr')
  library(dplyr)
  print( "dplyr is installed")
}else
{
  print("dplyr is alreday installed")
  library(dplyr)
}


#Assign file names/paths to variables
dataDir <- "./data/UCI HAR Dataset"
dataFileTrain <- "/train/X_train.txt"
dataFileTest <- "/test/X_test.txt"
labelFileTrain <- "/train/y_train.txt"
labelFileTest <- "test/y_test.txt"
subjectTrain <- "/train/subject_train.txt"
subjectTest <- "/test/subject_test.txt"
features <- "/features.txt"
activities <- "/activity_labels.txt"

#Source Helper functions file in 
source("./helper_run_analysis.R")

#Task1 : Merges the training and the test sets into one and creates final dataset
# helper function merge.data is called
data <- merge.data ( dataDir, dataFileTrain, dataFileTest)

#Task2 : Extracts only the measurements on the mean and standard deviation for each measurement
# helper function extract.measures is called
l_features <- extract.measures(dataDir,features )

#Apply feature labels to column headers
data_mod <- data %>% select(l_features[[1]]) %>% setNames(l_features[[2]])

#Get activity, subject and data labels( Train , test) grouped together as one set
ref_data <- extract.activity.subject.labels( dataDir, labelFileTrain, 
                                             labelFileTest,activities,subjectTrain,subjectTest )


#combine ref_data and merge data set( from Task1)                                             
res_data <- cbind(ref_data, data_mod)
res_data <- res_data %>% select(-(activity_id)) #remove additional column activity_id

#Get average of each variable for each activity and each subject
res_data_summarize <- res_data %>% group_by( activity_name, subject_id) %>% summarize_all( funs( mean))
View(res_data_summarize)


#write summarised data set back to file
write.table(res_data_summarize, file.path(dataDir,"/UCI_HAR_Dataset_summarized.txt"),row.names=FALSE)
