## Peer Assignment for 'Getting and Cleaning Data'

This repo is the peer assignment for this [Course](https://www.coursera.org/learn/data-cleaning/).

It contains an R file to clean and merge data that can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

For a detailed description of the result, look at the [CodeBook](CodeBook.md).

### Usage

 1. Load the 'run_analysis.R' file contained in this repo.
 2. point your working directory to the unzipped data.
 3. run 'read_and_tidy_up_data()' and store the resulting data frame.
 4. run 'aggregate_tidy_data(stored_frame)' with the resulting frame of 3. 
 
 ### Performed Task
 The provided script performs the following tasks to clean up the data:
 * Read measures (x_data),activities (y_data) and subject data for test and train set.
 * Name all measures based on the 'features.txt' in the linked data.
 * Extract all columns from the x_data that are means or standard derivations.
 * Label the activities based on 'activity_labels.txt' in the linked data.
 * column-bind subject,activities and measures into one data frame for test and train set. 
 * row-bind resulting data for test and train set into one data frame all data. 
 * for the second data frame, calculate the mean of all measures by 'Subject' and 'Activity'