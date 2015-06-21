## Description for run_analysis.R

This analysis was applied to human activity recognition data collected using smartphones.
The data was obtained from: 
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">HAR dataset.zip/</a>

<ol>
<li><b>Downloading data</b>: if the file does not yet exist in working directory, download and unzip the files (lines 1 to 9) </li>
<li><b>Reading data into R</b>: load training and testing datasets, activity data and labels, and subject IDs (lines 12 to 19) </li>
<li><b>Merging training and testing sets into one dataset</b>: vertically combine training and testing data (line 22) </li>
<li><b>Extracting only the mean and standard deviation for each measurement</b>: find the variable names in the variable "features" (read in from features.txt) that contained either "mean" or "std", and use the logical result to obtain the desired subset of data (lines 25 to 27) </li>
<li><b>Using descriptive names to label activities</b>: activities were labeled as 1 to 6 and stored in y_train and y_test (read in from text files of the same names). Now these labels were combined into one dataset and were replaced with actual descriptions taken from activity_labels.txt (stored in "actlab") using a for-loop (lines 30 to 34) </li>
<li><b>Adding subject IDs and activity data to the previously merged dataset</b>: data from step3 had no subject and activity info, now these were added as the first two columns (lines 37 to 38) </li>
<li><b>Assigning descriptive names to each variable</b>: variable names read in from features.txt (stored in "features") are now used as column names for the dataset; the first two columns are named "Subject" and "Activity" (line 41) </li>
<li><b>Averaging each variable for each activity and each subject</b>: both "Subject" and "Activity" columns in the dataset were used to split the data, and the mean function was computed for each subset, using the "aggregate" function. Also the first couple of column names were added (lines 44 to 45) </li>
<li><b>Writing the new set of tidied data to a text file</b>: data obtained from the previous step was written to a file called "HARtidy.txt" in the current directory (line 46) </li>
</ol>
