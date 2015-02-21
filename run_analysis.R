library(plyr)

#Reading data files

features<-read.table("UCI HAR Dataset/features.txt")
labels<-read.table("UCI HAR Dataset/activity_labels.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
Xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
Xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
Ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
Ytrain<-read.table("UCI HAR Dataset/train/Y_train.txt")

#Merging test and train datasets

subject<-rbind(subject_test,subject_train)
x<-rbind(Xtest,Xtrain)
y<-rbind(Ytest,Ytrain)

#Extracts the measurements on the mean and standard deviation for each measurement

featuresStd<-subset(features,grepl("*std*",features$V2))
featuresMean<-subset(features,grepl("*mean*",features$V2,ignore.case=TRUE))
featuresMeanStd<-rbind(featuresMean,featuresStd)
orderedFeatures<-arrange(featuresMeanStd,as.integer(V1))
newX<-x[as.numeric(unlist(orderedFeatures[1]))]

#Appropriately labels the data set with descriptive variable names. 

names(newX)<-paste(orderedFeatures[[2]])

#Uses descriptive activity names to name the activities in the data set

newX<-cbind(newX,y)
names(newX)[length(newX)]<-"activity"

for (i in 1:length (newX$activity)) { 
  activity<-as.numeric(newX$activity[[i]])
  newX$activity[[i]]<-as.character(labels$V2[[activity]])
}

newX<-newX[,c(ncol(newX),1:(ncol(newX)-1))]

newX<-cbind(newX,subject)
names(newX)[length(newX)]<-"subject"
newX<-newX[,c(ncol(newX),1:(ncol(newX)-1))]

newX<-arrange(newX,as.integer(subject),activity)

#From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.

finalDS<-newX
finalDS$subject <-factor(finalDS$subject)
finalDS$activity <- factor(finalDS$activity)
finalDS<-ddply(finalDS,.(subject,activity),numcolwise(mean))

write.table(finalDS,"dataset.txt", row.name=FALSE)

finalDS
