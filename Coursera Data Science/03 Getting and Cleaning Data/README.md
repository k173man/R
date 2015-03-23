How to use the **run_analysis.R** script
----------------------------------------
The **run_analysis.R** script uses the UCI HAR Dataset to produce a the Tidy Dataset.  The easiest way to use the script is to simply loaded into an R environment, e.g. RStudio, and run it.  However, there are a few dependencies/requirements.

1. An internet connection for downloading the data and, if necessary, downloading R packages
2. R packages
  1. data.table
  2. dplyr

The **run_analysis.R** script will do the following:

1. Download the UCI HAR Dataset.zip file to your working directory
2. Decompressed UCI HAR Dataset.zip
    1. The contents of UCI HAR Dataset.zip will be placed in directory called UCI HAR Dataset
	2. The UCI HAR Dataset directory will be located in your working directory
3. Using the data files contained in the UCI HAR Dataset directory, the script will produce a file called Tidy_Dataset.txt
    1. The Tidy_Dataset.txt file will be located in your working directory

The decompressed UCI HAR Dataset.zip file results in the directory structure and files shown below (files have a .txt extension, everything else is a directory). The UCI HAR Dataset directory will be located in your working directory.
*Your Working Directory*
* UCI HAR Dataset
 * activity_labels.txt
 * features.txt
 * features_info.txt
 * README.txt
 * test
    * subject_test.txt
    * X_test.txt
    * y_test.txt
    * Inertial Signals
        * body_acc_x_test.txt
        * body_acc_y_test.txt
        * body_acc_z_test.txt
        * body_gyro_x_test.txt
        * body_gyro_y_test.txt
        * body_gyro_z_test.txt
        * total_acc_x_test.txt
        * total_acc_y_test.txt
        * total_acc_z_test.txt
    * train
     * subject_test.txt
     * X_test.txt
     * y_test.txt
     * Inertial Signals
         * body_acc_x_test.txt
         * body_acc_y_test.txt
         * body_acc_z_test.txt
         * body_gyro_x_test.txt
         * body_gyro_y_test.txt
         * body_gyro_z_test.txt
         * total_acc_x_test.txt
         * total_acc_y_test.txt
         * total_acc_z_test.txt

Optional - How to Skip Automatic File Download
----------------------------------------------
If you already have the contents of UCI HAR Dataset.zip in you working directory, you can comment out lines 6-8 to prevent the file from being downloaded and decompressed.  If you comment out lines 6-8, make sure there is a subdirectory in your working directory, called UCI HAR Dataset, with the directory/file structure detail above.  It is also acceptable to have the file located directly beneath your working directory, i.e. not contained in the UCI HAR Dataset directory.
