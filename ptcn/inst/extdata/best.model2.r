# - [0] - Load Required Packages ----

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
library(caret)

data4 = data.frame(data.processed)
data4 = data4[,c('text','class')]
data4$text = as.character(data4$text)

# - [7] - Deep Modeling ----

#Set parameters:
FLAGS <- flags(
  flag_numeric('dropout1', 0.50),
  flag_integer('filters_cnn', 32),
  flag_integer('filters_lstm', 32),
  flag_numeric('reg1', 5e-4),
  flag_numeric('reg2', 0.01),
  flag_numeric('batch_size', 40),
  flag_numeric('maxlen', 2000),
  flag_numeric('max_features', 10000),
  flag_numeric('embedding_dim', 1000),
  flag_numeric('leaky_relu', 0.50),
  flag_numeric('kernel', 5),
  flag_numeric('epochs', 10),
  flag_numeric('pool_size', 4),
  flag_numeric('lr', 0.002),
  flag_numeric('val_split', 0.20)
)
tokenizer <- text_tokenizer(num_words = FLAGS$max_features)

tokenizer %>%
  fit_text_tokenizer(data4$text)

tokenizer$document_count

head(tokenizer$word_counts)


text_seqs <- texts_to_sequences(tokenizer, data4$text)

text_seqs %>%
  head()

str(text_seqs)

n4 = length(text_seqs)
n5 = length(data4$class)


#Set parameters:
x_train <- text_seqs %>%
  pad_sequences(maxlen = FLAGS$maxlen)
dim(x_train)
str(x_train)

y_train <- as.matrix(data4$class)
str(y_train)
length(y_train)

model.data = cbind(x_train, y_train)
model.data = data.frame(model.data)
num.col = ncol(model.data)-1
colnames(model.data) = c(1:num.col, 'label')
model.data[,-c(ncol(model.data))] = sapply(model.data[,-c(ncol(model.data))], as.numeric)
str(model.data)

folds <- createFolds(y = model.data[, 'label'], k = 10, list = F)
model.data$folds <- folds


for(f in unique(model.data$folds)){

  cat("\n Fold: ", f)
  ind <- which(model.data$folds == f)
  train_df <- model.data[-ind, -c(num.col+1, num.col+2)]
  y_train <- as.matrix(model.data[-ind, 'label'])
  y_train <- to_categorical(y_train)
  valid_df <- as.matrix(model.data[ind, -c(num.col+1, num.col+2)])
  y_valid <- as.matrix(model.data[ind, 'label'])
  y_valid <- to_categorical(y_valid)

  model <- keras_model_sequential() %>%
    layer_embedding(FLAGS$max_features, FLAGS$embedding_dim, input_length = FLAGS$maxlen) %>%
    layer_conv_1d(
      FLAGS$filters_cnn/4, FLAGS$kernel,
      kernel_initializer = "VarianceScaling",
      kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg1, l2 = FLAGS$reg1),
      padding = "same", strides = 1L
    ) %>%
    layer_activation_leaky_relu(FLAGS$leaky_relu) %>%
    layer_conv_1d(
      FLAGS$filters_cnn, FLAGS$kernel-1,
      kernel_initializer = "VarianceScaling",
      kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg1, l2 = FLAGS$reg1),
      padding = "same", strides = 1L
    ) %>%
    layer_activation_leaky_relu(FLAGS$leaky_relu) %>%
    layer_conv_1d(
      FLAGS$filters_cnn/2, FLAGS$kernel-3,
      kernel_initializer = "VarianceScaling",
      kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg1, l2 = FLAGS$reg1),
      padding = "same", activation = "relu", strides = 1L
    ) %>%
    layer_max_pooling_1d(FLAGS$pool_size) %>%
    layer_conv_1d(
      FLAGS$filters_cnn/2, FLAGS$kernel-3,
      kernel_initializer = "VarianceScaling",
      kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg1, l2 = FLAGS$reg1),
      padding = "same", activation = "relu", strides = 1L
    ) %>%
    layer_activation_leaky_relu(FLAGS$leaky_relu) %>%
    layer_conv_1d(
      FLAGS$filters_cnn/4, FLAGS$kernel-3,
      kernel_initializer = "VarianceScaling",
      kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg1, l2 = FLAGS$reg1),
      padding = "same", strides = 1L
    ) %>%
    layer_activation_leaky_relu(FLAGS$leaky_relu) %>%
    layer_max_pooling_1d(FLAGS$pool_size) %>%
    layer_batch_normalization()  %>%
    layer_dropout(0.5) %>%
    layer_lstm(units=FLAGS$filters_lstm,
               kernel_initializer = "VarianceScaling",
               kernel_regularizer = regularizer_l1_l2(l1 = FLAGS$reg2, l2 = FLAGS$reg2)) %>%
    layer_activation_leaky_relu(FLAGS$leaky_relu) %>%
    layer_dropout(FLAGS$leaky_relu) %>%
    layer_dense(ncol(y_train)) %>%
    layer_activation("softmax") %>% compile(
      loss = "categorical_crossentropy",
      optimizer = optimizer_sgd(lr = FLAGS$lr),
      metrics = "accuracy"
    )


  summary(model)

  hist <- model %>%
    fit(
      as.matrix(train_df), y = y_train,
      batch_size = FLAGS$batch_size,
      epochs = FLAGS$epochs,
      validation_split = FLAGS$val_split,
      callbacks = list(callback_early_stopping(patience = 10, monitor = 'val_loss', restore_best_weights = TRUE),
                       callback_reduce_lr_on_plateau(monitor = 'val_loss', factor = 1e-1,
                                                     patience=9, verbose=1, mode='auto',
                                                     min_delta=1e-1, cooldown=0, min_lr=1e-8))
    )

  print(plot(hist))


  df_out <- hist$metrics %>%
  {data.frame(acc = .$acc[FLAGS$epochs], val_acc = .$val_acc[FLAGS$epochs])}

  print(df_out)

  score <- model %>% evaluate(valid_df, y_valid, batch_size = FLAGS$batch_size)
  print(score)

  pred <- model %>% predict(valid_df, y_valid, batch_size = FLAGS$batch_size)
  y_pred = round(pred)
  print(head(y_pred))

  results = data.frame(y_valid, y_pred)
  print(head(results))

  cm = confusionMatrix(as.factor(y_pred), reference = as.factor(y_valid), mode = "prec_recall")
  print(cm)
}

#Save the model
model %>% save_model_hdf5("model7.h5")
load_model_hdf5("model7.h5")
