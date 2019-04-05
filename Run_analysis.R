if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# trying to unzip the dataset
unzip(zipfile="./data/Dataset.zip",exdir="./data")
#unzip the file in the uci har
path_rf <- file.path("./data" , "UCI HAR Dataset")
files <-list.files(path_rf, recursive=TRUE)
library("data.table", lib.loc="~/R/win-library/3.5")
# After careful understanding of the dataset only some dataset are needed for this analysis. Namely: * Training set * Training labels * Test set * Test labels
# Loading the dataset to be used
xTrain = read.table(file.path(path_rf, 'train', 'x_train.txt'), header=FALSE)
yTrain = read.table(file.path(path_rf, 'train', 'y_train.txt'), header=FALSE)TestSubj = read.table(file.path(path_rf, 'test', 'subject_test.txt'), header=FALSE)
TestSubj = read.table(file.path(path_rf, 'test', 'subject_test.txt'), header=FALSE)
xTest = read.table(file.path(path_rf, 'test', 'x_test.txt'), header=FALSE)
yTest = read.table(file.path(path_rf, 'test', 'y_test.txt'), header=FALSE)
# Merging dataset
DataSet_X <- rbind(xTrain, xTest)
DataSet_Y <- rbind(yTrain, yTest)
DataSet_Subj <- rbind(TrainSubj, TestSubj)
View(DataSet_Subj)
dim(DataSet_X)
dim(DataSet_Y)
dim(DataSet_Subj)
View(DataSet_X)
# Extracts only the measurements on the mean and standard deviation for each measurement.
xDataSet_mean_std <- DataSet_X[, grep("-(mean|std)\\(\\)", read.table(file.path(path_rf, "features.txt")[, 2])]
xDataSet_mean_std <- DataSet_X[, grep("-(mean|std)\\(\\)", read.table(file.path(path_rf, "features.txt"))[, 2])]
names(xDataSet_mean_std) <- read.table(file.path(path_rf, "features.txt"))[grep("-(mean|std)\\(\\)", read.table(file.path(path_rf, "features.txt"))[, 2]), 2]
View(xDataSet_mean_std)
# Using descriptive activity names to name the activities in the data set
DataSet_Y[, 1] <- read.table(file.path(path_rf, "activity_labels.txt"))[yDataSet[, 1], 2]
DataSet_Y[, 1] <- read.table(file.path(path_rf, "activity_labels.txt"))[DataSet_y[, 1], 2]
DataSet_Y[, 1] <- read.table(file.path(path_rf, "activity_labels.txt"))[DataSet_Y[, 1], 2]
names(DataSet_Y) <- "Activity"
View(DataSet_Y)
# Appropriately labelling the data set with descriptive activity names.
names(DataSet_Subj) <- "Subject"
Summary(DataSet_Subj)
summary(DataSet_Subj)
# Combing all dataset as one.
singleDataSet <- cbind(xDataSet_mean_std, DataSet_Y, DataSet_Subj)
# defining the names
names(singleDataSet) <- make.names(names(singleDataSet))
names(singleDataSet) <- gsub('Acc',"Acceleration",names(singleDataSet))
names(singleDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(singleDataSet))
names(singleDataSet) <- gsub('Gyro',"AngularSpeed",names(singleDataSet))
names(singleDataSet) <- gsub('^t',"TimeDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('^f',"FrequencyDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('Mag',"Magnitude",names(singleDataSet))
View(singleDataSet)
# Creating a second independent tidy data set
Data2<-aggregate(. ~Subject + Activity, singleDataSet, mean)
Data2 <-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
View(Data2)


