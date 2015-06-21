# cleaningDataPrj
(Personal) Course Project for the Getting and Cleaning Data course at Coursera, by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD

This repository contains the R script ("run_analysis.R") with the code to obtain the final tidy dataset out of the "raw" dataset proposed, following the instructions of the assignment, .

## How the script works

It starts by loading the dplyr library, whose functions are specially useful for the purposes of this assignment. Then, as stated in the guidelines : 

### STEP 1 : Merges the training and the test sets to create one data set.

* Identifies the features in the dataset
* Reads the measurements corresponding to those features, as well as the corresponding subjects and activities using read.table() with an "optimized" configuration of its parameters. Both for the training and test datasets.
* "Glues" those imported dataset, both in terms of rows and columns, into a single dataset.
* Creates a tbl object (dplyr) out it and cleans memory.

### STEP 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 

Using a regex, all those variables containing "mean" or "std" are selected (no matter the position or initial case of these literals).

### STEP 3 : Uses descriptive activity names to name the activities in the data set

The activity labels are read, then assigned as labels to a (re)factorized activity variable.

### STEP 4 : Appropriately labels the data set with descriptive variable names. 

Caps are lowered and points subtracted of the name of the variables.

### STEP 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Using the group_by and summarize power of the dplyr package, the dataset is easily summarized (taking means) by activity and subject into a tidy dataset, which is finally written to a txt file. 









