url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename<-"HAR.zip"

# If the dataset is not found in the workspace then download and unzip it.
if (!file.exists(filename)){
  download.file(url,destfile="HAR.zip")
  unzip("HAR.zip")
  unlink("HAR.zip")
}

# Load data
features<-read.table("./UCI HAR Dataset/features.txt",sep=" ",stringsAsFactors = FALSE)
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",sep=" ")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",sep=" ")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",sep=" ")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",sep=" ")
actlab<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)

# Merge training and testing datasets
xdat<-rbind(x_train,x_test)

# Subsetting the columns measuring mean and std only
idx <- grep("mean|std", features$V2)
data<-xdat[,idx]
ftr<-features[idx,] #also get the subset of feature names

# Changing activity labels to actual activity descriptions
ydat<-rbind(y_train,y_test) 
activ<-as.data.frame(c(1:nrow(ydat)))
for (i in seq(1:6)){
  activ[ydat[,1]==i,1]<-actlab[i,2]
}

# Adding in subject IDs and activity data
sdat<-rbind(subject_train,subject_test)
HARdata<-cbind(cbind(sdat,activ),data)

# Add descriptive labels to datasets; ftr is the subset of features involving means and stds
colnames(HARdata)<-c("Subject","Activity",t(ftr[,2]))

# Averaging each variable for each activity and each subject
HARnew<-aggregate(HARdata[,3:ncol(HARdata)],by=list(HARdata$Subject,HARdata$Activity),mean)
colnames(HARnew)<-c("Subject","Activity",as.character(names(HARnew[, 3:ncol(HARnew)])))
write.table(HARnew,file="HARtidy.txt",row.names=FALSE)