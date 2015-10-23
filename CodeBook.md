Course Project for the Coursera course "Getting and Cleaning Data"

## Project Description
The task was to extract the mean values of a given data set.
The data set was given here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Study design and data processing

###Collection of the raw data
The raw data was downloaded and unzipped.

###Notes on the original (raw) data
The original dataset consists of several files which a basically split in to the
'test data' and 'training data'.
The downloaded data set has also a README.txt file which explains in detail
all the available files and variables.

##Creating the tidy datafile

###Guide to create the tidy data file
To create the tidy data set do the following steps:
 - Download the zip file
 - Unzip the zip file
 - Rename the main folder to 'UCI_HAR_Dataset'
 - Make sure the folder is in the R working directory
 - Run the R script 'run_analysis.R'. The script assumes that the libraries
  'plyr' and 'dplyr' are installed and loaded.

###Cleaning of the data
The script reads in the different data sets and merges them into one big file.
Only the 66 values for 'mean' and 'std' (standard deviation) are taken into account.
The summary file consists of means for all the mean and std values for each
activity for each subject.
