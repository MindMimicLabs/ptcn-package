#' @export
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
library(tfruns)
library(keras)
library(tensorflow)
library(xml2)
library(dplyr)
library(plyr)
library(searcher)
library(tokenizers)
library(tm)
library(stringr)
library(topicmodels)
library(doParallel)
library(ggplot2)
library(scales)
library(qdapDictionaries)
library(data.table)
library(readtext)
library(hunspell)
library(ggplot2)
library(qdap)
library(sentimentr)
library(readr)
library(NLP)
library(openNLP)
library(openNLPmodels.en)
library(gsubfn)
library(caret)
# - Pre-processes a List of Text and a List of Binary Labels into a single frame
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
ptcn_multi <- function(data.processed,dropout = c(0.50),filters_cnn = c(32,64), filters_lstm = c(32,64),
                     reg1 = c(5e-4),reg2 = c(5e-4),batch_size = c(40),maxlen = c(200),
                     max_features = c(2000),embedding_dims = c(1000),leaky_relu = c(0.50),
                     kernel = c(5),epochs = c(10),pool_size = c(4,8),lr = c(0.004,0.003),
                     val_split = c(0.20), hyper_sample = c(0.1)) {
  starttime = Sys.time()
  print("Hyper-Tuning PTCN ...")
  par <- list(
    dropout1= dropout,
    filters_cnn= filters_cnn,
    filters_lstm= filters_lstm,
    reg1= reg1,
    reg2= reg2,
    batch_size= batch_size,
    maxlen= maxlen,
    max_features = max_features,
    embedding_dim= embedding_dims,
    leaky_relu= leaky_relu,
    kernel= kernel,
    epochs= epochs,
    pool_size= pool_size,
    lr= lr,
    val_split= val_split)
  runs <- tuning_run(system.file("extdata", "hyper-tuning2.r", package="ptcn"),
                     runs_dir = '_tuning',
                     sample = hyper_sample, flags = par)
  assign("runs",runs, envir = globalenv())
  end.time <- Sys.time()
  time.taken <- end.time - starttime
  print(c("Hyper-Tuning PTCN Complete ..."))
  print(time.taken)
  #######################################################################################
  #######################################################################################
  #######################################################################################
  #######################################################################################
  starttime = Sys.time()
  print("Training Best Model ...")
  best_run <- ls_runs(order = metric_val_accuracy, decreasing= TRUE, runs_dir = '_tuning')[1,]
  training_run(system.file("extdata", "best.model2.r", package="ptcn"),flags = list(
    dropout1 = best_run$flag_dropout1,
    filters_cnn = best_run$flag_filters_cnn,
    filters_lstm = best_run$flag_filters_lstm,
    reg1 = best_run$flag_reg1,
    reg2 = best_run$flag_reg2,
    batch_size = best_run$flag_batch_size,
    max_features = best_run$flag_max_features,
    maxlen = best_run$flag_maxlen,
    embedding_dim = best_run$flag_embedding_dim,
    leaky_relu = best_run$flag_leaky_relu,
    kernel = best_run$flag_kernel,
    epochs = best_run$flag_epochs,
    pool_size = best_run$flag_pool_size,
    lr = best_run$flag_lr,
    val_split = best_run$flag_val_split))
  end.time <- Sys.time()
  time.taken <- end.time - starttime
  print(c("Training Best Model ..."))
  print(time.taken)
  #######################################################################################
  #######################################################################################
  #######################################################################################
  #######################################################################################
}
