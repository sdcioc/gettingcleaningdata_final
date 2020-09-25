#Getting and cleaning data final project

#libraries used for the script
library(dplyr)
library(tidyr)

# creating the paths for the files

#the name of the data folder
data_folder <- "UCI HAR Dataset"

#path to train and test folders
train_folder_path = file.path(data_folder, "train")
test_folder_path = file.path(data_folder, "test")

#the path to features and activity files
features_file_path = file.path(data_folder, "features.txt")
activity_file_path = file.path(data_folder, "activity_labels.txt")

#path to data inside the train folder
subject_train_file_path = file.path(train_folder_path, "subject_train.txt")
features_train_file_path = file.path(train_folder_path, "X_train.txt")
activity_train_file_path = file.path(train_folder_path, "Y_train.txt")

#path to data inside test folder
subject_test_file_path = file.path(test_folder_path, "subject_test.txt")
features_test_file_path = file.path(test_folder_path, "X_test.txt")
activity_test_file_path = file.path(test_folder_path, "Y_test.txt")

#path to file where to write the final data
write_file_path = file.path("tidy.txt")

#read the features column names and indexes inside data
#data.frame 561x2 -> 561 x (index, name) 
features_cols <- read.table(features_file_path, header = FALSE)

#read the activities name and correspondent value used in data
# save them with two Columns Activity-for value in data
# and ActivityLabels-for label
# data.frame 6x2 (value, label)
activity_labels <- read.table(activity_file_path, header = FALSE)
colnames(activity_labels) <- c("Activity", "ActivityLabel")

#find the column that contains "-mean()" or "-std()"
# save the indexes and the name of the coloumns
meanstd_col_indexes <- grep("[-](mean|std)[(][)]", features_cols[,2])
meanstd_col_names <- grep("[-](mean|std)[(][)]", features_cols[,2], value = TRUE)

# Read the training data
#7352x1 subject for which data was taken
train_subject_data <-  read.table(subject_train_file_path, header = FALSE)
#7352x561 the features data
train_features_data <- read.table(features_train_file_path, header = FALSE)
#7532x1 the activity done when data was recorded
train_activity_data <- read.table(activity_train_file_path, header = FALSE)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# I concatenate the data on columns like subject, activity, and the features selected
# only for columns that contains the mean and standard deviation for each measurement.
# used the indexes calculated before
train_data <- cbind(train_subject_data, train_activity_data, train_features_data[,meanstd_col_indexes])

#Reading the test data
# doing the same as for train data
test_subject_data <-  read.table(subject_test_file_path, header = FALSE)
#7352x561
test_features_data <- read.table(features_test_file_path, header = FALSE)
#7532x1
test_activity_data <- read.table(activity_test_file_path, header = FALSE)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
test_data <- cbind(test_subject_data, test_activity_data, test_features_data[,meanstd_col_indexes])

#1. Merges the training and the test sets to create one data set.
# make a union for data on rows. Adding test data to train data and
# named the new varaible input_data
input_data <- rbind(train_data, test_data)

#4. Appropriately labels the data set with descriptive variable names.
# I set the columns Subject, Activity and the names precalcualted before for
# measurements on the mean and standard deviation for each measurement.
input_data_colnames <- c("Subject", "Activity", meanstd_col_names)
colnames(input_data) <- input_data_colnames

#3. Uses descriptive activity names to name the activities in the data set
# I join the input data with the activity labels and I select
# all the column except the one with values for activity and after
# I rename the activities labels in Activity and I make it a
# factor column
input_data <- input_data %>%
              merge(activity_labels, by = "Activity") %>%
              select(-Activity) %>%
              rename(Activity="ActivityLabel")
input_data$Activity <- factor(input_data$Activity)
#5 From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

# I take the input data I group by Subject and Activity and I
# summarise all columns and run the mean function vor every column
# except Subject and Activity. After the data is gather in 4 columns
# Subject ACtivity VariableName and Mean (narrow tidy data).
# The last column represent the mean value vor the variable in the 
# variable name column by the Subject and Activity on their columns
final_data <- input_data %>%
              group_by(Subject, Activity) %>%
              summarise(across(everything(), mean)) %>%
              gather("VariableName", "Mean", -Subject, -Activity) %>%
              select(Subject, Activity, "VariableName", "Mean") %>%
              arrange(Subject, Activity)

#write to file so I can submit on assigment
write.table(final_data, file=write_file_path, row.names = FALSE, quote = FALSE)
