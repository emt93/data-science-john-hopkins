##call the plyr package from my library
library("plyr")

##download the file to your working directory. The file is not included in this code because the assignment specifies that the Samsung data should already be in the wd. 

##activity labels given to each loaded label in the file
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = " ")
names(activitylabels) <- c("move_index","move_label")

##assigning fixed table widths to test and train X data sets
width <- c(-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15,-1,15)

##read test -X and -Y data sets
datatestX <- read.fwf("UCI HAR Dataset/test/X_test.txt", width, skip=0)

datatestY <- read.table("UCI HAR Dataset/test/Y_test.txt", sep = " ")
names(datatestY) <- "move_index"

subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = " ")
names(subjecttest) <- "User_name"

##use the join function in package to combine the test data sets
movestest <- arrange(join(datatestY,activitylabels), move_index)
movestest <- cbind(subjecttest,movestest, datatestX)

##read train -X and -Y data sets
datatrainX <- read.fwf("UCI HAR Dataset/train/X_train.txt", width, skip=0)

datatrainY <- read.table("UCI HAR Dataset/train/Y_train.txt", sep =" ")
names(datatrainY) <- "move_index"

subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", sep =" ")
names(subjecttrain) <- "User_name"

##use the join function in package to combine the train data sets
movestrain <- arrange(join(datatrainY,activitylabels),move_index)
movestrain <- cbind(subjecttrain,movestrain,datatrainX)

##use the rbind function to bind the rows of the train and test data sets to merge tables.
usersmoves <- rbind(movestrain, movestest)

##appropriately label the data with descriptive activity names
header <- c("users", "moves_ref", "move", "mean", "std", "mad", "max", "min", "sma", "energy", "iqr", "entropy", "arCoeff", "correlation", "maxInds", "meanFreq", "skewness", "kurtosis", "bandsEnergy", "angle")
names(usersmoves) <- header

##extracts the measurements from the dataframe about the mean and std dev. 
extract <- data.frame(usersmoves$users,usersmoves$move,usersmoves$mean,usersmoves$std)

##create an independent tidy dataset that contains the average for each variable in the dataframe. In other words, this code finds the mean for each pair composed of users & moves.
newdata <- NULL
tempMean <- ddply(usersmoves, .(users,move), summarize, mean=(mean(mean)))
tempStd <- ddply(usersmoves, .(users,move), summarize, mean=(mean(std)))[,3]
tempMad <- ddply(usersmoves, .(users,move), summarize, mean=(mean(mad)))[,3]
tempMax <- ddply(usersmoves, .(users,move), summarize, mean=(mean(max)))[,3]
tempMin <- ddply(usersmoves, .(users,move), summarize, mean=(mean(min)))[,3]
tempSma <- ddply(usersmoves, .(users,move), summarize, mean=(mean(sma)))[,3]
tempEnergy <- ddply(usersmoves, .(users,move), summarize, mean=(mean(energy)))[,3]
tempIqr <- ddply(usersmoves, .(users,move), summarize, mean=(mean(iqr)))[,3]
tempEntropy <- ddply(usersmoves, .(users,move), summarize, mean=(mean(entropy)))[,3]
tempArCoeff <- ddply(usersmoves, .(users,move), summarize, mean=(mean(arCoeff)))[,3]
tempCorrelation <- ddply(usersmoves, .(users,move), summarize, mean=(mean(correlation)))[,3]
tempMaxInds <- ddply(usersmoves, .(users,move), summarize, mean=(mean(maxInds)))[,3]
tempMeanFreq <- ddply(usersmoves, .(users,move), summarize, mean=(mean(meanFreq)))[,3]
tempSkewness <- ddply(usersmoves, .(users,move), summarize, mean=(mean(skewness)))[,3]
tempKurtosis <- ddply(usersmoves, .(users,move), summarize, mean=(mean(kurtosis)))[,3]
tempBandsEnergy <- ddply(usersmoves, .(users,move), summarize, mean=(mean(bandsEnergy)))[,3]
tempAngle <- ddply(usersmoves, .(users,move), summarize, mean=(mean(angle)))[,3]

##bind all columns to form new dataframe
newdata <- cbind(tempMean,tempStd,tempMad,tempMax,tempMin,tempSma,tempEnergy,tempIqr,tempEntropy,tempArCoeff,tempCorrelation,tempMaxInds,tempMeanFreq,tempSkewness,tempKurtosis,tempBandsEnergy,tempAngle)
n <- c(names(usersmoves)[1],names(usersmoves)[3:length(names(usersmoves))])
names(newdata) <- n

write.table(newdata, file = "TidyDataSet.txt", sep="\t")
