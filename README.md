# Titanic-Disaster-Survival-Solution - Machine Learning
Titanic Disaster survival analysis using R

## Problem Statement:
Using Machine learning algortithms we have to predict exactly which passenger is going to survive. Decision parameters are Age, Sex, Class, Family Size etc.
Two data sets were provided - Test and Train. Train your model on Train_Dataset and predict the survival on Test_Dataset.

## Solution:
1. Load the train and test data set in R using read.csv
2. Before appending these files for data processing, create a flag to distinguish between test data and train data.
3. Append the files and find the missing columns.
4. Missing values will be replaced either by the mean or median of rest of the data. Median is more preferrable to use because mean is sensitive to outliers.
5. Replace the missing values with median.
6. Split the data again based on the falg we created in Step 2.
7. Convert all variables that can be converted in categorical values using forced Coercion.
8. Scale your model to be trained better.
9. USe random Forest classifier to train your model.
10. Check your accuracy using confusion matrix
11. Predict your survival for test_dataset using predict().


