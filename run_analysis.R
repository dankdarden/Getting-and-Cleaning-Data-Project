# Load the dplyr library
library(dplyr)

# Verify working directory
getwd()

# Read the data from the UCI HAR Dataset files and assign them to variables
features <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/features.txt")
activity <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/activity_labels.txt")
subtest <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/test/y_test.txt")
subtrain <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("/Users/dankdarden/Desktop/Getting-and-Cleaning-Data-Project/UCI HAR Dataset/train/y_train.txt")

# Merge the datasets
xdata <- rbind(xtest, xtrain)
ydata <- rbind(ytest, ytrain)
subject <- rbind(subtest, subtrain)
mergedata <- cbind(subject, xdata, ydata)

# Extract only the mean and standard deviation of each measurement
tidydata <- mergedata %>% select(subject, code, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set
names(tidydata)[2] = "Activity"
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "Time", names(tidydata))
names(tidydata)<-gsub("^f", "Frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "TimeBody", names(tidydata))
names(tidydata)<-gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "StdDev", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "Angle", names(tidydata))
names(tidydata)<-gsub("gravity", "Gravity", names(tidydata))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
finaldata <- tidydata %>%
        group_by(subject, Activity) %>%
        summarize_all(list(mean = mean))
write.table(finaldata, "FinalData.txt", row.name=FALSE)
