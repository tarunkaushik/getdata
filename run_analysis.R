## The code is used to read data from 8 different text files and calculate mean and standard
## deviation for each variable of the dataset and also mean (or average) of each variable for
## each activity. I'll first define the terms used in data.

## For code to run, following 8 files should be in the working directory
## 1. subject_test.txt
## 2. X_test.txt
## 3. y_test.txt
## 4. subject_train.txt
## 5. X_train.txt
## 6. y_train.txt
## 7. activity_labels.txt
## 8. features.txt


## Terms and meanings:
## 1. Subject : subject refers to a subject on which the device was tested. 
## 2. Activity : an activity refers to the activity subject was performing during measurement
## 3. Features : Names of the variable measured
## 4. Train/Train : Subsets of dataset

## Using read.table function to read data files containing data present in test and train folder.
## Subject_<test/train>.txt contains subject to which the corresponding row in other files belong.
## X_<test/train>.txt contains measurements of features. 
## y_<test/train>.txt contains activity code for corresponding row
## activity_label.txt contains dictionary of activity code
## features.txt contains names of features 

print("Loading test dataset")
subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

print("Loading train dataset")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

print("Loading dataset complete")
print("Merging datset")

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

## Adding activity label of each activity code

y_test$activity <- activity_labels[y_test[,1],2]
y_train$activity <- activity_labels[y_train[,1],2]

## in subject tables setting name of column as subject

names(subject_test) <- "subject"
names(subject_train) <- "subject"

## setting names of features in test and train dataset

names(X_test) <- features[,2]
names(X_train) <- features[,2]

## creating test and train dataset which contains subject, fature values, and activity using cbind

test <- cbind(subject_test,X_test,y_test)
train <- cbind(subject_train,X_train,y_train)

## creating a column dataset to define to which dataset each observation belongs

test$dataset <- "test"
train$dataset <- "train"

## merging dataset test and train and storing in a single dataset data.

data <- rbind(test,train)

## Selecting columns which refer to mean and standard deviation of of variables.
## Using grep first subsetted columns which had mean or std in feature names, and from them removing those which had meanFrequency
## Storing column index in variable mean_std_feature_columns.
## Added 1 to every column index as in dataset data, first column is subject hence index of each feature was added by 1

mean_std_feature_columns <- sort(features[c(grep("mean",as.character(features[,2])),grep("std",as.character(features[,2]))),][which(!grepl("meanFreq",features[c(grep("mean",as.character(features[,2])),grep("std",as.character(features[,2]))),2])),1]+1)

## Sebsetting data, selecting columns which are required, i.e. subject, mean and std features, activity, and dataset

data <- data[,c(1,mean_std_feature_columns,564,565)]

## Altering names of columns using sub.

names(data) <- sub("^f","Frequency_",names(data))
names(data) <- sub("^t","Time_",names(data))
names(data) <- sub("BodyBody","Body",names(data))
names(data) <- sub("Body","Body_",names(data))
names(data) <- sub("Gravity","Gravity_",names(data))
names(data) <- sub("Acc","Accelerometer_",names(data))
names(data) <- sub("Gyro","Gyroscope_",names(data))
names(data) <- sub("Jerk","Jerk_",names(data))
names(data) <- sub("Mag","Magnitude_",names(data))
names(data) <- sub("\\-std\\(\\)","StandardDeviation",names(data))
names(data) <- sub("\\-mean\\(\\)","Mean",names(data))
names(data) <- sub("-X","_X-axis",names(data))
names(data) <- sub("-Y","_Y-axis",names(data))
names(data) <- sub("-Z","_Z-axis",names(data))

## Now since average of all features is to be calculated, we would be needing a matrix of 180 rows 
## and columns equal to number of features subsetted. since there are 30 subjects and each has 6 activity.
## For this creating variable subjectsIndex which contains all subject and activityIndex containg all
## activity and then sorting them.


subjectsIndex <- unique(data$subject)
activityIndex <- unique(data$activity)

activityIndex <- as.character(activityIndex) 

subjectsIndex <- sort(subjectsIndex)
activityIndex <- sort(activityIndex)

## calculating number of rows in final dataset, which would be 180

finaldatasetRows <- length(subjectsIndex)*length(activityIndex)

## Number of columns required would be equal to number of features subsetted, which is equal to number of columns is data - 3
## Subtracted 3 as subject, activity and dataset were also present in data along with features

finaldatasetCols <- ncol(data)-3

## creating a matrix which would contain subject wise activity wise mean of features.
## Setting value to be 0 initially.

meanMatrix  <- matrix(rep(0,finaldatasetRows*finaldatasetCols),finaldatasetRows,finaldatasetCols)

## in final dataset I would use cbind to merge data with subject and activity of each row, hence initialized
## empty vectors to store vale of activity and subject of each row 

subjectOfRow <- rep(0,180)
activityOfRow <- rep("blank",180) 

## Loop within a loop
## Outer loop iterates from 1 to length(subjectsIndex) that is number of times equal to number of subjects
## Inner loop iterates from 1 to length(activityIndex) that is number of times equal to number of activity
## I could have used dplyr package, but in the assignment I wanted to use all the basic functions only.

print("starting loop to create final dataset")

for(i in 1:length(subjectsIndex))
{
	for(j in 1:length(activityIndex))
	{
		#tempMatrix stores data corresponding to a particular subject and activity
		tempMatrix <- data[which(data$subject==subjectsIndex[i] & data$activity==activityIndex[j]),2:(finaldatasetCols+1)]	
		
		## Now in tepmMatrix we have all the observations of a particular subject partaining to particular activity
		## Using sapply to calculating mean of each feature and storing the value in same variable
		tempMatrix <- sapply(tempMatrix,mean)

		## In the dataset, updating the row
		meanMatrix[(i-1)*6+j,] <- tempMatrix

		## Setting subject and activity of the row
		subjectOfRow[(i-1)*6+j] <- subjectsIndex[i]
		activityOfRow[(i-1)*6+j] <- activityIndex[j]
	}	
}

## Converting vectors to data frame

subjectOfRow <- data.frame(subjectOfRow)
activityOfRow <- data.frame(activityOfRow)
meanMatrix <- data.frame(meanMatrix)

## In dataframe averageDataFrame merging the above dataframes to compile in one dataframe
## the subject, activity and mean values 
averageDataFrame <- cbind(subjectOfRow,activityOfRow,meanMatrix)

## Setting names of the columns, first column is subject, second is activity and third onwards, names of features
names(averageDataFrame) <- c("subject","activity",as.character(names(data[,2:67])))
names(averageDataFrame) <- sub("^F","Average_F",names(averageDataFrame))
names(averageDataFrame) <- sub("^T","Average_T",names(averageDataFrame))

## averageDataFrame is the final dataset that we want
## writing the dataset in a file final_data.txt

print("dataset created, writing in file")

write.table(averageDataFrame,file="final_data.txt",row.names = FALSE)

print("Cleaned data written in file final_data.txt")
print("Code executed successfully.")

## Data can be read into R using read.table("final_data.txt",header=T)
## End of code
