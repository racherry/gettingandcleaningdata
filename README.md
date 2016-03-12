# Getting and Cleaning Data Assignment
This assignment uses  data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" which measures 561 motion parameters from a Samsung Galaxy II cell phone while the subjects in the study do six different activities.  The output of this script produces a tidy data set of the calculated mean and standard deviation columns in the original data and provides the means of those columns grouped and arranged by subect and activiity

# run_analysis.R
This script does the following
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Script Process
* Zipped file is downloaded and files are extracted
* All relevant data files are read in using read.table
* Columns which contain mean and standard deviation measures are identifed (meanstdcolumns)
* Test and Training data are merged using rbind
* the merged data is subsetted by meanstdcolumns
* Subject and activity columns are prepended using cbind
* column names are changed to be more descriptive and user friendly - all are converted to lower case and all punctuation is removed
* the activity column is changed from numeric code to character for clarity
* means of each column are calculated and grouped by subject and activity
* the tidy data set is output as text file


