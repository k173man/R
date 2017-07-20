CodeBook for the Tidy Dataset project
=====================================

Data source
-----------
The Tidy dataset was derived from the UCI HAR Dataset.  The UCI HAR Dataset is contained in a file call UCI HAR Dataset.zip, which can be found at http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip.  Additional information about the UCI HAR Dataset, and the associated experiment, "Human Activity Recognition Using Smartphones", can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Raw Data - UCI HAR Dataset
--------------------------
The information below pertaining to the original dataset was taken from the README and features_info.txt files, which can be found in UCI HAR Dataset.zip.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Each variable (measurement) name is composed using some combination of the following:
* t - A t for the first letter of the variable name indicates time domain
* t - A f for the first letter of the variable name indicates frequency domain
* Acc - indicates an accelerometer measurement
* Gyro - indicates a gyroscopic measurement
* Body - indicates the variable measures body movement
* Gravity - indicates the variable measures acceleration related to gravity
* Jerk - indicates the variable measures sudden movement acceleration
* Mag - indicates the variable measures the magnitude of a given movement
* X - indicates the variable measurement is for the X-axis
* Y - indicates the variable measurement is for the Y-axis
* Z - indicates the variable measurement is for the Z-axis

The units for measurements from the accelerometer are standard gravity units (G's), and the unit for measurement from the gyroscope are radians/second.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The UCI HAR Dataset has been divided into two datasets (train and test), using a 70/30 split
Features are normalized and bounded within [-1,1]

Tidy Dataset
------------
Features selected for the Tidy Dataset consist of measurements on the mean and standard deviation for each signal measurements from the UCI HAR Dataset, in addition to the SubjectId and the Activity.  SubjectId is an integer, which indicates the subject for the associated set measurements; possible values for SubjectId are 1 through 30. Activity is a character variable, which indicates the activity associated with a set of measurements; possible values for Activity are: Laying, Sitting, Standing, Walking, Walking, Downstairs, Walking, Upstairs. The metadata for the remaining variables are the same as in the original dataset, which is detailed above.  A complete list of the variables in the Tidy Dataset is given below.

###Transformations
As mentioned above, the UCI HAR Dataset was divided into two datasets (train and test), using a 70/30 split. Each dataset has a file containing the associated test subject identifiers, and a file containing the associated activity identifiers.
The Tidy Dataset was constructed using the following transformations:

1. For each dataset (train and test), the measurements were joined (merged) to the associated subject identifiers and activity identifiers
2. The train and test datasets were unioned to create a new dataset, called trainTest
3. Using the criteria provided for the Course Project, values provided in the features.txt were used to determine which variables to select for the Tidy Dataset
  1. This resulted in a new dataset called meanStdData, which was based on the trainTest dataset
  2. The meanStdData dataset contains all of the observations (rows) from the trainTest dataset; however, it contains a subset of the columns (variables)
4. Values provided in the features.txt file were cleaned up (parenthesis were removed), and then used to rename the columns in the meanStdData dataset
5. The meanStdData dataset was used to create the tidyData dataset, which consists of the average of each variable for each activity and each subject



###Feature List

1. SubjectId
2. Activity
3. tBodyAcc-mean-X
4. tBodyAcc-mean-Y
5. tBodyAcc-mean-Z
6. tBodyAcc-std-X
7. tBodyAcc-std-Y
8. tBodyAcc-std-Z
9. tGravityAcc-mean-X
10. tGravityAcc-mean-Y
11. tGravityAcc-mean-Z
12. tGravityAcc-std-X
13. tGravityAcc-std-Y
14. tGravityAcc-std-Z
15. tBodyAccJerk-mean-X
16. tBodyAccJerk-mean-Y
17. tBodyAccJerk-mean-Z
18. tBodyAccJerk-std-X
19. tBodyAccJerk-std-Y
20. tBodyAccJerk-std-Z
21. tBodyGyro-mean-X
22. tBodyGyro-mean-Y
23. tBodyGyro-mean-Z
24. tBodyGyro-std-X
25. tBodyGyro-std-Y
26. tBodyGyro-std-Z
27. tBodyGyroJerk-mean-X
28. tBodyGyroJerk-mean-Y
29. tBodyGyroJerk-mean-Z
30. tBodyGyroJerk-std-X
31. tBodyGyroJerk-std-Y
32. tBodyGyroJerk-std-Z
33. tBodyAccMag-mean
34. tBodyAccMag-std
35. tGravityAccMag-mean
36. tGravityAccMag-std
37. tBodyAccJerkMag-mean
38. tBodyAccJerkMag-std
39. tBodyGyroMag-mean
40. tBodyGyroMag-std
41. tBodyGyroJerkMag-mean
42. tBodyGyroJerkMag-std
43. fBodyAcc-mean-X
44. fBodyAcc-mean-Y
45. fBodyAcc-mean-Z
46. fBodyAcc-std-X
47. fBodyAcc-std-Y
48. fBodyAcc-std-Z
49. fBodyAcc-meanFreq-X
50. fBodyAcc-meanFreq-Y
51. fBodyAcc-meanFreq-Z
52. fBodyAccJerk-mean-X
53. fBodyAccJerk-mean-Y
54. fBodyAccJerk-mean-Z
55. fBodyAccJerk-std-X
56. fBodyAccJerk-std-Y
57. fBodyAccJerk-std-Z
58. fBodyAccJerk-meanFreq-X
59. fBodyAccJerk-meanFreq-Y
60. fBodyAccJerk-meanFreq-Z
61. fBodyGyro-mean-X
62. fBodyGyro-mean-Y
63. fBodyGyro-mean-Z
64. fBodyGyro-std-X
65. fBodyGyro-std-Y
66. fBodyGyro-std-Z
67. fBodyGyro-meanFreq-X
68. fBodyGyro-meanFreq-Y
69. fBodyGyro-meanFreq-Z
70. fBodyAccMag-mean
71. fBodyAccMag-std
72. fBodyAccMag-meanFreq
73. fBodyBodyAccJerkMag-mean
74. fBodyBodyAccJerkMag-std
75. fBodyBodyAccJerkMag-meanFreq
76. fBodyBodyGyroMag-mean
77. fBodyBodyGyroMag-std
78. fBodyBodyGyroMag-meanFreq
79. fBodyBodyGyroJerkMag-mean
80. fBodyBodyGyroJerkMag-std
81. fBodyBodyGyroJerkMag-meanFreq
