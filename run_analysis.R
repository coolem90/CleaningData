##dowanload zip file into local drive
library("data.table")
library("reshape2)

##getPath
path <- getwd()

##import data from Train 
dbSubTrain <- fread(file.path(path, "train", "subject_train.txt"))
dbTrain <- read.table(file.path(path, "train", "X_train.txt"))
dbTrain <- data.table(dbTrain)
dbLabTrain <- fread(file.path(path, "train", "Y_train.txt"))

##import data on Test
dbSubTest <- fread(file.path(path, "test", "subject_test.txt"))
dbTest <- read.table(file.path(path, "test", "X_test.txt"))
dbTest <- data.table(dbTest)
dbLabTest <- fread(file.path(path, "test", "Y_test.txt"))

##get data of Features 
dbFeatures <- fread(file.path(path, "features.txt"))
setnames(dbFeatures, names(dbFeatures), c("featureCode", "feature"))
dbFeatures <- dbFeatures[grepl("mean\\(\\)|std\\(\\)", feature)]
dbFeatures$featureVNum <- dbFeatures[, paste0("V", featureCode)]

##get data of Label of Activity 
dbActLabel <- fread(file.path(path, "activity_labels.txt"))
setnames(dbActLabel, names(dbActLabel), c("activityCode", "activity"))


##Merge datasets
dbSubject<- rbind(dbSubTrain, dbSubTest)
setnames(dbSubject, "V1", "subject")
dbLabel<- rbind(dbLabTrain, dbLabTest)
setnames(dbLabel, "V1", "activityCode")
db <- rbind(dbTrain, dbTest)
dbSubject<- cbind(dbSubject, dbLabel)
db<-cbind(dbSubject, db)
setkey(db, subject, activityCode)
select <- c(key(db), dbFeatures$featureVNum)
db<- db[, select, with = FALSE]
db<- merge(db, dbActLabel, by = "activityCode", all.x = TRUE)
setkey(db, subject, activityCode, activity)
db<-data.table(melt(db, key(db), variable.name = "featureVNum"))
db<-merge(db, dbFeatures, by = "featureVNum",all.x = TRUE)

##spilt feature into the different columns
db<-cbind(db,domain=ifelse(substr(db$feature,1,1)=="t","Time",ifelse(substr(db$feature,1,1)=="f","frequency","NA")))
db<-cbind(db,acc_source=ifelse(grepl("Body",db$feature),"Body",ifelse(grepl("Gravity",db$feature),"Gravity","NA")))
db<-cbind(db,instrument=ifelse(grepl("BodyAcc",db$feature),"Accelerometer",ifelse(grepl("BodyGyro",db$feature),"Gyroscope","NA")))
db<-cbind(db,jerk=ifelse(grepl("Jerk",db$feature),"Jerk","NA"))
db<-cbind(db,magnitude=ifelse(grepl("Mag",db$feature),"Magnitude","NA"))
db<-cbind(db,method=ifelse(grepl("mean\\(\\)",db$feature),"mean","std"))
db<-cbind(db,axis=ifelse(grepl("X|Y|Z",substr(db$feature,nchar(db$feature),nchar(db$feature)))
,substr(db$feature,nchar(db$feature),nchar(db$feature)),"NA"))

## average of each variable for each activity and each subject
setkey(db, subject, activity, domain, acc_source, instrument, jerk, magnitude, method, axis)
dataset <- db[, list(count = .N, average = mean(db$value)), by = key(db)]

##export dataset
write.table(dataset,"./dataset.txt")
