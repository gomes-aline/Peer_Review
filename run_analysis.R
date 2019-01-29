### Peer Assessment - Getting and Cleaning Data
### Aline Gomes


## Downloading the zip file, unziping it and setting the work directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "dataset.zip")
utils::unzip("dataset.zip")
setwd(".//UCI HAR Dataset")

## Creating train and test variables 
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")

## Adding subjects and activities to the table
train <- cbind(read.table("train/subject_train.txt"),
               read.table("train/y_train.txt"), train)

test <- cbind(read.table("test/subject_test.txt"),
              read.table("test/y_test.txt"), test)

#Changing the names of the columns
colnames(train) <- c("sub", "act",c(1:561))
colnames(test) <- c("sub", "act",c(1:561))


## 1. Merges the training and the test sets to create one data set.
library(dplyr)
mdata <- arrange(merge(test,train, all=TRUE), sub, act)


## 4. Appropriately labels the data set with descriptive variable names.
feat <-t(read.table("features.txt"))
colnames(mdata) <- c("sub", "act",feat[2,])


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mdatasel <- mdata[,grep("(sub|act|mean|std)",names(mdata))]


## 3. Uses descriptive activity names to name the activities in the data set
act_list <- read.table("activity_labels.txt")
for (i in 1:nrow(act_list)){
  mdatasel$act <- gsub(i,act_list[i,2],mdatasel$act)
}


## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
tidydata <- mdatasel %>%
        group_by(sub, act) %>%
        summarise_all(mean)

## Creating the txt file
write.table(tidydata, "tidydata.txt", row.names = FALSE)

