library(keras)
install_keras()

data <- read.csv(file.choose(),header=TRUE)
str(data)
data <- as.matrix(data)
dimnames(data) <- NULL
# normalize
data[,1:21] <- normalize(data[,1:21])
data[,22] <- as.numeric(data[,22])-1
summary(data)

# set data partition
set.seed(123)
ind <- sample(2,nrow(data),replace = TRUE,prob = c(0.7,0.3))
train <- data[ind==1,1:21]
test <- data[ind==2,1:21]
t_label <- data[ind==1,22]
test_label <- data[ind==2,22]

# One hot encoding

trainLabels <- to_categorical(t_label)
testLabel <- to_categorical(test_label)

# Create Sequintal Model
model <- keras_model_sequential()
model %>% layer_dense(units = 80,
                      activation = "relu",
                      input_shape = c(21)) %>% 
  layer_dense(units = 8,activation = "relu") %>% 
  layer_dense(units = 3,activation = "softmax")

# Compile

model %>% compile(loss="categorical_crossentropy",
                  optimizer = "adam",
                  metrics = "accuracy")
# Fit mode1
history <- model %>% fit(train,trainLabels,epochs = 200,
                         batch_size = 32,
                         validation_split = 0.2)
plot(history)
# Evaluate model with test data
model2 <- model %>% evaluate(test,testLabel)
# Prediction 
prob <- model %>% predict_proba(test)
pred <- model %>% predict_classes(test)
table2 <- table(Predicted=pred, Actual=test_label)
cbind(prob,pred,test_label)

# Fine Tune Model
table1
model1
table2
model2
