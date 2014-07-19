Codebook
========

Datasets
------------------------------

Dataset name     | Description
-----------------|------------
dataset          | A tidy dataset
db               | merge dbSubject, dbTest, dbTrain, dbActLabel, dbFeatures and dbLabel 
dbActLabel       | activity_labels.txt
dbFeatures       | features.txt
dbLabTest        | Y_test.txt
dbLabTrain       | Y_train.txt
dbLabel          | merge dbLabTrain and dbLabTest
dbSubTest        | subject_test.txt
dbSubTrain       | subject_train.txt
dbSubject        | merge dbSubTest and dbSubTrai
dbTest           | X_test.txt
dbTrain          | X_train.txt



The Specification of Dataset Level
------------------------------

Variable name    | Description
-----------------|------------
subject          | subject ID
activity         | Activity catagories
domain           | Feature: domain
acc_source       | Feature: signal source (Body/Gravity)
instrument       | Feature: Measuring instrument (Accelerometer/Gyroscope)
jerk             | Feature: Jerk signal
magnitude        | Feature: Magnitude
method           | Feature: statistic method(mean/std)
axis             | Feature: 3-axial signals in the X, Y and Z directions 
count            | Count of data points per each activity and each subject
average          | Average of values per each activity and each subject



The Specification of Value Level
------------------------------

Variable name    | Attribution| Value
-----------------| -----------|-------
subject          | Integer    | 1-30
activity         | String     |LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS and WALKING_UPSTAIRS
domain           | String     | Time and frequency
acc_source       | String     | Body, Gravity
instrument       | String     | Accelerometer, Gyroscope and NA
jerk             | String     | Jerk and NA
magnitude        | String     | Magnitude and NA
method           | String     | mean and std
axis             | String     | X, Y, Z and NA 
count            | Integer    | Count of data points per each activity and each subject
average          | Number     | Average of values per each activity and each subject

or 
>str(dataset) in the R
