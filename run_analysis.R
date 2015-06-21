############# STEP 0  : LIBRARIES

library(dplyr)
library(tidyr)

######################
############# STEP 1  : CREATE ONE DATASET
######################


## Identify variables
# read input raw txt
features = read.table("features.txt", sep = " ")
# select column with names
features = as.character( features[,2] ) # it has many non-unique names. Only 477 r unique


## Test dataset : read fixed with format file and assign corresponding colnames
# specify classes
my.classes = rep("numeric", length(features))


X.train =  read.table("train/X_train.txt",
                    skip=0,
                    sep="",
                    colClasses = my.classes,
                    col.names = features,
                    comment.char = ""
                    )

subject.train = read.table("train/subject_train.txt",
                    skip=0,
                    sep="",
                    colClasses = "integer", # better than factor for step 5
                    col.names = "subject",
                    comment.char = ""
                    )

activity.train = read.table("train/y_train.txt",
                    skip = 0,
                    sep = "",
                    colClasses = "factor",
                    col.names = "activity",
                    comment.char = ""
                    )



X.test =   read.table("test/X_test.txt",
                    skip=0,
                    sep="",
                    colClasses = my.classes,
                    col.names = features,
                    comment.char = ""
                    )

subject.test =  read.table("test/subject_test.txt",
                    skip=0,
                    sep="",
                    colClasses = "integer", # better than factor for step 5
                    col.names = "subject", 
                    comment.char = ""
                    )

activity.test = read.table("test/y_test.txt",
                    skip = 0,
                    sep = "",
                    colClasses = "factor",
                    col.names = "activity",
                    comment.char = ""
                    )

# merge columns

train = cbind(X.train, subject.train)
train = cbind(train, activity.train)

test = cbind(X.test, subject.test)
test = cbind(test, activity.test)

# merge rows

dataset = rbind(train, test)

# create tbl
dataset = tbl_df(dataset)

## clean the workspace (memory)
# list of variables in memory
variables = ls()
# remove all varibles, except the resulting final dataset
rm(list = variables[variables!="dataset"])


######################
############# STEP 2  : EXTRACT VARIABLES MEAN | STD
######################

# by means of dplyr and regex : select all vars with mean or std in them
dataset = select(dataset, matches("[Mm]ean|[Ss]td"), subject, activity)


######################
############# STEP 3  : ACTIVITY LABELS
######################

# import levels and labels
actlabels = read.table("activity_labels.txt",
                    skip = 0,
                    sep = "",
                    colClasses = "character",
                    col.names = c("level","label"),
                    comment.char = ""
                    )

# set labels for levels
dataset$activity = factor(dataset$activity, levels=actlabels$level, labels=actlabels$label)


######################
############# STEP 4  : VARIABLE NAMES
######################

# get original names
original.names = names(dataset)

# remove caps
nocaps.names = tolower(original.names)

# remove dots
nodots.names = gsub("\\.", "", nocaps.names)

# assign new names
names(dataset) = nodots.names


######################
############# STEP 5  : INDEPENDENT DATASET W/AVE BY ACT / SUBJ
######################

# establish activity and subject as grouping variable; then apply mean to the rest
resume = dataset %>%
         group_by(activity, subject) %>%
         summarise_each(funs(mean))

# output to txt file 
write.table(resume, file="final.txt", row.name=FALSE)
