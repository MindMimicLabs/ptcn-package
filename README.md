# ptcn.package

The package provides the ability to use the "Predict Text Classification Network" or PTCN introduced in "A Deep Learning Neural Network to Predict Congressional Roll Call Votes from Legislative Texts" Machine Learning and Applications: An International Journal (MLAIJ) Vol.7, No.3/4, December 2020 authored by Jonathan Wayne Korn and Mark A. Newman from the Department of Data Science, Harrisburg University, Harrisburg, Pennsylvania for binary text classification tasks. 

## General Process of the PTCN Package 

The ptcn package requires: 

### data.processor_1():

Prepare to feed two variables, text and binary labels, to the data.processor_1() function. The function pre-processes the text and equalizies the distribution of the labels to their accompanying text, which the results are saved in the global enviorment as a dataframe named 'data.processed' and as a local /.csv file named 'data.processed.csv' in the working directory.

* The text should be in character or string format. 
* The labels should be an integer/numerical format of a binary nature (i.e. (0,1)).
* The texts and labels should be 300 observations at minimum.

### modeling():

The newly pre-processed data, 'data.processed', should be feed through the modeling() function in order to intitate the hyper-tuning sessions and best modeling session, which activates the PTCN. The results will be stored in the created 'tuning' logs, the best model 'runs' log, and the trained final model state as a /.h5. All are created and stored locally in your working directory. Note the hyper-tuning is set to run 16 permutations shuffling through a combination of set parameter values that have been identified to work well within the PTCN architecture. 

#### Reporting:

The package tfruns provides functions such as view_run() to produce a compiled report containing either the hyper-tuning and final model training run log files. 
