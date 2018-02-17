library(dplyr)

# This script,run_analysis.R, does the following.

# 1. Merges the training and the test sets into one and creates final datasett.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.


dataDir <- "./data/UCI HAR Dataset"
dataFileTrain <- "/train/X_train.txt"
dataFileTest <- "/test/X_test.txt"
labelFileTrain <- "/train/y_train.txt"
labelFileTest <- "test/y_test.txt"
subjectTrain <- "/train/subject_train.txt"
subjectTest <- "/test/subject_test.txt"
features <- "/features.txt"

features <- "/features.txt"

activities <- "/activity_labels.txt"

source("./helper_run_analysis.R")
source("./helper_run_analysis.R")
data <- merge.data ( dataDir, dataFileTrain, dataFileTest)
dim(data)

l_features <- extract.measures(dataDir,features )

l_features

data_mod <- data %>% select(l_features[[1]]) %>% setNames(l_features[[2]])

dim(data_mod)

head(data_mod)


ref_data <- extract.activity.subject.labels( dataDir, labelFileTrain, labelFileTest,activities,
                                 subjectTrain, subjectTest)

res_data <- cbind(ref_data, data_mod )

head(res_data)

res_data_summarize <- res_data %>% select(-(activity_id)) %>% group_by( activity_name) %>%
  summarize_all( funs( mean))

View(res_data_summarize)


data

head( data)
data %>% group_by(activity_name) %>% summarize( count = n())

activities <- "/activity_labels.txt"

dataFileTest <- "/test/X_test.txt"

dataDir

kk <- system.file( dataDir,dataFileTrain) 

print(kk)

source("./helper_run_analysis.R")
data <- merge.data ( dataDir, dataFileTrain, dataFileTest)
dim(data)

head()

l_features <- extract.measures(dataDir,features )

class(l_features)
l_features


activityNames <- read.table( file.path(dataDir,activities ))
colnames(activityNames) <- c("id", "activity_name")

trainDataLables <- read.table (file.path(dataDir,labelFileTrain))
testDataLables <- read.table(file.path(dataDir,labelFileTest))

combineDataLables <- rbind(trainDataLables, testDataLables)
colnames(combineDataLables) <- "id"

head(combineDataLables)

activity_labels <- merge(combineDataLables,activityNames, by.x = 'id',  by.y = 'id')
head(activity_labels [activity_labels$id == 3, ])


sum( 2, 3))



activity.names( )

file.path(dataDir, dataFileTrain)
trainData <- read.table ( file.path(dataDir, dataFileTrain),header = FALSE,fill= TRUE)
dim(trainData)
dim(labelTrain)
dim(SubjectTrain)

labelTrain <- read.table ( file.path(dataDir,lableFileTrain <- "/train/y_train.txt"), header= FALSE, fill= TRUE)

SubjectTrain <- read.table ( file.path(dataDir,subjectTrain ), header= FALSE, fill= TRUE)

featuresData <- read.table ( file.path(dataDir,features ), header= FALSE, fill= TRUE)
featuresData

col_index <- grep("mean|std",featuresData[,2])
colnames <- grep("mean|std",featuresData[,2], value=TRUE)
colnames 
colnames_sel <- gsub("-mean\\(\\)","-mean", colnames)

grep ( "\\-mean\(\)\-[Yy]",colnames, value=TRUE)

col_index
dim(col_index)
length(col_index)
trainData_mod <- trainData[, col_index]
dim(trainData_mod)
colnames(trainData_mod) <-  colnames_sel

head(trainData_mod)






testData <- read.table ( file.path(dataDir, dataFileTest),header = FALSE,fill= TRUE)
dim(testData)

