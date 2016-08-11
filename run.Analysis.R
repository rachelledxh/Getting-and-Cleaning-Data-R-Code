## Project

library(dplyr)
library(data.table)

setwd("./Desktop/proj")
subject_test<- read.table("./test/subject_test.txt",header=FALSE)
X_test<- read.table("./test/X_test.txt",header=FALSE)
Y_test<- read.table("./test/y_test.txt",header=FALSE)

subject_train<- read.table("./train/subject_train.txt",header=FALSE)
X_train<- read.table("./train/X_train.txt",header=FALSE)
Y_train<- read.table("./train/Y_train.txt",header=FALSE)

#column names for activity labels
activityLabels<- read.table("./activity_labels.txt",header=FALSE)
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))
## part 1
subject<- rbind(subject_test,subject_train)
X<- rbind(X_test,X_train)
Y<- rbind(Y_test,Y_train)


colnames(subject) <- "Subj"
colnames(Y) <- "Acti"
featureNames <- read.table("./features.txt")
colnames(X)<- t(featureNames[2])
complete_Data<- cbind(subject,Y,X) 

## part 2
extract_data <- complete_Data[,c(1,2,grep(".*Mean.*|.*Std.*", names(complete_Data), ignore.case=TRUE))] 

## part 3

activityLabels<- read.table("./activity_labels.txt",header=FALSE)
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))
  
extract_data <- merge(activityLabels, extract_data, by.x="activityNum", by.y="Acti",all.x=TRUE)
extract_data$activityName <- as.character(extract_data$activityName)


extract_data$Acti<- as.character(extract_data$Acti)

  if(extract_data$Acti == 1){
    extract_data$Acti<- "WALKING"
  } else if(extract_data$Acti == 2){
    extract_data$Acti<- "WALKING_UPSTAIRS"
  } else if(extract_data$Acti == 3) {extract_data$Acti<- "WALKING_DOWNSTAIRS"
  } else if (extract_data$Acti == 4) {extract_data$Acti<- "SITTING"}
  else if (extract_data$Acti == 5){
    extract_data$Acti<- "STANDING"}
    else extract_data$Acti<- "LAYING"

## part 4

names(extract_data)<-gsub("Acc", "Accelerometer", names(extract_data))
names(extract_data)<-gsub("Gyro", "Gyroscope", names(extract_data))
names(extract_data)<-gsub("BodyBody", "Body", names(extract_data))
names(extract_data)<-gsub("Mag", "Magnitude", names(extract_data))
names(extract_data)<-gsub("^t", "Time", names(extract_data))
names(extract_data)<-gsub("^f", "Frequency", names(extract_data))
names(extract_data)<-gsub("tBody", "TimeBody", names(extract_data))
names(extract_data)<-gsub("-mean()", "Mean", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-std()", "StandardDeviation", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-freq()", "Frequency", names(extract_data), ignore.case = TRUE)

##part 5
write.table(extract_data, "TidyData-2.txt", row.name=FALSE)


student1<- read.table("./Evaluations/tidydata1.txt",header=TRUE)
student2<- read.table("./Evaluations/tidydata2.txt",header=TRUE)
student3<- read.table("./Evaluations/tidydata3.txt",header=TRUE)

student4<- read.table("./Evaluations/tidydata4.txt",header=TRUE)