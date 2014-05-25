##Getting and Cleaning Data - Project 1
=======================================

#Process 

1. call the plyr package from my library
2. download the file to your working directory. The file is not included in this code because the assignment specifies that the Samsung data should already be in the wd. 
3. activity labels given to each loaded label in the file
4. assigning fixed table widths to test and train X data sets
5. read test -X and -Y data sets
6. use the join function in package to combine the test data sets
7. read train -X and -Y data sets
8. use the join function in package to combine the train data sets
9. use the rbind function to bind the rows of the train and test data sets to merge tables.
10. appropriately label the data with descriptive activity names
11. extracts the measurements from the dataframe about the mean and std dev. 
12. create an independent tidy dataset that contains the average for each variable in the dataframe. In other words, this code finds the mean for each pair composed of users & moves.
13. bind all columns to form new dataframe
14. write a new dataset onto the working directory into a .txt file

#Variables and Data

In the data provided by Samsung Galaxy smartphone accelerometers, we are able to measure many variable inputs such as:

