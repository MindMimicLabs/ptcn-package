if (!require('keras')) {
  install.packages("keras", dependencies = TRUE)
  library(keras)
}
install_keras()
if (!require('tensorflow')) {
  install.packages("tensorflow", dependencies = TRUE)
  #install_tensorflow(version = "1.15.0")
  library(tensorflow)
}
install_tensorflow()
if (!require('tfruns')) {
  install.packages("tfruns", dependencies = TRUE)
  library(tfruns)
}
if (!require('xml2')) {
  install.packages("xml2", dependencies = TRUE)
  library(xml2)
}
if (!require('dplyr')) {
  install.packages("dplyr", dependencies = TRUE)
  library(dplyr)
}
if (!require('plyr')) {
  install.packages("plyr", dependencies = TRUE)
  library(plyr)
}
if (!require('searcher')) {
  install.packages("searcher", dependencies = TRUE)
  library(searcher)
}
if (!require('tokenizers')) {
  install.packages("tokenizers", dependencies = TRUE)
  library(tokenizers)
}
if (!require('tm')) {
  install.packages("tm")
  library(tm)
}
if (!require('stringr')) {
  install.packages("stringr", dependencies = TRUE)
  library(stringr)
}
if (!require('topicmodels')) {
  install.packages("topicmodels", dependencies = TRUE)
  library(topicmodels)
}
if (!require('doParallel')) {
  install.packages("doParallel", dependencies = TRUE)
  library(doParallel)
}
if (!require('colorspace')) {
  install.packages("colorspace", dependencies = TRUE)
  library(colorspace)
}
if (!require('ggplot2')) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}
if (!require('scales')) {
  install.packages("scales", dependencies = TRUE)
  library(scales)
}
if (!require('qdapDictionaries')) {
  install.packages("qdapDictionaries", dependencies = TRUE)
  library(qdapDictionaries)
}
if (!require('data.table')) {
  install.packages("data.table", dependencies = TRUE)
  library(data.table)
}
if (!require('readtext')) {
  install.packages("readtext", dependencies = TRUE)
  library(readtext)
}
if (!require('hunspell')) {
  install.packages("hunspell", dependencies = TRUE)
  library(hunspell)
}
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-15.0.2/")
if (!require('rJava')) {
  install.packages("rJava","http://rforge.net")
  library(rJava)
}
if (!require('devtools')) {
  install.packages("devtools", dependencies = TRUE)
  library(devtools)
}
if (!require('igraph')) {
  install.packages("igraph", dependencies = TRUE)
  library(igraph)
}
if (!require('qdap')) {
  install.packages("qdap", dependencies = TRUE)
  library(qdap)
}
if (!require('sentimentr')) {
  install.packages("sentimentr", dependencies = TRUE)
  library(sentimentr)
}
if (!require('readr')) {
  install.packages("readr", dependencies = TRUE)
  library(readr)
}
if (!require('caret')) {
  install.packages("caret", dependencies = TRUE)
  library(caret)
}
if (!require('openNLP')) {
  install.packages("openNLP")  
  library(openNLP)
}
if (!require('openNLPmodels.en')) {
  install.packages("openNLPmodels.en", dependencies=TRUE, repos = "http://datacube.wu.ac.at/")
  library(openNLPmodels.en)
}
if (!require('gsubfn')) {
  install.packages("gsubfn")
  library(gsubfn)
}
if (!require("reticulate")) {
  install.packages('./packages/reticulate-1.15.tar.gz', repos = NULL, type ='source')
  library(reticulate)
}
#py_install("tensorflow==1.15")