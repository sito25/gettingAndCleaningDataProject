The folder UCI HAR Dataset has to be in the same folder as the script

The script consists in the following steps:

1. Reading data files: (features.txt, activity_labels.txt, subject_test.txt, subject_train.txt, X_test.txt, X_train.txt, y_test.txt and Y_train.txt)
2. Merging test and train datasets creating two dataframes with the data from test and train for measurement and another one for the subjects.
3. Extracts the measurements on the mean and standard deviation for each measurement getting cols whose name contains "mean" or "std".
4. Appropriately labels the data set with descriptive variable names, adding the column names. 
5. Uses descriptive activity names to name the activities in the data set, adding one column "activity" and changing the number so that the activity name appears.
6. Creating a second, independent tidy data set, applying factors to the activity and the subjects. 