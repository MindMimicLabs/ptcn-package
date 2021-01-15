library(ptcn)
data <- data.frame(read.csv("data/Test.csv"))
colnames(data) = c('text','label')
data = na.omit(data)
str(data)

data.processor_1(data$text, data$label)
modeling(data.processed)
