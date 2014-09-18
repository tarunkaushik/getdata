## ReadMe.md
## Explaination of how the code works.

### Introduction 
The code is used to read data from 8 different text files and calculate mean and standard
deviation for each variable of the dataset and also mean (or average) of each variable for
each activity. I will first define the terms used in data.

For code to run, following 8 files should be in the working directory
* subject_test.txt
* X_test.txt
* y_test.txt
* subject_train.txt
* X_train.txt
* y_train.txt
* activity_labels.txt
* features.txt


### Terms and meanings:
Following are the terms used
* Subject : subject refers to a subject on which the device was tested. 
* Activity : an activity refers to the activity subject was performing during measurement
* Features : Names of the variable measured
* Train/Train : Subsets of dataset

## List of Varaibles
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

