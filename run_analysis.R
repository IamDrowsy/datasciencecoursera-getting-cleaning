library(dplyr)
#Run this function to generate the tidy dataset.
#make sure to set the working directory to the base folder with the data.
read_and_tidy_up_data <- function() {
        test_data <- read_data("test")
        train_data <- read_data("train")
        rbind(test_data,train_data)
}

#Creates the second dataset,
aggregate_tidy_data <- function(tidy_data) {
        tbl <- tbl_df(tidy_data)
        result <- data %>%
                group_by(Subject,Activity) %>%
                summarize_all(funs(mean))
        result
}


#Helper functions

#Reads all data for "test" or "train", extracts the std/mean cols of x, 
#labels activities and cbinds subject,activities and x-data
read_data <- function(test_or_train) {
        #Read X-data
        names <- read_x_names() 
        sanatized_names <- gsub("\\(|\\)","",names)
        x_data <- read_x_data(test_or_train, sanatized_names)
        
        #Extract mean and std variables 
        mean_and_std_names <- grep("mean\\(\\)|std\\(\\)",names)
        x_data <- x_data[,mean_and_std_names]
        
        #Read activity data
        y_data <- read_y_data(test_or_train)
        
        #Read subject data
        subject_data <- read_subject_data(test_or_train)
        
        #Bind everything together
        cbind(subject_data,y_data,x_data)
}

read_subject_data <- function(test_or_train) {
        filename <- file.path(test_or_train,paste("subject_", test_or_train,".txt",sep=""))
        data <- read.delim(filename, col.names = "Subject", header=FALSE)
        data$Subject <- factor(data$Subject)
        data
}

#Reads the activity data and assigns level based on the activity_labels.txt
read_y_data <- function(test_or_train) {
        filename <- file.path(test_or_train,paste("y_", test_or_train,".txt",sep=""))
        data <- read.delim(filename, col.names = "Activity", header=FALSE)
        data$Activity <- factor(data$Activity)
        
        #Read activity labels
        activity_labels <- read.delim("activity_labels.txt", sep = " ", header=FALSE)[,2]
        
        levels(data$Activity) <- activity_labels
        data
}

read_x_names <- function() {
        data <- read.delim("features.txt", sep = " ", header=FALSE)
        data[,2]
}

#Reads the X data of the test or train set.
# test_or_train should be "test" or "train"
# colnames should be the colnames of the result
read_x_data <- function(test_or_train,colnames) {
        filename <- file.path(test_or_train, paste("X_",test_or_train,".txt", sep=""))
        widths <- rep(16,times = length(colnames))
        read.fwf(filename,widths = widths,col.names = colnames)
}

