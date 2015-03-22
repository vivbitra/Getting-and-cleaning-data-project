# Vivek Vardhan Bitra
#--------------------------------------------------
rm(list = ls())
# 1 Merges the training and the test sets to create one data set.
# setting directory of input files
setwd('E:\\Rprogramming\\UCI HAR Dataset');
# read data from the files
features = read.table('./features.txt',header=FALSE);
activitylabels = read.table('./activity_labels.txt',header=FALSE);
# reading data from the train files
subjecttrain = read.table('./train/subject_train.txt',header=FALSE); #details of subjects
xtrain = read.table('./train/x_train.txt',header=FALSE); # imports x-train data
ytrain = read.table('./train/y_train.txt',header=FALSE); # imports y-train data
# reading data from the test files
subjecttest = read.table('./test/subject_test.txt',header=FALSE); 
xtest = read.table('./test/x_test.txt',header=FALSE);
ytest = read.table('./test/y_test.txt',header=FALSE);

# assign column names to each train data read
colnames(activitylabels)  = c('activityId','activitylabels');
colnames(subjecttrain)  = "subjectId";
colnames(xtrain)        = features[,2]; 
colnames(ytrain)        = "activityId";
# asswign column names to each test data read
colnames(subjecttest) = "subjectId";
colnames(xtest)       = features[,2]; 
colnames(ytest)       = "activityId";

# combining the datasets
# creating final train dataset
trainData = cbind(ytrain,subjecttrain,xtrain);
# creating final test dataset
testData = cbind(ytest,subjecttest,xtest);
# Combine training and test data to create final data
finalData = rbind(trainData,testData);

# create vector of column names that can be used for searching 
colNames  = colnames(finalData); 

#-----------------------------------------------------------



# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a vector that contains TRUE values for the ID, mean, std columns and FALSE for others
subsetvector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on above values

finalData = finalData[subsetvector==TRUE];


#--------------------------------------------------------------

# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activitylabels,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData); 

#-----------------------------------------------------------------




# 4. Appropriately label the data set with descriptive activity names. 

# change the variable name to clean up
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new column names
colnames(finalData) = colNames;

#----------------------------------------------------------------------------


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, finalData1 without the activitylabels column
finalData1  = finalData[,names(finalData) != 'activitylabels'];

# change the finalData1 table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(finalData1[,names(finalData1) != c('activityId','subjectId')],by=list(activityId=finalData1$activityId,subjectId = finalData1$subjectId),mean);
tidyData = signif(tidyData,5);
# Merging the tidyData with activitylabels
tidyData    = merge(tidyData,activitylabels,by='activityId',all.x=TRUE);

# create a text file with tidydata table
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep="\t");
