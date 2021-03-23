# Run_analysis.R guide

This file describes the variables, the data, and any transformations or work that can be performed to clean up the data.

# Data collection
Data for this script can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the dataset can be found:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Get data

Initially the scripts downloads the data on wearables for Samsung from a url location as a zip file.
Subsequently it unzips the data to a speciffied directory

### Import training data-sets
X_train <- Training dataset that contains measurements of the accelerometer and gyropcope variables
y_train <- Training dataset that cocntains the activity IDs 
s_train  <- subject IDs for the training dataset

### Import test data-sets
X_test <- Test dataset with the measurements of the accelerometer and gyropcope variables
y_test <- Test dataset that cocntains the activity IDs 
s_test <- subject IDs for the test dataset
          
### Read activity labels data and merge with the y data sets
activity <- descriptive form of the activity IDs
y_train2 <- activity descriptions for the training data
y_test2 <- activity descriptions for the test data       

### Import features from accelerometer and gyroscope signals and use as columne names of the X datasets
feature <- variables names for each measurement

### Combine subject info, activity info and measurements for training and testing data sets
Atrain <- column bind all the information together for the training dataset
Atest  <- column bind all the information together for the test dataset

### Combine the training and testing data together

all_data <- contains all the data which are put togegher with a row binding

### Find mean or std words in the column names and rename the columns
cols <- conatins a vector with the positions of columns to keep

### Convert wide format data to long format
longData <- transform data in long format using "Subjects", "Activity" asa ID variables

### Reshape data into a tidy data-set using dcast

avData <- contains the average value of each measurement for each subject and activity

### write the tidy dataset as a text delimited file

