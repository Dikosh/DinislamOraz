# Neural network in R
library(car)
data("Duncan")
Duncan$income <- (Duncan$income-min(Duncan$income))/(max(Duncan$income)-min(Duncan$income))
Duncan$education <- (Duncan$education-min(Duncan$education))/(max(Duncan$education)-min(Duncan$education))
Duncan$prestige <- (Duncan$prestige-min(Duncan$prestige))/(max(Duncan$prestige)-min(Duncan$prestige))

summary(Duncan)
hist(Duncan$income)


set.seed(222)
ind <- sample(2,nrow(Duncan),replace = TRUE,prob=c(0.7,0.3))
train <- Duncan[ind==1,]
test <- Duncan[ind==2,]

# Neural network
library(neuralnet)
set.seed(333)
attach(Duncan)
n <- neuralnet(as.integer(type)~income+education+prestige,
               data=train,hidden = c(3,6),
               linear.output = FALSE,
               lifesign = "full",
               rep=5)
plot(n)
str(train)

output <- compute(n,train[,-1],rep = 1)
p1 <- output$net.result
pred1 <- ifelse(p1>0.5,1,0)
tab1 <- table(pred1,as.integer(train$type))
table(train$type)
1-sum(diag(tab1))/sum(tab1)
# Node Output Calculations with Sigmoid activation function 
