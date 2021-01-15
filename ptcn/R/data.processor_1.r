#' @export
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
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
# - Pre-processes a List of Text and a List of Binary Labels into a single frame
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
data.processor_1 <- function(x, y) {
  starttime = Sys.time()
  print("Pre-processing Text ...")
  text = c(lapply(x, as.character))
  data.text = text
  data.text = tolower(data.text)
  data.text = tm::removeWords(data.text, stopwords("SMART"))
  data.text = iconv(data.text, "latin1", "ASCII", sub = " ")
  data.text = gsub("^NA| NA ", " ", data.text)
  data.text = tm::removePunctuation(data.text)
  data.text = tm::removeNumbers(data.text)
  data.text = tm::stripWhitespace(data.text)
  assign("data.text",data.text, envir = globalenv())
  end.time <- Sys.time()
  time.taken <- end.time - starttime
  print(c("Pre-processing Text Complete ..."))
  print(time.taken)
  #######################################################################################
  #######################################################################################
  #######################################################################################
  #######################################################################################
  starttime = Sys.time()
  print("Equalizing the Distribution of Labeled Texts...")
  merged.data = data.frame(cbind(data.text, y))
  colnames(merged.data) = c('text','class')
  split_0 = merged.data[which(merged.data$class == 0), ]
  split_1 = merged.data[which(merged.data$class == 1), ]
  min = min(c(length(split_0$class),length(split_1$class)))
  data.even = rbind(split_0[1:min,], split_1[1:min,])
  N4 =  nrow(data.even)
  ind4 = sample(N4, N4*1, replace = FALSE)
  data.processed  = merged.data[ind4,]
  assign("data.processed",data.processed, envir = globalenv())
  end.time <- Sys.time()
  time.taken <- end.time - starttime
  print(c("Equalizing the Distribution of Labeled Texts Complete ..."))
  print(time.taken)
  #######################################################################################
  #######################################################################################
  #######################################################################################
  #######################################################################################
  write.csv(data.processed, "data.processed.csv")
}
