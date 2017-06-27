#Codebook

## Variables
Subject - the subject who performed the activity for each window sample. Its range is from 1 to 30
Activity - activity subject was undertaking during measurement
Feature vector elements (all other variables) range from [-1, 1] and include:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 

## Data
Each row in the data contains the subject, activity and feature vector elements.

## Transformations
To clean up the data the following steps were taken:
1. Merging of the training and the test sets to create one data set.

2. Extraction of only the measurements on the mean and standard deviation for each measurement.

3. Changing of activity values to descriptive activity names

4. Variable names changed to be descriptive:
* punctuation removed
* column names have kept the frequency or time domain tag but changed to Freq and Time instead of 'f' and 't'
* gravity capitalised and duplicate 'bodybody' phrase change to 'body'

5. From the data set in step 4, I created a second, independent tidy data set with the average of each variable for each activity and each subject.