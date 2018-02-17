##################################################################
title : Codebook.md
author: Atul Kumar Katiyar
date: 2018-02-17
output:
	tidy data set
##################################################################

## Project Description
coursera assignment for course Getting and Cleaning Data

##Steps of data processing
1. Merges the training and the test sets into one and creates final datasett.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with 
    the average of each variable for each activity and each subject.

###Collection of the raw data
Raw data links:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip




##Creating the tidy datafile

###Guide to create the tidy data file
1. Download data set from link below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip it and put it in working directory

3. Map/describe variables as below:
Data Directory : dataDir <- "./data/UCI HAR Dataset"
Data set of Training Data :dataFileTrain <- "./data/UCI HAR Dataset/train/X_train.txt"
Data set of testing Data  :dataFileTest <- "./data/UCI HAR Dataset/test/X_test.txt"
Data set labels for Train data set :labelFileTrain <- "./data/UCI HAR Dataset/train/y_train.txt"
Data set labels for test data set :labelFileTest <- "./data/UCI HAR Dataset/test/y_test.txt"
Data set of subjects pertaining Train data :subjectTrain <- "./data/UCI HAR Dataset/train/subject_train.txt"
Data set of  subjects pertaining Train data :subjectTest <- "./data/UCI HAR Dataset/test/subject_test.txt"
Data set of features <- features <- "./data/UCI HAR Dataset/features.txt"
Data set of activties : activity <-  "./data/UCI HAR Dataset/activity_labels.txt"

4. load helper function by sourcing helper_run_analysis.R script
source("./helper_run_analysis.R")

5.  Generate merge data set from tarining and testing data sets
data <- merge.data ( dataDir, dataFileTrain, dataFileTest)

6. extract features as mentioned in task 2 and apply on data set from step 5
l_features <- extract.measures(dataDir,features )
data_mod <- data %>% select(l_features[[1]]) %>% setNames(l_features[[2]])

7. Get get of subjects, activity labels and labels of Train and test data. 
   combine these kind of reference/metadata and apply to data set from step 6
ref_data <- extract.activity.subject.labels( dataDir, labelFileTrain, 
                                             labelFileTest,activities,subjectTrain,subjectTest )
res_data <- cbind(ref_data, data_mod)
res_data <- res_data %>% select(-(activity_id)) 

8. Summarize data to get summary of variables for each activity and each subject
res_data_summarize <- res_data %>% group_by( activity_name, subject_id) %>% summarize_all( funs( mean))
View(res_data_summarize)

9. #write summarised data set back to file
write.table(res_data_summarize, file.path(dataDir,"/UCI_HAR_Dataset_summarized.txt"),row.names=FALSE)

