# Getting-and-Cleaning-Data-Project

<h2>Assignment</h2>

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


<h2>Source Data</h2>

Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.


<h2> Code Explanation</h2>

1. First, all of the files inside the ziped folder are read using the read.table() function.
2. Then the columns are assined more intuitive names using the colnames() function
3. All the train and test files are merged into one, and then the resulting aggregate files are combined into one table called fullData.
4. Then a logical vector is created which includes hte column names that include standard deviation and mean, and the fullData table is updated to only include the logical vector.
5. Using the gsub() function, the column names are made more intuitive.
6. A new txt file is created that includes only the mean of each activity and for each subject.

