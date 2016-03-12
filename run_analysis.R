# Getting and Cleaning Data Assignment

library(dplyr)
library(tidyr)

setwd("~/Desktop/2016 Coursera Data Science/03_Getting and Cleaning Data")
if(!file.exists("./data")){dir.create("./data",showWarnings = TRUE)}
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,"./data/assignment",method = "curl" )
unzip("./data/assignment")

# use read.table for txt files with space separator

## Read in all the files
# Features
allfeatures <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
# Activities
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
# Test data
testdata<- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testactivities<- read.table("./UCI HAR Dataset/test/y_test.txt")
testsubjects<- read.table("./UCI HAR Dataset/test/subject_test.txt")
# Training data
traindata<- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainactivities<- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsubjects<- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Manipulate the columns
# extract features columns with mean or std 
meanstdcolumns <- grep("*[Mm]ean*|*[Ss]td*",allfeatures[,2])

# merge the test and train data
mergedata <- rbind(testdata,traindata)
merge <- mergedata[,meanstdcolumns]

# add the subject and activity columns
mergeactivites <- rbind(testactivities,trainactivities)
mergesubjects <- rbind(testsubjects,trainsubjects)
data <- cbind(mergesubjects,mergeactivites,merge)

# create descriptive column labels
datalabels <- tolower(as.character(allfeatures[meanstdcolumns,2]))
datalabels <- gsub("[[:punct:]]","",datalabels)
labels <- c("subject","activity",datalabels)
names(data) <- labels 
#change the factors in activities to be more descriptive
data$activity <- factor(data$activity, levels = activities[,1], labels = activities[,2])

# a tidy dataset with average of each variable
tidy <- data %>%
  group_by(subject,activity)%>%
  summarise_each(funs(mean))

## write the tidydata file
write.table(tidy, "./tidydata.txt", sep="\t")