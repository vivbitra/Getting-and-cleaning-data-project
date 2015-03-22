# Getting and cleaning data

Vivek Vardhan Bitra

Description

Information about the variables, data and transformations used in the course project

After setting the source directory for the files, read into tables the data located in
1. Import the data from test and train files
features.txt - features
activity_labels.txt -   activitylabels
subject_train.txt  -   subjecttrain
x_train.txt    -   xtrain
y_train.txt   -   ytrain
subject_test.txt   - subjecttest
x_test.txt   -   xtest
y_test.txt  -    ytest
Assign column names and merge to create one data set.

Section 2. Extract only the measurements on the mean and standard deviation for each measurement.

Create a logcal sub vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns.

Section 3. Use descriptive activity names to name the activities in the data set by using gsub function

Merge data subset with the activitylabels table to include the descriptive activity names

Section 4. Appropriately label the data set with descriptive activity names.

Use gsub function for pattern replacement to clean up the data labels.

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
