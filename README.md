# Getting and Cleaning Data

## Course Project
This is a solution to the course project in the course Getting and Cleaning Data from awesome Johns Hopkins University. (Thank you JHU)

## Data

* You can get the data from you can obtain it from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* You can get a description of the data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## How to use run_analysis.R

1. Make sure that you get the right data (you can obtain it from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

2. Unzip the data and make sure to set the working directory in run_analysis.R to the parent directory of where
you unzipped the data.

3. Simply run the script.


## What the script does
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In the end the result from step 5 is saved to disk in form of a file namned 'newTidyDataSet.txt'

## Data Transformations
Read the CodeBook.md file for further information.
