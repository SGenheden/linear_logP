#Simple OLS model
ii<-read.table("../phys/overlap.dat")
data$HBonds<-data$HDonors+data$HAcceptors
data$Nonpolar<-data$Carbons/data$Heavies
data2<-data[-ii$V1,]
mm<-lm(dGow~Weight+HBonds+Nonpolar,data=data2)

# Predicting the molecules in the Minnesota database
min<-read_excel("../phys/minnesota.xlsx")
min$HBonds<-min$HDonors+min$HAcceptors
min$Nonpolar<-min$Carbons/min$Heavies
f<-min[c("dGow")]
f$pred<-predict(mm, min[c("Weight","HBonds","Nonpolar")])
plot(f$dGow,f$pred)
write.table(f,'../phys/linear.dat',row.names=FALSE, col.names=FALSE,sep=" ")
cor(min$dGow,f$pred)
mean(abs(min$dGow-f$pred))

elba<-read.table("../phys/elba.dat")
cor(elba$V1,elba$V2)
mean(abs(elba$V1-elba$V2))

martini1<-read.table("../phys/martini_cg.dat")
cor(martini1$V1,martini1$V2)
mean(abs(martini1$V1-martini1$V2))
martini2<-read.table("../phys/martini_hybrid.dat")
cor(martini2$V1,martini2$V2)
mean(abs(martini2$V1-martini2$V2))
