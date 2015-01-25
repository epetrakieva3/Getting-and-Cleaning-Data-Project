##Getting and Cleaning Data Project
## Elena Petrakieva





setwd("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset")

## Read all the files in the dataset.

activity <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/activity_labels.txt", header=FALSE)
features <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/features.txt", header=FALSE)
xTest <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/test/x_test.txt", header=FALSE)
yTest <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/test/y_test.txt", header=FALSE)
xTrain <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/train/x_train.txt", header=FALSE)
yTrain <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/train/y_train.txt", header=FALSE)
subjectTrain <- read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjectTest <-read.table("C:/Users/Owner/Desktop/R Dir/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

## Assign column names
colnames(activity)  = c('activityId','activityName')
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2]
colnames(yTrain)        = "activityId"
colnames(subjectTest) = "subjectId"
colnames(xTest)       = features[,2]
colnames(yTest)       = "activityId"

## Merge into one set
trainingFull = cbind(yTrain,subjectTrain,xTrain)
testFull = cbind(yTest,subjectTest,xTest)
fullData = rbind(trainingFull,testFull)

## Extract mean and std dev

colNames  = colnames(fullData)
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
fullData = fullData[logicalVector==TRUE]


## Descriptive activity names
fullData = merge(fullData,activity,by='activityId',all.x=TRUE)
colNames  = colnames(fullData)

for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","Frequency",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(fullData) = colNames


# Create a tidy data set with the average of each variable for each activity and each subject

finalDataNoActivityType  = fullData[,names(fullData) != 'activityType'];

tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

tidyData    = merge(tidyData,activity,by='activityId',all.x=TRUE);

write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');










