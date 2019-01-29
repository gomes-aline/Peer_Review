---
title: "Read Me"
author: "Aline Gomes"
date: "29 de janeiro de 2019"
output: html_document
---

## Introduction
This Read Me file describes how my R script, called "run_analysis.R" works. This is a peer assessment of the "Getting and Cleaning Data" Course.
The aim of this R script is merge two different data sets, "Train" and "Test", properly name it's variables and transform the dataset in a tidy dataset.

## The "run_analysis.R" script

The steps os this R Script goes as the following

* Download the zipfile with the **download.file** function;
* Unzip it to the work directory with the **unzip** function, from the "utils" package;
* Create objects "train" and "test" using **read.table** function to read the data information on the respective txt files ("train/X_train.txt" and "test/X_test.txt")
* Add subjects and activities columns to the train and test dataset from the txt files ("train/subject_train.txt", "train/y_train.txt","test/subject_test.txt", "test/y_test.txt"), using **cbind**;
* Rename the columns using **colnames**: "sub" for the subject column, "act" for the activities column, and 1 to 561 to the 561 measurements in each dataset;
* Merge both datasets by all the columns that have the same name using **merge** function, and sort it by subject number ("sub") and then to activities number ("act") using the **arrange** function;
* The resulting dataset is stored in an object called *mdata*;
* Label the variables with descriptive variables names from the "features.txt" file, using **colnames** function;
* Subset only the mean and standard deviation variables using **grep** function. We also include subject and activies variables since they're necessary to the next steps. The result was stored in an object called *mdatasel*;
* Replace the number values in the activities column for the respective activity name, using a loop (for) and the **gsub** function;
* Using **group_by** and **summarise_all**, create a tidy dataset with the average values for all the measurements by subject and by activity, resulting in a dataset with 180 rows (one row for each on of the 30 subjects and 6 activities) and 81 columns for the subject, activities, and the average values of the 79 mean or standard deviation variables; 
* The resulting dataset was stored in a txt file called "tidydata.txt".



