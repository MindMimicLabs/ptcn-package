setwd("C:/Users/Jonathan Korn/Desktop/book-ptcn-main/ptcn_example")
library(ptcn)
data <- data.frame(read.csv("./data/Test.csv"))
colnames(data) = c('text','label')
data = tail(data, 300)
data = na.omit(data)
str(data)


# - Data Pre-Processing for PTCN ----
# element (1) x = list of texts
# element (2) y = list of labels 
# - Note - the lists should correspond with eachother. 
data.processor_1(data$text, data$label)

# - Modeling with the PTCN ----
# element (1) data,
# element (2) dropout,
# element (3) filters_cnn, 
# element (4) filters_lstm,
# element (5) reg1,
# element (6) reg2,
# element (7) batch_size,
# element (8) maxlen,
# element (9) max_features,
# element (10) embedding_dims,
# element (11) leaky_relu,
# element (12) kernel,
# element (13) epochs,
# element (14) pool_size,
# element (15) lr,
# element (16) val_split
modeling(data.processed)
