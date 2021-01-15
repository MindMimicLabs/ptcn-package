# ptcn.package

The package provides the ability to use the "Predict Text Classification Network" or PTCN for binary text classification tasks. 
The PTCN is referenced in "A Deep Learning Neural Network to Predict Congressional Roll Call Votes from Legislative Texts" Machine Learning and Applications: An International Journal (MLAIJ) Vol.7, No.3/4, December 2020 authored by Jonathan Wayne Korn and Mark A. Newman from the Department of Data Science, Harrisburg University, Harrisburg, Pennsylvania. 

## General Process of the PTCN Package 
The ptcn package requires two variables text and binary labels to be processed through the data.processor_1() function. The function pre-processes the text and equalizies the distribution the labels to the texts for each class saving the results in the global enviorment and a local /.csv file as 'data.processed'.

The newly pre-processed data, 'data.processed', should be feed through the modeling() function in order to intitate the hyper-tuning sessions and best modeling session, which activates the PTCN. The results will be stored in a tfruns report and the final model state will be saved and stored locally. 
