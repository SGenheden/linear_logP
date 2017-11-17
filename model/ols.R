
setwd("~/Dropbox/Code/linear_logP/model")
library(readxl)
data <- read_excel("../data.xlsx")
View(data)

mm<-lm(dGow~Weight+Heavies+Carbons+Polar+Rings+HDonors+HAcceptors,data=data)
summary(mm)

data.hbondcnt<-data.

data$HBonds<-data$HDonors+data$HAcceptors
data$Nonpolar<-data$Carbons/data$Heavies

mm<-lm(dGow~Weight+HBonds+Nonpolar,data=data)
summary(mm)

