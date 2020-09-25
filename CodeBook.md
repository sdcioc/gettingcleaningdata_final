#Variables
1. data_folder 
String
The name of the folder where data is.
2. train_folder_path
String
Path in the presented OS (Operating System) for train data folder
3. test_folder_path
String
Path in the presented OS (Operating System) for test data folder
4. features_file_path
String
Path in the presented OS (Operating System) for features files
It contains the indexes and columns names for the features
from data
5. activity_file_path
String
Path in the presented OS (Operating System) for activity files
It contains 2 columns: the value presented in data and the correspondent Label
6. subject_train_file_path
String
Path in the presented OS (Operating System) for subject file in train data folder
It contains the subject index for which the data was recorded
7. features_train_file_path
String
Path in the presented OS (Operating System) for features file in train data folder
It contains the the recorded data
8. activity_train_file_path
String
Path in the presented OS (Operating System) for features file in train data folder
It contains the the activity value for which the data was recorded
9. subject_test_file_path
String
Path in the presented OS (Operating System) for subject file in test data folder
It contains the subject index for which the data was recorded
10. features_test_file_path
String
Path in the presented OS (Operating System) for features file in test data folder
It contains the the recorded data
11. activity_test_file_path
String
Path in the presented OS (Operating System) for features file in test data folder
It contains the the activity value for which the data was recorded
12. write_file_path
String
Path in the presented OS (Operating System) for the file where data is written
13. features_cols
data.frame 561x2
The features recorded in data. It has 2 columns:
First column - index of column in the features data
Second column - The name of the column in features data
14. activity_labels
data.frame 6x2
The activities reacorded in data. It has 2 columns:
First column - value of activity in data
Second column - The name of the activity
15. meanstd_col_indexes
list of integers 66X1
Indexs of the columns that represent  measurements on the mean and standard
deviation for each measurement
16. meanstd_col_names
list of strings 66X1
Names of the columns that represent  measurements on the mean and standard
deviation for each measurement
17. train_subject_data
data.frame 7352x1
Data frame that contains the subject id for which the train data was recorded
18. train_features_data
data.frame 7352x561
The train data recorded for the 561 features
19. train_activity_data
data.frame 7352x1
contains the activity value for every train data recorded
20. train_data
data.frame 7352x68
The train data contains Subject, Activity  and the columns that represent
measurements on the mean and standard deviation for each measurement (66)
21. test_subject_data
data.frame 2947x1
Data frame that contains the subject id for which the test data was recorded
22. test_features_data
data.frame 2947x561
The test data recorded for the 561 features
23. test_activity_data
data.frame 2947x1
contains the activity value for every test data recorded
24. test_data
data.frame 2947x68
The test data contains Subject, Activity  and the columns that represent
measurements on the mean and standard deviation for each measurement (66)
25. input_data
data.frame 10299x68
The train and test data concatened in a single variable. 
26. input_data_colnames
list of strings 68x1
The names of the columns in the input data
27. final_data 
data.frame tbl tbl_df grouped_df 11880x4
The data after operations. It has 4 columns. The Subject, Activity,VariableName
and Mean. The Mean contains the value of mean for the variable (column) presented
in column VariableName grouped by Subject and Activity

#Data
The data is presented in two files which describe the data (features and activity)
two folder train and test that contains the data in three files each (subject, features,
activity). "features.txt" contains the index and column names of the features data.
"activity_labels.txt"  contains the value used in data for activity along with
the description of the activity. "train/subject_train.txt" and "test/subject_test.txt"
contains the subject index for which the data was recorded. "train/X_train.txt"
and "test/X_test.txt" contains the data recorded. "train/Y_train.txt" and
"test/Y_test.txt" contains the activity for which the data was recorded. The
data has 10299 rows and 561 columns. It was filter to 68 rows. And the final data
contains 11880 rows and 4 columns.

#Transformations
Transformations used on data.
1. Gaining the indexes and names of the columns needed
We read the "features.txt" file in features_cols variable. From them with
select the columns which contains the -mean() or -std() in their names. We
store the indexes in meanstd_col_indexes and names in meanstd_col_names.
2. Gaining the activity values and labels
We read the "activity_labels.txt" file in activity_labels and we set the
first column name as Activity and the second column ActivityLabel.
3. Read the data from train folder
We read the three files from train folder "subject_train.txt", "X_train.txt"
and "Y_train.txt" in train_subject_data, train_features_data, train_activity_data.
4. We concatenate the data from train data with filtering the features that
represents the measurements on the mean and standard deviation for each measurement.
We concatenate train_subject_data, train_activity_data, train_features_data with
only the columns that have the indexes presented in meanstd_col_indexes in variable
train_data. 
5. Read the data from test folder
We read the three files from test folder "subject_test.txt", "X_test.txt"
and "Y_test.txt" in test_subject_data, test_features_data, test_activity_data.
6. We concatenate the data from test data with filtering the features that
represents the measurements on the mean and standard deviation for each measurement.
We concatenate test_subject_data, test_activity_data, test_features_data with only
the columns that have the indexes presented in meanstd_col_indexes in variable
test_data.
7. Merges the training and the test sets to create one data set.
With unite the train_data and test_data in variable input_data.
8.Appropriately labels the data set with descriptive variable names.
With set the names for the columns in a descriptive way using Subject and
Activity for first 2 columns and the names presented in meanstd_col_names for
the other columns representing features.
9. Uses descriptive activity names to name the activities in the data set
We merge input_data with  activity_labels by Activity to have the name of the
activities. We select all columns except the Activity and after we rename the
ActivityLabel in Activity and we store all in input_data. After we factorize
the new Activity column.
10. creates a second, independent tidy data set with the average of each
variable for each activity and each subject.
We group the input_data by Subject and Activity, we summarise and calculate mean
of all variables except the first two. After the data is gather putting the names
of the columns in the new VariableName and the value inside the columns in the new
column called Mean. After we sort ascending the result by the Subject and Activity and
store all in final_data.
11. Write the final_data in the file
