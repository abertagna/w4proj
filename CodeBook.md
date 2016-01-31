# Getting and Cleaning Data Course Project - CodeBook
The exercise is aimed at manipulating and summarizing a large data set obtained from the accelerometers of a Samsung smartphone. 

## Input Data
A full description of the input data is available at the following site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Detailed information about the collected variables is also contained in the file README.txt file withing the data package, downloadable via the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Processing
The analysis (via the script run_analysis.R contained in this repository) performs the following operations:

1. Merge the available data sets into a unique table. The observations collected during the experiment are divided in 2 subsets (train and test) with identical structure. Each sub set consists in 3 kinds of variables:
  * The collected measures from the accelerometers
  * The subject performing the collection
  * The activity the subject is involved in
  
  During this step, one data table is created for each subset, merging column-wise all 3 kinds of variables. Finally, a unique table is created merging row-wise the 2 data tables previously created.



