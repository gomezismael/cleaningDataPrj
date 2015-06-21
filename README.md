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


## Code book

### activity 

Categorical variable. Categories (levels) : 
1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

### subject

Categorical variable identifying each volunteer taking part in the experiments. The group makes a total of 30 volunteers (levels : 1 to 30). 

### measurements variables

Generally speaking, the features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 

In particular : 

* prefix 't' to denote time
* "Jerk" signals : the body linear acceleration and angular velocity were derived in time
* prefix 'f' to indicate frequency domain signals
* "mean" to indicate mean value
* "std" to indicated standart deviation
* "bodyacc" to denote the body acceleration signal obtained by subtracting the gravity from the total acceleration.
* "bodygyro" to denote the angular velocity vector measured by the gyroscope.

Concerning the units : 

* The linear acceleration variables are in standard gravity units 'g'.
* The angular acceleration variables are in radians/second.

