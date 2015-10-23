# This script assumes that the libraries 'plyr' and 'dplyr' are installed and loaded.
require(plyr)
require(dplyr)
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
features <- read.table("UCI_HAR_Dataset/features.txt", header = FALSE, col.names = c("id", "features"))
data_test <- read.table("UCI_HAR_Dataset/test/X_test.txt", header = FALSE, sep = "", dec = "." ,col.names = features$features, colClasses = "numeric")
data_test_mean_std <- select(data_test, grep("mean\\(\\)|std\\(\\)", features$features))

subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt", header = FALSE, col.names = c("subject"))
activity_test <- read.table("UCI_HAR_Dataset/test/y_test.txt", header = FALSE, col.names = c("activity"))
# add activity to testData
data_test_mean_std <- cbind(activity = activity_test, data_test_mean_std)
# add subject to testData
data_test_mean_std <- cbind(subject = subject_test, data_test_mean_std)

# do the same for train
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt", header = FALSE, col.names = c("subject"))
activity_train <- read.table("UCI_HAR_Dataset/train/y_train.txt", header = FALSE, col.names = c("activity"))
data_train <- read.table("UCI_HAR_Dataset/train/X_train.txt", header = FALSE, sep = "", dec = "." ,col.names = features$features, colClasses = "numeric")
data_train_mean_std <- select(data_train, grep("mean\\(\\)|std\\(\\)", features$features))
data_train_mean_std <- cbind(activity = activity_train, data_train_mean_std)
data_train_mean_std <- cbind(subject = subject_train, data_train_mean_std)

# merge test and train data
data_all_mean_std <- rbind(data_train_mean_std, data_test_mean_std)

## 3. Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("UCI_HAR_Dataset/activity_labels.txt", header = FALSE, col.names = c("activityNumber", "activityName"), colClasses = c("integer", "character"))
data_all_mean_std$activity <- mapvalues(data_all_mean_std$activity, from = activity_names$activityNumber, to = activity_names$activityName)

## 4. Appropriately labels the data set with descriptive variable names.
colnames(data_all_mean_std) <- sub("\\.std(\\.)*", "Std", colnames(data_all_mean_std))
colnames(data_all_mean_std) <- sub("\\.mean(\\.)*", "Mean", colnames(data_all_mean_std))
## 5. From the data set in step 4, creates a second, independent tidy 
##    data set with the average of each variable for each activity and 
##    each subject.
group_by_activity_subject <- group_by(data_all_mean_std, activity, subject, add = TRUE)
summarisedData <- summarise_each(group_by_activity_subject, funs(mean))
print(summarisedData)
