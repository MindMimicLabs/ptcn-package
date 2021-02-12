# ptcn.package

The package provides the ability to use the "Predict Text Classification Network" or PTCN introduced in "A Deep Learning Neural Network to Predict Congressional Roll Call Votes from Legislative Texts" Machine Learning and Applications: An International Journal (MLAIJ) Vol.7, No.3/4, December 2020 authored by Jonathan Wayne Korn and Mark A. Newman from the Department of Data Science, Harrisburg University, Harrisburg, Pennsylvania for binary text classification tasks. 

https://aircconline.com/mlaij/V7N4/7420mlaij02.pdf

## General Process of the PTCN Package 

The ptcn package requires: 

### data_processor():

Prepare to feed two variables, text and binary labels, to the data.processor_1() function. The function pre-processes the text and equalizies the distribution of the labels to their accompanying texts as followed: 

* The text should be in character or string format. 
* The labels should be an integer/numerical format of a binary nature (i.e. (0,1)).
* The texts and labels should be 300 observations at minimum.
* The num.classes refers to the number of classes to balance distribution. 

The list of texts are feed through the PTCN pre-processing steps inlcuding: 

* conversion to character type, 
* conversion to lower casing, 
* removal of stopwords,
* removal of special characters, 
* removal of NA values, 
* removal of punctuation, 
* removal of numbers, 
* removal of whitespace

The pre-processed texts and the corresponding labels are set to an equalized distribution of randomized samples from each class contained in the original dataset. The results are saved in the global enviorment as a dataframe named 'data.processed' and as a local /.csv file named 'data.processed.csv' in the working directory.

i.e. data_processor(data$text, data$label, num.classes = 2)

### ptcn_binary():

The newly pre-processed data, 'data.processed', should be feed through the modeling() function in order to intitate the hyper-tuning sessions and best modeling session using the PTCN. The hyper-tuning and best model sessions store their results in the created '_tuning' log folder and the trained final model state is stored as a /.h5 file within the working directory. Note the hyper-tuning is set to run 16 permutations at default, shuffling through a combination of set parameter values that have been identified to work well within the PTCN architecture. 

Experiment with the parameters included within the modeling() function. All parameters are pre-set to the following default values:

* data = 'data.processed' 
* dropout = c(0.50),
* filters_cnn = c(32,64), 
* filters_lstm = c(32,64),
* reg1 = c(5e-4),
* reg2 = c(5e-4),
* batch_size = c(40),
* maxlen = c(200),
* max_features = c(2000),
* embedding_dims = c(1000),
* leaky_relu = c(0.50),
* kernel = c(5),
* epochs = c(50),
* pool_size = c(4,8),
* lr = c(0.004,0.003),
* val_split = c(0.20)
* hyper_sample = c(0.1)

Note: the function requires a dataframe containing texts and their labels. You may implement your own pre-processing steps as long as the data is the same format as 'data.processed'.  

### ptcn_multi():

The newly pre-processed data, 'data.processed', should be feed through the modeling() function in order to intitate the hyper-tuning sessions and best modeling session using the PTCN. The hyper-tuning and best model sessions store their results in the created '_tuning' log folder and the trained final model state is stored as a /.h5 file within the working directory. Note the hyper-tuning is set to run 16 permutations at default, shuffling through a combination of set parameter values that have been identified to work well within the PTCN architecture. 

Experiment with the parameters included within the modeling() function. All parameters are pre-set to the following default values:

* data = 'data.processed' 
* dropout = c(0.50),
* filters_cnn = c(32,64), 
* filters_lstm = c(32,64),
* reg1 = c(5e-4),
* reg2 = c(5e-4),
* batch_size = c(40),
* maxlen = c(200),
* max_features = c(2000),
* embedding_dims = c(1000),
* leaky_relu = c(0.50),
* kernel = c(5),
* epochs = c(50),
* pool_size = c(4,8),
* lr = c(0.004,0.003),
* val_split = c(0.20)
* hyper_sample = c(0.1)

Note: the function requires a dataframe containing texts and their labels. You may implement your own pre-processing steps as long as the data is the same format as 'data.processed'.  

#### Reporting:

The package tfruns provides functions such as view_run() to produce a compiled report containing either the hyper-tuning and best model training run contained in the "_tuning"log folder. 

i.e. view_run("_tuning/2021-01-15T05-19-22Z")

##### Installation 

To install the development version of the ptcn package from GitHub, please clone the repo and perform the following steps: 

- Install Python 3 and Anaconda 
    - pip install tensorflow == 1.15
    - pip install keras
    
In your R session set the working directory to the cloned folder. 

- run the 'install.packages.r' script to install the dependencies for the ptcn package. 
    - Note, some of the packages will be installed from source files stored in the 'packages' folder. 
- To install the ptcn package set the working directory in your current R session to the 'ptcn' folder and enter the following:
    - install.packages("devtools")
    - devtools::document()
    - devtools::install()
    
 Everything if installed successfully should let you take advantage of the ptcn data.processor() and modeling() functions. 

###### Notes 

The PTCN package is currently under development. Updates to the installation process should be complete soon. 
