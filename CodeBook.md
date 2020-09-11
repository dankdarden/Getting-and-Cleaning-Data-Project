The run_analysis.R script performs the data preparation followed by the 5 steps required in the course project’s definition.

Download the dataset:
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables:
features <- features.txt : 561 rows, 2 columns
activity <- activity_labels.txt : 6 rows, 2 columns
subtest <- test/subject_test.txt : 2947 rows, 1 column
xtest <- test/X_test.txt : 2947 rows, 561 columns
ytest <- test/y_test.txt : 2947 rows, 1 columns
subtrain <- test/subject_train.txt : 7352 rows, 1 column
xtrain <- test/X_train.txt : 7352 rows, 561 columns
ytrain <- test/y_train.txt : 7352 rows, 1 columns

Merge the training and the test sets to create one data set:
xdata (10299 rows, 561 columns) is created by merging xtrain and xtest using rbind().
ydata (10299 rows, 1 column) is created by merging ytrain and ytest using rbind().
subject (10299 rows, 1 column) is created by merging subtrain and subtest using rbind().
mergedata (10299 rows, 563 column) is created by merging subject, ydata and xdata using cbind().

Extract only the measurements on the mean and standard deviation for each measurement:
tidydata (10299 rows, 88 columns) is created by subsetting mergedata, selecting only the subject, code and the measurements on the mean and standard deviation (std) for each measurement columns. 

Use descriptive activity names to name the activities in the dataset:
Code header replaced with Activity
All Acc replaced with Accelerometer
All Gyro replaced with Gyroscope
All BodyBody replaced with Body
All Mag replaced with Magnitude
All columns beginning with f replaced with Frequency
All columns beginning with t replaced Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
finaldata (180 rows, 88 columns) is created by sumarizing tidydata by grouping each subject and activity and measuring the mean of each variable. 

Export FinalData into FinalData.txt file:
Create the FinalData.txt file using the write.table() function.  