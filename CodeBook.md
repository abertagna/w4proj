# Getting and Cleaning Data Course Project - CodeBook
The exercise is aimed at manipulating and summarizing a large data set obtained from the accelerometers of a Samsung smartphone. 

## Input Data
The input data consist of movement recognition variables obtained from the recordings of 30 subjects performing various activities. A full description of the input data is available at the following site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Detailed information about the collected variables and the data structure is contained in the file README.txt contained the data package, downloadable via the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Processing
The analysis (via the script run_analysis.R contained in this repository) performs the following operations:

1. **Data set creation**. The observations collected during the experiment are divided in 2 subsets (train and test) with identical structure. Each sub set consists in 3 kinds of variables:
  * The collected measures from the accelerometers
  * The numerical id of the subject performing the collection (1 to 30)
  * The numerical id of activity the subject is involved in (1 to 6)
  
  During this step, one data table is created for each subset, merging column-wise all 3 kinds of variables. Finally, a unique table is created merging row-wise the 2 data tables previously created.
  
  Variable names for the recordings measures, which are contained in a separate file, are read and properly associated to the resulting data table. Ids of subject and activity are manually dubbed as "subject" and "act.id".

2. **Variables selection**. During this step, variables that not represent mean or standard deviation of recordings are removed from the original data set. This is performed by retaining only variables whose name includes "mean()" or "std()", together with the subject and activity ids.

3. **Activity identification**. A dictionary between each activity id (1 to 6) and its meaning (resp. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) is provided in a separate file. The dictionary is read as a separate 2-columns data table and the activity meaning is associated to each row of the main data table via a join operation over the field "act.id". The new factor variable with the activity meaning is dubbed "activity". The field "act.id" is then dropped from the table to simplify the following summarizing activities.

4. **Variable names cleanup**. The following modifications are applied to the original variable names to make them more in line with the tidy data-set guidelines:
  * dash ("-"): replaced with period (".")
  * parentheses ("(" and ")"): removed
  * leading "t": replaced with more explicity "time." to indicate the sampling in the time domain
  * leading "f": replaced with more explicity "freq." to indicate the sampling in the frequency domain

5. **Summarizing data**. A new data set is created containing the average of all variables by activity and subject. The averaged variables are renamed to reflect their new meaning by adding the prefix "avg.". The resulting data set is dumped into a text file called "dt_summary.txt".









