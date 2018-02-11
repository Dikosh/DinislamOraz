# Random forest
library(randomForest)
# RF tuner

t <- tuneRF(IV,DP,
            stepFactor = 0.5,
            plot = TRUE,
            ntreeTry = 300,
            trace=TRUE,
            improve = 0.05)

# No. of nodes for these trees
hist(treesife(rf))

# Partial dependence plot 
MDSplot(rf,train$NSP)
