README.md

step1
Download the file from the url provided
Create a working directory where you will the files will be saved.
unzip the dataset into the working directory

step 2
load the relevant data into R.  This will include the training data, test data, features and activity labels

step 3
merge the the training and test sets to form one dataset.  The final data contains a data frame with with all the rows and columns in the training and test sets, including the subject iD.

step 4
Extracts only the measurements on the mean and standard deviation for each measurement using the grep function.

step 5
rename the columns using the names in the activity_labels file, that is subject ID and type of activity performed

step6 
Appropriately labels the data set with descriptive variable names using the gsub function

step 7
From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject using the plyr package.

finally save the new data into a file called tidydata.txt file using the write.table function
 
 
	