# Code Book of run_analysis.R

## Terms and meanings:

Following are the terms used
* Subject : subject refers to a subject on which the device was tested.
* Activity : an activity refers to the activity subject was performing during measurement
* Features : Names of the variable measured
* Train/Train : Subsets of dataset

## Features of raw data

### Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

### Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

## New variables and additional transformations 

### Variables

During the code, I created following variable, most of which are used only for interim calculations and assignments.

* activity_labels: contains names of activities read from file
* features: contains names of features read from file
* X_test: stores feature values of test read from file
* X_train: stores feature values of train read from file
* y_test: stores activity of test read from file
* y_train: stores activity of train read from file
* subject_test: stores subject list of test read from file
* subject_train: stores subject list or train read from file
* test: dataset that contains all observations of test dataset
* train: dataset that contains all observations of train dataset
* data: final dataset that contains all the observations
* statistics: stores overall mean and standard deviation of every feature, as asked in question
* finaldatasetRows: number of rows in final dataset
* finaldatasetCols: number of columns in final dataset
* meanMatrix: temparary matrix in which mean of all features is stored during loop
* i: subject iterator
* j: activity iterator
* tempMatrix: temprary matrix which contains all observations of a particular activity of a subject
* activityIndex: stores all unique activities of data, sorted
* subjectsIndex: stores all unique subject of data, sorted
* activityOfRow: stores activity of each row of final data set
* subjectOfRow: stores subject of each row of final data set
* averageDataFrame: final dataset, containing mean of every feature for every activity of every subject

### Transformations

Following were the final dataset and the way they were calculated

#### averageDataFrame:
It calculates the mean of all raw features separately for each subject, separately for each activity.
First all the data is read and loaded into R from text files.
Data of different data set, test and train is labelled with feature names, subject, and activity.
Then the two dataset, test and train are merged together.
Hence now in one table we have all the data.
For calculating average of each feature for every activity of every subject,
first observations for each unique set of subject and activity is subsetted.
For the subset mean of each feature is calculated and stored in a temporary matrix.
Once data for each subset is stored in the matrix, the final dataframe is created and labelled properly with feature names, subject ID and activity.
Data is then written on a text file.

#### statistics:
In the code, mean and standard deviation of each feature for entire dataset is also calculated after test and train dataset were merged.
Statistics is then labelled with feature names and rows are named, mean and SD.
This is interim variable created and is not stored in text file.


## Structure of code
### Reading from file
Using read.table function to read data files containing data present in test and train folder.
Subject_<test/train>.txt contains subject to which the corresponding row in other files belong.
<test/train>.txt contains measurements of features.
y_<test/train>.txt contains activity code for corresponding row
activity_label.txt contains dictionary of activity code
features.txt contains names of features

### Merging, arranging, and labeling data
Added activity label of each activity code using activity_labels
set name of column as subject in subject_test and subject_train
Set names of features in X_test and X_train dataset using features
Created test and train dataset which contains subject, fature values, and activity using cbind
Created a column dataset to define to which dataset each observation belongs, assigning "test" and "train" as values
Merged dataset test and train and storing in a single dataset data
This is the final dataset that contains all the data required to be merged.

### Mean and standard deviation of all features of all observations
Created dataset statistics which contains mean and standard deviation of all the features
Calculated using sapply and merged using rbind
Set mean and SD as names of the rows.

### Subect wise activity wise means of features
Now since average of all features was to be calculated, a matrix of 180 rows and 561 columns was needed
Since there are 30 subjects having 6 activities and each has 561 features.
For this created variable subjectsIndex which contains all subject and activityIndex containg all activity and then sorted them.
Calculated number of rows in final dataset, which would be 180 and stored in finaldatasetRows

## Temprary variables for using in loop
Created a matrix, meanMatrix which would contain subject wise activity wise mean of features.
Set value of all cells to be 0 initially.
In final dataset cbind would be used to merge data with subject and activity of each row, hence initialized
empty vectors to store vale of activity and subject of each row

###Loop within a loop
Outer loop iterates from 1 to length(subjectsIndex) that is number of times equal to number of subjects
Inner loop iterates from 1 to length(activityIndex) that is number of times equal to number of activity
Srored all the observations of a particular subject partaining to particular activity in tempMatrix
Used sapply to calculating mean of each feature and storing the value in same variable tempMatrix
In the dataset meanMatrix, updated the corresponding row
Set subject and activity of the row in subjectOfRow and activityOfRow respectively

### Final clean dataset as required
Converted vectors,subjectOfRow and activityOfRow, and matrix, meanMatrix, to data frame
In dataframe averageDataFrame merged the above dataframes to compile in one dataframe
Set names of the columns, first column is subject, second is activity and third onwards, names of features

### Clean data in file
averageDataFrame is the final dataset that we want
Wrote the clean dataset in a file final_data.txt
Data can be read into R using read.table("final_data.txt",header=T)

~ End of file ~

