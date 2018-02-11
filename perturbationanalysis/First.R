source("https://bioconductor.org/biocLite.R")
biocLite()

library(car)
data("Duncan")
attach(Duncan)

ml <- lm(prestige~income+education)
ml1 <- lm(prestige~income*education)

summary(ml)
anova(ml)
vif(ml)

# Perturbation analysis with numerical independent variables
library(perturb)
p1 <- perturb(ml,pvars = c("income","education"),prange = c(1,1))
summary(p1)

# Perturbation analysis with numerical and categorical independent variables in R
m2 <- lm(prestige~income+education+type)
summary(m2)
anova(m2)
vif(m2)

p2 <- perturb(m2,pvars = c("income","education"),prange = c(1,1),pfac = list("type",pcnt=95))
summary(p2)
 

#
