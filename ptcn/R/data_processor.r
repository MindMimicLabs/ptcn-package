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
data_processor <- function(x, y, num.classes = c(NULL)) {
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
  if(num.classes == 2){
  split_0 = merged.data[which(merged.data$class == 0), ]
  split_1 = merged.data[which(merged.data$class == 1), ]
  min = min(c(length(split_0$class),length(split_1$class)))
  data.even = rbind(split_0[1:min,], split_1[1:min,])
  N4 =  nrow(data.even)
  ind4 = sample(N4, N4*1, replace = FALSE)
  data.processed = data.even[ind4,]
  data.processed$text = as.character(data.processed$text)
  } else if(num.classes == 3){
    split_0 = merged.data[which(merged.data$class == 0), ]
    split_1 = merged.data[which(merged.data$class == 1), ]
    split_2 = merged.data[which(merged.data$class == 2), ]
    min = min(c(length(split_0$class),length(split_1$class), length(split_2$class)))
    data.even = rbind(split_0[1:min,], split_1[1:min,], split_2[1:min,])
    N4 =  nrow(data.even)
    ind4 = sample(N4, N4*1, replace = FALSE)
    data.processed = data.even[ind4,]
    data.processed$text = as.character(data.processed$text)
  } else if(num.classes == 4){
    split_0 = merged.data[which(merged.data$class == 0), ]
    split_1 = merged.data[which(merged.data$class == 1), ]
    split_2 = merged.data[which(merged.data$class == 2), ]
    split_3 = merged.data[which(merged.data$class == 3), ]
    min = min(c(length(split_0$class),length(split_1$class), length(split_2$class),
                length(split_3$class)))
    data.even = rbind(split_0[1:min,], split_1[1:min,], split_2[1:min,], split_3[1:min,])
    N4 =  nrow(data.even)
    ind4 = sample(N4, N4*1, replace = FALSE)
    data.processed = data.even[ind4,]
    data.processed$text = as.character(data.processed$text)
  }
  assign("data.processed",data.processed, envir = globalenv())
  str(data.processed)
  table(data.processed$class)
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
