library(tidyverse)

if(!file.exists("Course Assignement")){
        dir.create("Course Assignment")
}

### Download data from url and save in specified directory.
data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "./Course Assignment/wearable.zip",
                      method = "curl")

### Unzip the data in the specified directory.
data2<- unzip("./Course Assignment/wearable.zip", files=NULL, exdir = "./Course Assignment")

### Set working directory
setwd("./Course Assignment/UCI HAR Dataset")

### Import training data-sets
X_train <- as_tibble(read.table("./train/X_train.txt"))
y_train <- read.table("./train/y_train.txt")
s_train <- read.table("./train/subject_train.txt") %>%
           rename(Subjects=V1)

### Import test data-sets
X_test <- as_tibble(read.table("./test/X_test.txt"))
y_test <- read.table("./test/y_test.txt")
s_test <- read.table("./test/subject_test.txt") %>%
          rename(Subjects=V1)

### Read activity labels data and merge with the y data-sets to 
### convert from numeric to descriptive forms of activity
activity <- read.table("activity_labels.txt") 
y_train2 <- merge(y_train, activity, by="V1")
y_test2 <- merge(y_test, activity, by="V1")

### Import features from accelerometer and gyroscope signals and use them as column names  
feature <- read.table("features.txt") %>%
           rename(Features=V2)

colnames(X_train)  <- as.vector(feature$Features)
colnames(X_test)  <- as.vector(feature$Features)

### Combine subject info, activity info and measurements for training and testing data sets
Atrain <- cbind(s_train, Activity=y_train2[,2], X_train) 
Atest  <- cbind(s_test, Activity=y_test2[,2], X_test)

## COmbine the training and testing data together
all_data <- rbind(Atrain, Atest)

cols <- which(grepl("mean|std.*", colnames(all_data)))
all_d <- all_data[,c(1,2,cols)]

colnames(all_d) <- gsub("[()]", "", colnames(all_d))
all_d$Activity <- as.factor(all_d$Activity)


### Load reshape library
library(reshape2)

### Convert wide format data to long format
longData <- melt(all_d, id.vars = c("Subjects", "Activity"), na.rm = TRUE)

### Reshape data into a tidy data-set taking the average 
### value of each measurement for each subject and activity
avData <- as_tibble(dcast(longData, Subjects + Activity ~ variable, fun=mean))

### Export dataset as a .txt (tab dlimited) file
write.table(avData, "AverageData.txt", row.names = FALSE, quote = FALSE, col.names = TRUE, sep="\t")
