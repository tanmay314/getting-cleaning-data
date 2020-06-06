library(dplyr)

#Set working directory on  local device
setwd("C:/Post_School/Coursera/Data_Science/getting-cleaning-data")

#Load all datasets
XtestData <- read.table("./project/test/X_test.txt", header = FALSE, stringsAsFactors = FALSE)

XtrainData <-read.table("./project/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE)

YtestData <- read.table("./project/test/Y_test.txt", header = FALSE, stringsAsFactors = FALSE)

YtrainData <-read.table("./project/train/Y_train.txt", header = FALSE, stringsAsFactors = FALSE)

testSubject <- read.table("./project/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)

trainSubject <- read.table("./project/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)

actLabels <- read.table("./project/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

features <- read.table("./project/features.txt", header=FALSE, stringsAsFactors = FALSE)

featuresList <- unlist(features[,2])

#Add column names
colnames(XtestData) <- featuresList
colnames(XtrainData) <- featuresList
colnames(YtestData) <- c("Activity")
colnames(YtrainData) <- c("Activity")
colnames(testSubject) <- c("Subject")
colnames(trainSubject) <- c("Subject")
colnames(actLabels) <- c("Label","Activity")

#Combine measurements with activity labels 
testData <- cbind(XtestData,YtestData)

trainData <- cbind(XtrainData,YtrainData)

#Combine measurements (+activity labels) with subject
testData <- cbind(testData,testSubject)

trainData <- cbind(trainData,trainSubject)

#Combine test and training data
allData <- rbind(testData, trainData)

#Filter only variables related to mean and standard deviation
meanData <- allData[,grepl("mean()", names(allData), fixed=TRUE)]

stdData <- allData[,grepl("std()", names(allData), fixed=TRUE)]

#Filter activity and subject data
ActSubData <- allData[,562:563]

#Combine mean and standard deviation data
finalData <- cbind(meanData, stdData)

#Change variable names make them more descriptive
varNames <- names(finalData)

varNames <- sub("tBodyAcc", "time-body-accelerometer", varNames)
varNames <- sub("fBodyAcc", "freq-body-accelerometer", varNames)
varNames <- sub("tBodyGyro", "freq-body-gyrometer", varNames)
varNames <- sub("fBodyGyro", "freq-body-gyrometer", varNames)
varNames <- sub("fBodyBodyAcc", "freq-body-body-acceleroment", varNames)
varNames <- sub("fBodyBodyGyro", "freq-body-body-gyrometer", varNames)
varNames <- sub("tGravityAcc", "time-gravity-accelerometer", varNames)
varNames <- sub("fGravityAcc", "freq-gravity-accelerometer", varNames)
varNames <- sub("tGravityGyro", "freq-gravity-gyrometer", varNames)
varNames <- sub("fGravityGyro", "freq-gravity-gyrometer", varNames)
varNames <- sub("Jerk", "-jerk", varNames)
varNames <- sub("jerkMag", "jerk-magnitude", varNames)
varNames <- sub("Mag", "-magnitude", varNames)

colnames(finalData) <- varNames

#Add back activity and subject columns
finalData <- cbind(finalData, ActSubData)

#Merge dataset with activity descriptions
mergedData <- merge(finalData, actLabels, by.x="Activity",by.y="Label",all=TRUE)

#Drop activity labels
mergedData <- mergedData[,-1]

#Group mean of measurements by subject
subjectFinal <- mergedData %>% group_by(Subject) %>% summarise_all(mean)

subjectFinal <- rename(subjectFinal, c("Activity/Subject" = "Subject"))

#Group mean of measurements by activity
activityFinal <- mergedData %>% group_by(Activity.y) %>% summarise_all(mean)

colnames(activityFinal) <- names(subjectFinal)

#Combine subject and activity data
lastData <- rbind(activityFinal, subjectFinal)
