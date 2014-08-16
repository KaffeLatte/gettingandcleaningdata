# Johns Hopkins Data Science Specialization - Getting and Cleaning Data Course Project
#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### 1. Merges the training and the test sets to create one data set.

# set working directory to where data was unzipped
setwd("~/Coursera/DataScienceSpecialization/Getting and Cleaning Data/project/UCI HAR Dataset")

# load features
features <- read.table("features.txt", header=FALSE) 

# load activity labels
activityLabels <- read.table("activity_labels.txt", header=FALSE, col.names=c("activityId","activityType")) 

# creates a R style hash map to easier convert between activityId and activityType later
keys <- activityLabels[,1]
map <- tolower(sub("_", "", activityLabels[,2]))
names(map) <- keys

# load training data
subjectTrain <- read.table("./train/subject_train.txt", header=FALSE, col.names="subjectId") 
xTrain <- read.table("./train/X_train.txt", header=FALSE, col.names=features[,2]) 
yTrain <- read.table("./train/y_train.txt", header=FALSE, col.names="activityId") 

# load test data
subjectTest <- read.table("./test/subject_test.txt", header=FALSE, col.names="subjectId") 
xTest <- read.table("./test/X_test.txt", header=FALSE, col.names=features[,2]) 
yTest <- read.table("./test/y_test.txt", header=FALSE, col.names="activityId") 

# merge training data into a data frame
trainingData <- cbind(yTrain,subjectTrain,xTrain)
# merge test data info data frame
testData <- cbind(yTest,subjectTest,xTest)
# merge the two data sets into one data frame by binding the rows
mergedData <- rbind(trainingData, testData)

### ------------------------------------------------
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# get the column names of the merged data frame
columnNames <- colnames(mergedData);

# extract the columns with mean and std 
columnsToKeep = grepl("mean|std", columnNames)
# Make sure we also get activityId and subjectId
columnsToKeep[1] <- TRUE
columnsToKeep[2] <- TRUE

# subset the data frame so only columns in variable 'columnsToKeep' remain
subsettedData <- mergedData[columnsToKeep==TRUE]

### ------------------------------------------------
### 3. Uses descriptive activity names to name the activities in the data set

# replace activityId with activityType
subsettedData[,1] <- map[subsettedData[,1]]
# change the column name of the first column
colnames(subsettedData)[1] <- "activityType"

### ------------------------------------------------
### 4. Appropriately labels the data set with descriptive variable names.

# replace occurences of unwanted character sequences with wanted ones for activityTypes
for (i in 1:length(colnames(subsettedData))) 
{
  # personally I think camel casing is more readable, but lets stick with the standard provided in video lectures
  colnames(subsettedData)[i] <- gsub("\\()","",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("-","",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("^(t)","time",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("^(f)","frequency",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("^[Bb]ody[Bb]ody|[Bb]ody", "body",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("[Aa]cc","acceleration",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- gsub("([Mm]ag)","magnitude",colnames(subsettedData)[i])
  colnames(subsettedData)[i] <- tolower(colnames(subsettedData)[i])
};

### ------------------------------------------------
### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Does the "blend together" for the data set and applies mean
newTidyDataSet <- aggregate(subsettedData[,3:length(colnames(subsettedData))], 
                            by=list(activityId = subsettedData$activitytype, subjectId=subsettedData$subjectid), mean)

# writes the data table to disk
write.table(newTidyDataSet, "newTidyDataSet.txt", sep="\t", row.names=FALSE)