select_model<-function(dataset,yindex,trainindex,K=10,nb=1000) {
  library(leaps)
  
  trdata<-dataset[trainindex,]
  testdata<-dataset[-trainindex,]
  xx<-trdata[,-yindex]
  yy<-trdata[,yindex]
  
  # Enumerate all models
  rleaps<-regsubsets(xx,yy,int=T,nbest=nb,nvmax=dim(xx)[2]+1,really.big=T,method=c("ex")) 
  cleaps<-summary(rleaps,matrix=T) 
  # True/False matrix. The r-th is a True/False statement about which
  Models<-cleaps$which
  # Add a model with only the intercept
  Models<-rbind(c(T,rep(F,dim(xx)[2])),Models) 
  
  # Perfrom K-fold cross-validation
  randi<-sample(seq(1,length(yy)),length(yy))
  foldsize<-floor(length(yy)/K)
  sizefold<-rep(foldsize,K) 
  restdata<-length(yy)-K*foldsize
  if (restdata>0) {
    sizefold[1:restdata]<-sizefold[1:restdata]+1
  }
  Prederrors<-matrix(0,dim(Models)[1],K)
  iused<-0
  Xmat<-as.matrix(cbind(rep(1,dim(xx)[1]),xx))
  for (k in (1:K)) {
    itest<-randi[(iused+1):(iused+sizefold[k])] ## the k-fold test set
    itrain<-randi[-c((iused+1):(iused+sizefold[k]))] ## the k-fold training set
    iused<-iused+length(itest)
    for (mm in (1:dim(Models)[1])) {
      betahat<-solve(t(Xmat[itrain,Models[mm,]])%*%Xmat[itrain,                                                        Models[mm,]])%*%t(Xmat[itrain,Models[mm,]])%*%yy[itrain]
      ypred<-Xmat[itest,Models[mm,]]%*%betahat ## predictions
      Prederrors[mm,k]<-sum((yy[itest]-ypred)^2) 
    } 
  }
  CV<-apply(Prederrors,1,sum)/length(yy) 
  cvmod<-Models[which.min(CV),]
  
  # Calculate CP, AIC and BIC 
  nullrss<-sum((yy-mean(yy))^2)
  RSS<-cleaps$rss
  RSS<-c(nullrss,RSS)
  modsize<-apply(Models==T,1,sum)
  BIC<-length(yy)*log(RSS)+modsize*log(length(yy))
  mse<-min(RSS)/(length(yy)-max(modsize))
  CP<-(RSS+2*modsize*mse)/mse-length(yy)
  AIC<-length(yy)*log(RSS)+2*modsize
  cpmod<-Models[CP==min(CP),]
  aicmod<-Models[AIC==min(AIC),]
  bicmod<-Models[BIC==min(BIC),]
  
  # Calculate the prediction errror
  test_error<-function(trdata, testdata, yindex, winmod) {
    if (sum(winmod)>=1) {
      xx<-trdata[,-yindex]
      ll<-lm(trdata[,yindex]~as.matrix(xx[,winmod==T]))
      xtest<-testdata[,-yindex]
      xtest<-as.matrix(xtest[,winmod==T])
      pred<-ll$coef[1]+xtest%*%ll$coef[-1]
    }
    else {
      pred<-rep(mean(trdata[,yindex]),dim(testdata)[1])
    }
    return(sum((testdata[,yindex]-pred)^2)/length(testdata[,yindex]))
  }
  errcv<-test_error(trdata, testdata, yindex, cvmod[2:length(cvmod)])
  errcp<-test_error(trdata, testdata, yindex, cpmod[2:length(cpmod)])
  erraic<-test_error(trdata, testdata, yindex, aicmod[2:length(aicmod)])
  errbic<-test_error(trdata, testdata, yindex, bicmod[2:length(bicmod)])
  
  min_err<-function(errvec, modsize){
    maxsize<-max(modsize)
    minv<-rep(0,maxsize)
    for (i in (1:maxsize)) {
      minv[i]<-min(errvec[modsize==i])
    }
    return(minv)
  }
  
  modtable<-rbind(cvmod, cpmod, aicmod, bicmod)
  modtable<-cbind(round(c(errcv,errcp,erraic,errbic),3),modtable)
  return(list(CV=CV, AIC=AIC, BIC=BIC, CP=CP, CVmin=min_err(CV, modsize),
              AICmin=min_err(AIC, modsize), BICmin=min_err(BIC, modsize),
              CPmin=min_err(CP, modsize), modtable=modtable, modsize=modsize))
}

