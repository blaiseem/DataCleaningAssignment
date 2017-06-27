#This R script reads in the raw data provided and does the following tidying:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for 
#   each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

##########
##0. Required Packages
##########

library(dplyr)


##########
##0. Reading Data
##########

#Parameter to toggle reading in all rows or a selection
allrows=-1 #-1 to input all rows, +1 for not all rows


#Reading the train and test features in
features_train<-read.table("Dataset\\UCI HAR Dataset\\train\\X_train.txt", sep="",nrows=100*allrows)
features_test<-read.table("Dataset\\UCI HAR Dataset\\test\\X_test.txt", sep="",nrows=100*allrows)

#Reading the train and test subject data in
subject_test<-read.table("Dataset\\UCI HAR Dataset\\test\\subject_test.txt", sep="",nrows=100*allrows)
subject_train<-read.table("Dataset\\UCI HAR Dataset\\train\\subject_train.txt", sep="",nrows=100*allrows)

#Reading the train and test activity data in
activity_train<-read.table("Dataset\\UCI HAR Dataset\\train\\y_train.txt", sep="",nrows=100*allrows)
activity_test<-read.table("Dataset\\UCI HAR Dataset\\test\\y_test.txt", sep="",nrows=100*allrows)

#Reading feature labels in
feature_names<-read.table("Dataset\\UCI HAR Dataset\\features.txt", sep="")

##########
##1. Merging Data
##########


#row binding test and train data sets
features<- rbind(features_train, features_test)
activity<- rbind(activity_train, activity_test)
subjects <-rbind(subject_train, subject_test)

#labelling columns of each dataset
names(features)<- feature_names$V2; names(activity)<- "activity"; names(subjects)<- "subject"

#column binding X, y, subject data together
data<-cbind(subjects, activity, features)


##########
##2. Extracting mean and std features
##########


#Removing features not relating to mean or standard deviation
#I included all columns with mean or std in the title rather than dropping 
#columns such as FreqMean
data<-data[grep("mean|Mean|std|Std|activity|subject", names(data))]

##########
##3. Adding descriptive names for activity data
##########

#reading activity labels
activity_labels<-read.table("Dataset\\UCI HAR Dataset\\activity_labels.txt", sep="")
#naming columns of activity labels dataframe
names(activity_labels)<-c("activity_number","activity")

#replacing activity column numbers in dataframe with labels
data$activity<- activity_labels$activity[data$activity]


##########
##4. Fixing variable labels to be descriptive
##########

## punctuation removed
names(data)<-gsub("-", " ", names(data)) #replace '-' with space
names(data)<-gsub("\\(|\\)", "", names(data), fixed=FALSE, perl=TRUE)#remove brackets
names(data)<-gsub(",", " ", names(data)) #replace , with space

## column names have kept the frequency or time domain tag but changed to Freq 
## and Time instead of 'f' and 't'
names(data)<-gsub("^t", "Time", names(data)) #replace t at start with time
names(data)<-gsub("^f", "Freq", names(data)) #replace f at start with freq
names(data)<-gsub("^anglet", "AngleTime", names(data)) #replace anglet with Angle Time

##gravity capitalised and duplicate 'bodybody' phrase change to 'body'
names(data)<-gsub("gravity", "Gravity", names(data)) #replace gravity with Gravity
names(data)<-gsub("BodyBody", "Body", names(data)) #replace double body with body


##########
##5. New tidy dataset with average of each feature grouped by subject and activity
##########



#summarise data using mean values grouped by subject and activity
tidy<- data %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))

#the tidy variable satisfies the following, making it a tidy data set:
#*  Each variable forms a column (mean value of each feature vector element 
#   relating to mean or std)
#*  Each observation forms a row (observation is a particular subject 
#   undergoing a certain activity to produce certain readings)
#*  Each observational unit forms a table


write.table(tidy, file="tidy.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=TRUE)