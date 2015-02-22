# Getting-and-Cleaning-Data-Project
Damià Valero Bover, Barcelona 22/02/2015.
Project of Coursera course Getting and Cleaning Data
----------------------------------------------------
## Files

In this project, the next files can be found: 
- Code Book: PDF that contains the information of the variables (columns) of the tidydataset.
- Run_Analysis: R file that contains the code used to transform the Human Activity Recognition Using Smartphones Dataset to                     this tidydata set.
- Tidy_data: Text file that contains the output dataset from the Run_Analysis. 


## Code definition
This text will provide information about the resulting dataset named tidydata.txt, and the code used in Run_Analysis.R to extract it. 

First of all, it is assumed that in the working directory there is a folder named Data, which contains the unzipped version of the raw data. The Run_Analysis.R also provides separated sections for each one of the 5 tasks. 

The first step of the code is to set the working directory, then import the next documents: 
- features.txt      : Contains the names of the variables
- X_test.txt        : Contains the measurements of the test
- Y_test.txt        : Contains the labels of the Activities for the test
- Subject_test.txt  : Contains the labels of the Subjects for the test
- X_train.txt       : Contains the measurements of the training
- Y_train.txt       : Contains the labels of the Activities for the training
- Subject_train.txt : Contains the labels of the Subjects for the test

Then, the data is grouped with cbind, for all train datasets, and with rbind grouping first the trest and then the train sets. 
The step 4 is included in this step because in my case it make the project easier. This step is done with the variable "names", which includes "Subject", "Activity", and the variables from the features.txt.

The 2 step uses the function regexpr combined with a logical vector of the variable positions to find if the word "mean", "Mean", and "std" are in the variable names, as it is asked to select only this variables.  

The step 3 changes the numbers of the Activity column to the real names of this activities. 

The step 5 first melt the data taking as id the Subject and the Activity. Then, an index is created with group_by, grouping the Subject, Activity and Measure. Finally, with the summarise function the mean of all this groups are found. 

The data is exported in txt format with row.names=FALSE. 

## Tidydata.txt definition

The data contains the mean value of all variables recorded in the Human Activity Recognition Using Smartphones Dataset. 
There are 30 subjects that took the experiment, performing 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II. The measured variables were 86. 

The idea is to record this mean value for each subject, activity and variable, so the obtained tidydata set will have 30x6x86 number of rows, where each row is an observation of the mean value for each subject, activity and variable. 

The definition of the variables (columns) of the tidy dataset can be found in the CodeBook provided in this folder. 
