
require(data.table)
require(plyr)

# Load data from files.
features <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Assign column names.
featuresVec <- as.vector(features$V2)
colnames(xTrain) <- featuresVec
colnames(xTest) <- featuresVec
colnames(yTrain) <- c("activityId")
colnames(subjectTrain) <- c("subject")
colnames(yTest) <- c("activityId")
colnames(subjectTest) <- c("subject")

# Add unique ids to the observation.
maxRowCountTrain <- length(xTrain[,1])
maxRowCountTest <- length(xTest[,1])

xTrain$id <- c(1:maxRowCountTrain)
yTrain$id <- c(1:maxRowCountTrain)
subjectTrain$id <- c(1:maxRowCountTrain)

xTest$id <- c(1:maxRowCountTest)
yTest$id <- c(1:maxRowCountTest)
subjectTest$id <- c(1:maxRowCountTest)

# Combine the data datasets
trainDataSet <- join_all(list(subjectTrain, yTrain, xTrain),by="id")
testDataSet <- join_all(list(subjectTest, yTest, xTest),by="id")

# Merge the train and test dataset into one dataset.
mergedDataSet <- rbind(trainDataSet, testDataSet)

regExVec <- c(".*mean\\(\\)", ".*std\\(\\)")
filteredFeatures <- unique(grep(paste(regExVec, collapse="|"),features$V2, value=TRUE))
filteredDataSet <- mergedDataSet[, c("id", "activityId", "subject", filteredFeatures)]

# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names.
colnames(activityLabels) <- c("id", "activity")
labeledDataSet <- merge(filteredDataSet, activityLabels, by.x="activityId", by.y="id",all=FALSE)

# Clean labelDataSet
drops <- c("activityId", "id")
cleanedDataSet <- labeledDataSet[, !(names(labeledDataSet) %in% drops)]

# Convert the cleanedDataSet to a data table and create the final tidy dataset.
cleanedDataTable <- data.table(cleanedDataSet)
tidyDataSet <- cleanedDataTable[, lapply(.SD, mean), by=c("activity", "subject")]

# Write tidyDataSet to file.
write.table(tidyDataSet, file="tidyDataSet.txt")