############################

## R script for Getting and Cleaning Data Course Project
## Ezekiel Mugendi
## Jan, 7th 2017

## This R script does the following;

# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The Dataset can be downloaded from here;

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## step1: download the file and unzip the folder into your working directory
if(!file.exists("./data")) dir.create("./data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

## step 2:  load data into R.  
## Only the relevant files needed for this assignment has been loaded

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")



## step 3: merge the training and test sets to form one dataset.

traindata <- cbind(subject_train, y_train, x_train)
testdata <- cbind(subject_test, y_test, x_test)
finaldata <- rbind(traindata, testdata)

## step 4: Extracts only the measurements on the mean and standard deviation for each measurement

## subset features names;
featuresName <- features[,2]
datafeatures <- featuresName[grep("mean\\(\\)|std\\(\\)", featuresName)]

## step 5. Use descriptive activity names to name the activities in the data set

colnames(finaldata) <- c("subjectid", "activity", datafeatures)
## step 6. Appropriately labels the data set with descriptive variable names.

names(finaldata)<-gsub("^t", "time", names(finaldata))
names(finaldata)<-gsub("^f", "frequency", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))

## step 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr);
newdata <- aggregate(. ~subjectid + activity, finaldata, mean)
newdata <- newdata[order(newdata$subjectid,newdata$activity),]

write.table(newdata, file = "tidydata.txt",row.name=FALSE)





