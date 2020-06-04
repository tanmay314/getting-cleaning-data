library(dplyr)

setwd("C:/Post_School/Coursera/Data_Science/getting-cleaning-data")

XtestData <- read.table("./project/test/X_test.txt", header = FALSE, stringsAsFactors = FALSE)

XtrainData <-read.table("./project/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE)

YtestData <- read.table("./project/test/Y_test.txt", header = FALSE, stringsAsFactors = FALSE)

YtrainData <-read.table("./project/train/Y_train.txt", header = FALSE, stringsAsFactors = FALSE)

testSubject <- read.table("./project/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)

trainSubject <- read.table("./project/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)

actLabels <- read.table("./project/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

features <- read.table("./project/features.txt", header=FALSE, stringsAsFactors = FALSE)

featuresList <- unlist(features[,2])

colnames(XtestData) <- featuresList
colnames(XtrainData) <- featuresList
colnames(YtestData) <- c("Activity")
colnames(YtrainData) <- c("Activity")
colnames(testSubject) <- c("Subject")
colnames(trainSubject) <- c("Subject")
colnames(actLabels) <- c("Label","Activity")

testData <- cbind(XtestData,YtestData)

testData <- cbind(testData,testSubject)

trainData <- cbind(XtrainData,YtrainData)

trainData <- cbind(trainData,trainSubject)

allData <- rbind(testData, trainData)

meanData <- allData[,grepl("mean", names(allData))]

stdData <- allData[,grepl("std", names(allData))]

ActSubData <- allData[,562:563]

finalData <- cbind(meanData, stdData)

finalData <- cbind(finalData, ActSubData)

mergedData <- merge(finalData, actLabels, by.x="Activity",by.y="Label",all=TRUE)

mergedData <- mergedData[,-1]

subjectFinal <- mergedData %>% group_by(Subject) %>% summarise_all(mean)

activityFinal <- mergedData %>% group_by(Activity.y) %>% summarise_all(mean)
