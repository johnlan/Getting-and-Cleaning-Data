run_analysis <- function() {
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
  
  ## Read features data, 
  initial <- read.table("UCI HAR Dataset/features.txt", nrows = 100)
  classes <- sapply(initial, class)
  X_features <- read.table("UCI HAR Dataset/features.txt", colClasses = classes)
  
  ## Read activity_labels
  initial <- read.table("UCI HAR Dataset/activity_labels.txt", nrows = 100)
  classes <- sapply(initial, class)
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = classes)
  
  ## Read X_test data
  initial <- read.table("UCI HAR Dataset/test/X_test.txt", nrows = 100)
  classes <- sapply(initial, class)
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = classes)
  
  ## Read y_test data
  initial <- read.table("UCI HAR Dataset/test/y_test.txt", nrows = 100)
  classes <- sapply(initial, class)
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = classes)
  
  ## Read subject_test data
  initial <- read.table("UCI HAR Dataset/test/subject_test.txt", nrows = 100)
  classes <- sapply(initial, class)
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", colClasses = classes)
  
  ## Combine subject_test, y_test, X_test
  myTest <- cbind(subject_test, y_test, X_test)
  ##colnames(myTest)[1] <- "subject"
  
  ## Read X_train data
  initial <- read.table("UCI HAR Dataset/train/X_train.txt", nrows = 100)
  classes <- sapply(initial, class)
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = classes)
  
  ## Read y_train data
  initial <- read.table("UCI HAR Dataset/train/y_train.txt", nrows = 100)
  classes <- sapply(initial, class)
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = classes)
  
  ## Read subject_train data
  initial <- read.table("UCI HAR Dataset/train/subject_train.txt", nrows = 100)
  classes <- sapply(initial, class)
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", colClasses = classes)
  
  ## Merges the training and the test sets to create one data set.
  myTable01 <- tbl_df(rbind(myTest,cbind(subject_train, y_train, x_train)))
  
  ## Appropriately labels the data set with descriptive variable names.
  colnames(activity_labels) <- c("activity_code","activity_label")
  colnames(myTable01) <- c("subject", "activity_code", paste(X_features$V1,X_features$V2, sep = ""))
  
  ## Uses descriptive activity names to name the activities in the data set
  myTable01 <- merge(myTable01,activity_labels,by="activity_code")

  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  myTable01 <- select(myTable01,contains("subject"),contains("activity_label"),contains("mean"),contains("std"),-contains("tBodyAccMean_gravity"),-contains("mean)"))
  
  ## creates a second, independent tidy data set with the average of each variable for each activity and each subject
  ##Load the reshape2 package with install.packages("reshape2")
  myTable02 <- melt(myTable01, id=c("subject", "activity_label"))
  write.table(acast(myTable02, subject~activity_label, mean),"run_analysis (no caption).txt", col.names = FALSE, row.names = FALSE)
  write.table(acast(myTable02, subject~activity_label, mean),"run_analysis (with captions).txt")
  
}
