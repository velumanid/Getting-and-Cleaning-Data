# set working directory

getwd()
setwd("j:/Coursera/R/getting and cleaning assignement data/UCI HAR Dataset/")

# extract Dimension files features and activity_label 

activity_label<-read.table("activity_labels.txt")
activity_label
features<-read.table("features.txt")
features

# Read Test data

subject_test<-read.table("./test/subject_test.txt")
xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")

# Read Train data

subject_train<-read.table("./train/subject_train.txt")
xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")

#3) Uses descriptive activity names to name the activities in the data set

colnames(xtest)<-features$V2
colnames(xtrain)<-features$V2
colnames(ytrain)<-c("ActivityId")
colnames(ytest)<-c("ActivityId")
colnames(subject_train)<-c("SubjectId")
colnames(subject_test)<-c("SubjectId")

#1) Merges the training and the test sets to create one data set.

master_train<-cbind(xtrain,ytrain,subject_train)
master_test<-cbind(xtest,ytest,subject_test)
master<-rbind(master_train,master_test)

#2) Extracts only the measurements on the mean and 
#standard deviation for each measurement. 

mean1<-apply(master,2,mean,na.rm=TRUE)
sd1<-apply(master,2,mean,na.rm=TRUE)
mean1
sd1

# 4) Appropriately labels the data set with descriptive activity names. 

master$ActivityId[which(master$ActivityId==1)]<- "WALKING"
master$ActivityId[which(master$ActivityId==2)]<- "WALKING_UPSTAIRS"
master$ActivityId[which(master$ActivityId==3)]<- "WALKING_DOWNSTAIRS"
master$ActivityId[which(master$ActivityId==4)]<- "SITTING"
master$ActivityId[which(master$ActivityId==5)]<- "STANDING"
master$ActivityId[which(master$ActivityId==6)]<- "LAYING"

# 5 ) Creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject. 

library(reshape2)
# Melting data by Activityid and subjuectid
meltdata<-melt(master,id.vars=c("ActivityId","SubjectId"))

# cast by mean and sd for ActivityId+SubjectId ~ variable
tidy_mean<-dcast(meltdata,ActivityId+SubjectId~variable,mean)


#import tidy file
write.table(tidy_mean,"tidy1.txt",sep="\t")

