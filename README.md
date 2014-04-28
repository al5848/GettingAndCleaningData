GettingAndCleaningData
======================

Repository of sources for the data science course getting and cleaning data.

The purpose of this assignment is to learn how to get and clean data from outside sources.

This repository contains the files
1. run_analysis.R
2. CodeBook.md


## run_analysis.R
---------------------------------

This R script files analyze data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and outputs a new tidy data set containing computed average values of each activity and each subject.

To run the scripts the following packages are required:
1. data.table
2. plyr.

In addition, the data obtained from the zip file must be extracted such that the directory structure is as follows:

* --working directory
* ------UCI HAR Dataset
* ----------train
* ----------test
* -------------activity_labels.txt
* -------------features.txt
* -------------features_info.txt
* ------run_analysis.R


The following assumption was made when merging the data sets
1. The data in the the Inertial Signals directory found in both train and test directory, will not be used in the analysis.



## CodeBook.md
----------------------------------

This file stores the definition of the final tidy dataset outputed from run_analysis.R algorithm.
