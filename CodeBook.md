Step 1: Download all relevant datasets from the respective txt files i.e. "X_test.txt", "X_train.txt", "Y_test.txt", "Y_train.tx", "subject_test.txt", "subject_train.txt", "activity_labels.txt", & "features.txt"

Step 2: Save the column names from features.txt into a vector. Assign the test & training datasets the variable names. Assign appropriate variable names to all other datasets as well.

Step 3: Combine the activity labels with the test & training datasets respectively. Bind test and training datasets.

Step 4: Filter two datasets with columns containing mean & standard deviation variables. Filter dataset with activity and subject variables. Combine the mean & standard deviation datasets.

Step 5: Change variable names to be more descriptive.

Step 6: Add back activity and subject columns. 

Step 7: Merge dataset with activity descriptions joining on the activity label & drop the label column.

Step 8: Create datasets grouped by activity & subject respectively. Change the variable name to "Activity/Subject". Bind both datasets.

