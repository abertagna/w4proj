library(dplyr)
library(data.table)

FastBuildDataFrame <- function(work.dir)
{
    message("Reading test data set...")
    test.data <- fread(file.path(work.dir, "test/X_test.txt"))
    test.act <- fread(file.path(work.dir, "test/y_test.txt"))
    test.subj <- fread(file.path(work.dir, "test/subject_test.txt"))
    test <- cbind(test.data, test.act, test.subj)
    
    message("Reading train data set...")
    train.data <- fread(file.path(work.dir, "train/X_train.txt"))
    train.act <- fread(file.path(work.dir, "train/y_train.txt"))
    train.subj <- fread(file.path(work.dir, "train/subject_train.txt"))
    train <- cbind(train.data, train.act, train.subj)
    
    message("Merging test and train data...")
    res <- rbind(test, train)
    
    message("Setting column names...")
    features <- fread(file.path(work.dir, "features.txt"),
                      stringsAsFactors = FALSE)
    colnames(res) <- c(features[,V2], "act.id", "subject")
    
    message("Done")
    return(res)
}


####### Main #######

work.dir <- getwd()

# 1 ### Merges the training and the test sets to create one data set
dt <- FastBuildDataFrame(work.dir)

# 2 ### Extracts only the measurements on the mean and standard deviation
    ### for each measurement.

dt <- select(dt, act.id, subject, contains("mean()"), contains("std()"))

# 3 ### Uses descriptive activity names to name the activities in the data set
act.labels <- fread(file.path(work.dir, "activity_labels.txt"),
                         col.names = c("act.id", "activity"))
dt <- merge(dt, act.labels, by = "act.id") %>%
    select(-act.id) # Removing (now) unnecessary activity id

# 4 ### Appropriately labels the data set with descriptive variable names
new.head <- gsub("\\-", ".", colnames(dt))
new.head <- gsub("\\(|\\)", "", new.head)
new.head <- sub("^t", "time.", new.head)
new.head <- sub("^f", "freq.", new.head)
colnames(dt) <- new.head

# 5 ### From the data set in step 4, creates a second, independent tidy dat
    ### set with the average of each variable for each activity and each subject

dt.summary <- dt %>%
    group_by(activity, subject) %>%
    summarise_each("mean") %>%
    arrange(activity, subject)

# Renaming columns to reflect new content
new.head <- sub("^time", "avg.time", colnames(dt.summary))
new.head <- sub("^freq", "avg.freq", new.head)
colnames(dt.summary) <- new.head

# Print the output
write.table(dt.summary, file = "dt_summary.txt", row.names = FALSE)
