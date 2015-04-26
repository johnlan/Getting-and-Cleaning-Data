# Getting-and-Cleaning-Data
# Peer Assessments /Getting and Cleaning Data Course Project 

##Load the dplyr package
##Load the reshape2 package
## 1. Read features data and activity_labels for later usage.
## 2. Read test data to form the myTest data frame. 
## 3. Read train data and then combine test date into myTable01, reformat 
##  myTable01 as table class
## 4. Rename the columns of myTable01 to match with features.
## 5. Apply merge() to add a new column "activity_label" which descriptivly 
##  name the activities in the data set. 
## 6. Apply select() to the data set, which extracts only the measurements on 
##  the mean and standard deviation for each measurement 
## 7. Apply melt(), acast() to creates a second, independent tidy data set 
##  with the average of each variable for each activity and each subject
## 8. Export the second tidy data set with write.table() to "run_analysis (no 
##  caption).txt" and "run_analysis (with captions).txt"
