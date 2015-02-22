#1. Merges the training and the test sets to create one data set.
#2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.	Uses descriptive activity names to name the activities in the data set
#4.	Appropriately labels the data set with descriptive variable names. 
#5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Clean the workspace----
rm(list=ls())

#1 and 4:Loading, merging and labelling the initial data----
setwd("C:/Users/Damià/Desktop/Data science specialization/3.Getting and Cleaning Data/Project/Data")
names<-read.table("features.txt", sep="")[,2]
firsts_column <- c("Subject","Activity")
names=c(firsts_column, as.character(names))

test<-read.table("./test/X_test.txt", sep="", header=FALSE)
testlabels<-read.table("./test/Y_test.txt", sep="", header=FALSE)
testsubject<-read.table("./test/subject_test.txt", sep="", header=FALSE)
testset<-cbind(testsubject,testlabels, test)

train<-read.table("./train/X_train.txt", sep="", header=FALSE)
trainlabels<-read.table("./train/Y_train.txt", sep="", header=FALSE)
trainsubject<-read.table("./train/subject_train.txt", sep="", header=FALSE)
trainset<-cbind(trainsubject,trainlabels, train)

data<-rbind(trainset,testset)
colnames(data)= names
remove(test,train,testlabels,trainlabels,trainset,testset,trainsubject,testsubject)

#2:Extract mean and sd measurements for each measurement:-------
containmean <-as.numeric(regexpr(pattern ='mean',names(data)))>0
mean <- which(containmean==TRUE)
containMean<-as.numeric(regexpr(pattern ="Mean",names(data)))>0
Mean <- which(containMean==TRUE)
containstd<-as.numeric(regexpr(pattern ='std',names(data)))>0
std <- which(containstd==TRUE)

extractcolumns <- c(mean,Mean,std)

data<-data[,c(1,2,mean,Mean,std)]

#3:Descriptive activity names-------
for(i in 1:nrow(data)){
  if(data[i,"Activity"] == 1){
    data[i,"Activity"] <- "WALKING"
  }
  else if(data[i,"Activity"] == 2){
    data[i,"Activity"] <- "WALKING_UPSTAIRS"
  }
  else if(data[i,"Activity"] == 3){
    data[i,"Activity"] <- "WALKING_DOWNSTAIRS"
  }
  else if(data[i,"Activity"] == 4){
    data[i,"Activity"] <- "SITTING"
  }
  else if(data[i,"Activity"] == 5){
    data[i,"Activity"] <- "STANDING"
  }
  else if(data[i,"Activity"] == 6){
    data[i,"Activity"] <- "LAYING"
  }
}

#4:Label the dataset with descriptive variable names----
  
  #This part is done in the first section "Loading, merging and labelling the initial data"

#5: Tidy dataset with AVG of each variable for each subject for each activity----
library(reshape2)
rawtidydata <- melt(data, id=c("Subject","Activity"))
colnames(rawtidydata)=c("Subject","Activity","Measure","Mean")

library(dplyr)
tidydata2 <- group_by(rawtidydata, Subject, Activity, Measure)
tidydata<-summarise(tidydata2,Mean = mean(Mean, na.rm=T));tidydata2

#Export the tidy data:----- 
write.table(tidydata,"tidy_data.txt",row.name=FALSE )
