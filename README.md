This repo explains how all of the scripts work and how they are connected

This R script reads in the raw data provided and does the following tidying:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for 
   each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject.


the tidy variable satisfies the following, making it a tidy data set:
*  Each variable forms a column (mean value of each feature vector element 
   relating to mean or std)
*  Each observation forms a row (observation is a particular subject 
   undergoing a certain activity to produce certain readings)
*  Each observational unit forms a table


To read the tidy dataset into R use this code:
tidy<-read.table("tidy.txt", header=TRUE)