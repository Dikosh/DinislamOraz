devtools::install_github("aoles/EBImage", ref="RELEASE_3_5")
library(EBImage)
library(keras)

setwd("~/Изображения/Webcam/")
pics <- c("2018-02-11-211009.jpg",
          "2018-02-11-211015.jpg",
          "2018-02-11-211019.jpg",
          "2018-02-11-211025.jpg",
          "g.jpg",
          "q.jpg",
          "r.jpg",
          "а1.jpg",
          "а.jpg")


mypic <- list()

for(i in 1:9){mypic[[i]] <- readImage(pics[i])}

# Explore what we have?
print(mypic[[1]])
display(mypic[[1]])

# Resize
for(i in 1:9){mypic[[i]] <- resize(mypic[[i]],28,28)}

# Reshape
for(i in 1:9){mypic[[i]] <- array_reshape(mypic[i],c(28,28,3))}
str(mypic)
# Row Bind
trainx <- NULL
for(i in 5:8){trainx <- rbind(trainx,mypic[[i]])}
str(trainx)
testx <- rbind(mypic[[4]],mypic[[9]])
trainy <- c(0,0,0,0,1,1,1,1,1)
testy <- c(0,1)
str(trainx)

# One hot encoding
trainLabel <-  to_categorical(trainy)
testLabel <- to_categorical(testy)

# Model
model <- keras_model_sequential()
model %>% 
      layer_dense(units = 256,
                  activation = "relu",
                  input_shape = c(2352)) %>% 
      layer_dense(units = 128,
                  activation = "relu") %>% 
      layer_dense(units = 2,activation = "softmax")
str(model)

# Compile 
model %>% 
  compile(loss="binary_crossentropy",
          optimizer = optimizer_rmsprop(),
          metrics = c("accuracy"))
# Fit model
history <- model %>% 
  fit(trainx,trainLabel,
      epochs = 30,
      batch_size = 32,
      validation_split = 0.2)

