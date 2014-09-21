## Code Book of run_analysis.R

### Terms and meanings:

Following are the terms used
* Subject : subject refers to a subject on which the device was tested.
* Activity : an activity refers to the activity subject was performing during measurement
* Features : Names of the variable measured
* Train/Train : Subsets of dataset

### Is it a tidy dataset?

Each row contains measurements pertaining to average value of various features for each subject and activity pair.
Each feature mean is stored in a separate colum
First two columns refer to subject and activity
First two column have a unique set of values, which means that there each observation in the dataset is unique in terms of attributes. 

### Features in data

Raw Data
* Time signals were obtained using Accelerometer and Gyroscope.
* Accelaration Signals were separated into Body and Gravity Accelaration signals.
* Body linear acceleration and angular velocity were derived in time to obtain Jerk signals.
* The magnitude of these three-dimensional signals were calculated.
* Fast Fourier Transform was applied to some of these signals to obtain other set of features.
* These signals were measured in X, Y, and Z axes.
* Many functions were further applied on these signals to calculate mean, standard deviation, etc.
* Since all the observations for each feature were normalized, the vaues have no unit, and hence in the final dataset also varibles have no units.

Processed data
* Final dataset here separates out features pertaining to Mean and Standard Deviations of signals.
* For each subject and activity pair, average of observations of select features was calculated.
* In the final dataset, there are 30 subjects, with 6 activity each.

New variables in the final dataset
* Subject and activity can be seen as indeces: reflecting a set of common observations
* Other columns refer to average value of select features.
* Name of the column denotes the kind of feature the column contains. 
* <Time/Frequency> denotes the kind of feature.
* <Body/Gravity> tells whether accelaration component belongs to body or gravity.
* <Accelerometer/Gyroscope> tells which component was used to obtain signal.
* <Mean/StandardDeviation> tells the function applied
* <X-axis/Y-axis/Z-axis> tells the axis to which the feature refers or it has a <Magnitude>
* All features are normalized hence, features have no unit.

Following is the list of column names in the final tidy dataset created:

* subject
* activity
* Average_Time_Body_Accelerometer_Mean_X-axis
* Average_Time_Body_Accelerometer_Mean_Y-axis
* Average_Time_Body_Accelerometer_Mean_Z-axis
* Average_Time_Body_Accelerometer_StandardDeviation_X-axis
* Average_Time_Body_Accelerometer_StandardDeviation_Y-axis
* Average_Time_Body_Accelerometer_StandardDeviation_Z-axis
* Average_Time_Gravity_Accelerometer_Mean_X-axis
* Average_Time_Gravity_Accelerometer_Mean_Y-axis
* Average_Time_Gravity_Accelerometer_Mean_Z-axis
* Average_Time_Gravity_Accelerometer_StandardDeviation_X-axis
* Average_Time_Gravity_Accelerometer_StandardDeviation_Y-axis
* Average_Time_Gravity_Accelerometer_StandardDeviation_Z-axis
* Average_Time_Body_Accelerometer_Jerk_Mean_X-axis
* Average_Time_Body_Accelerometer_Jerk_Mean_Y-axis
* Average_Time_Body_Accelerometer_Jerk_Mean_Z-axis
* Average_Time_Body_Accelerometer_Jerk_StandardDeviation_X-axis
* Average_Time_Body_Accelerometer_Jerk_StandardDeviation_Y-axis
* Average_Time_Body_Accelerometer_Jerk_StandardDeviation_Z-axis
* Average_Time_Body_Gyroscope_Mean_X-axis
* Average_Time_Body_Gyroscope_Mean_Y-axis
* Average_Time_Body_Gyroscope_Mean_Z-axis
* Average_Time_Body_Gyroscope_StandardDeviation_X-axis
* Average_Time_Body_Gyroscope_StandardDeviation_Y-axis
* Average_Time_Body_Gyroscope_StandardDeviation_Z-axis
* Average_Time_Body_Gyroscope_Jerk_Mean_X-axis
* Average_Time_Body_Gyroscope_Jerk_Mean_Y-axis
* Average_Time_Body_Gyroscope_Jerk_Mean_Z-axis
* Average_Time_Body_Gyroscope_Jerk_StandardDeviation_X-axis
* Average_Time_Body_Gyroscope_Jerk_StandardDeviation_Y-axis
* Average_Time_Body_Gyroscope_Jerk_StandardDeviation_Z-axis
* Average_Time_Body_Accelerometer_Magnitude_Mean
* Average_Time_Body_Accelerometer_Magnitude_StandardDeviation
* Average_Time_Gravity_Accelerometer_Magnitude_Mean
* Average_Time_Gravity_Accelerometer_Magnitude_StandardDeviation
* Average_Time_Body_Accelerometer_Jerk_Magnitude_Mean
* Average_Time_Body_Accelerometer_Jerk_Magnitude_StandardDeviation
* Average_Time_Body_Gyroscope_Magnitude_Mean
* Average_Time_Body_Gyroscope_Magnitude_StandardDeviation
* Average_Time_Body_Gyroscope_Jerk_Magnitude_Mean
* Average_Time_Body_Gyroscope_Jerk_Magnitude_StandardDeviation
* Average_Frequency_Body_Accelerometer_Mean_X-axis
* Average_Frequency_Body_Accelerometer_Mean_Y-axis
* Average_Frequency_Body_Accelerometer_Mean_Z-axis
* Average_Frequency_Body_Accelerometer_StandardDeviation_X-axis
* Average_Frequency_Body_Accelerometer_StandardDeviation_Y-axis
* Average_Frequency_Body_Accelerometer_StandardDeviation_Z-axis
* Average_Frequency_Body_Accelerometer_Jerk_Mean_X-axis
* Average_Frequency_Body_Accelerometer_Jerk_Mean_Y-axis
* Average_Frequency_Body_Accelerometer_Jerk_Mean_Z-axis
* Average_Frequency_Body_Accelerometer_Jerk_StandardDeviation_X-axis
* Average_Frequency_Body_Accelerometer_Jerk_StandardDeviation_Y-axis
* Average_Frequency_Body_Accelerometer_Jerk_StandardDeviation_Z-axis
* Average_Frequency_Body_Gyroscope_Mean_X-axis
* Average_Frequency_Body_Gyroscope_Mean_Y-axis
* Average_Frequency_Body_Gyroscope_Mean_Z-axis
* Average_Frequency_Body_Gyroscope_StandardDeviation_X-axis
* Average_Frequency_Body_Gyroscope_StandardDeviation_Y-axis
* Average_Frequency_Body_Gyroscope_StandardDeviation_Z-axis
* Average_Frequency_Body_Accelerometer_Magnitude_Mean
* Average_Frequency_Body_Accelerometer_Magnitude_StandardDeviation
* Average_Frequency_Body_Accelerometer_Jerk_Magnitude_Mean
* Average_Frequency_Body_Accelerometer_Jerk_Magnitude_StandardDeviation
* Average_Frequency_Body_Gyroscope_Magnitude_Mean
* Average_Frequency_Body_Gyroscope_Magnitude_StandardDeviation
* Average_Frequency_Body_Gyroscope_Jerk_Magnitude_Mean
* Average_Frequency_Body_Gyroscope_Jerk_Magnitude_StandardDeviation


### Transformations to raw data

Final dataset created: averageDataFrame
* It calculates the mean of all raw features separately for each subject, separately for each activity.
* First all the data is read and loaded into R from text files.
* Data of different data set, test and train is labelled with feature names, subject, and activity.
* Then the two dataset, test and train are merged together.
* Hence now in one table we have all the data, from which select features are selected.
* For calculating average of each feature for every activity of every subject, observations for each unique set of subject and activity is subsetted.
* For the subset mean, of each feature is calculated and stored in a temporary matrix.
* Once data for each subset is stored in the matrix, the final dataframe is created and labelled properly with feature names, subject ID and activity.
* Data is then written on a text file.

~ End of file ~
