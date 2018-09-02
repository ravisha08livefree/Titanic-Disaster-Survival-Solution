setwd("C:/Course era/Assignments/KAGGLE Titanic Disaster")
library(randomForest)

#Loading csv files
titanic.train <- read.csv(file = "train.csv", header = TRUE, stringsAsFactors = FALSE)
titanic.test <- read.csv(file = "test.csv", header = TRUE, stringsAsFactors = FALSE)

names(titanic.test)
names(titanic.train)

#We find that survived column is missing in test
titanic.test$Survived <- NA

#Creating a flag to differntiate test and train set
titanic.test$isTest <- TRUE
titanic.train$isTest <- FALSE

#appending train and test data sets
titanic.data <- rbind(titanic.test,titanic.train)
tail(titanic.data,n=10)
names(titanic.data)

#checking various variables in new appended data set and filling the missing values
table(titanic.data$isTest)
table(titanic.data$Embarked) #2 Missing values
    titanic.data[titanic.data$Embarked == '',"Embarked"] <- "C"
table(is.na(titanic.data$Age)) # 263 missing values
    titanic.data[is.na(titanic.data$Age),"Age"] <- mean(titanic.data$Age, na.rm = TRUE)
table(is.na(titanic.data$Fare)) # 1 missing value
    titanic.data[is.na(titanic.data$Fare),"Fare"] <- mean(titanic.data$Fare, na.rm = TRUE)
table(titanic.data$SibSp)
table(titanic.data$Parch)
table(titanic.data$Pclass)

#Converting some of the varibale in factor format to improve performance of model
str(titanic.data)
titanic.data$Pclass <- as.factor(titanic.data$Pclass) 
titanic.data$Sex <- as.factor(titanic.data$Sex) 
titanic.data$SibSp <- as.factor(titanic.data$SibSp) 
titanic.data$Parch <- as.factor(titanic.data$Parch) 
titanic.data$Embarked <- as.factor(titanic.data$Embarked) 

#Now are observations are cleaned an filled, diving the set back into train and test
titanic.test <- titanic.data[titanic.data$isTest == "TRUE",]
titanic.train <- titanic.data[titanic.data$isTest == "FALSE",]

#Dont forget to categorize Survived into category as well
# We will categorize after splitting because w dont NA to be part of a category, as only 0,1 are only possiblities
titanic.train$Survived <- as.factor(titanic.train$Survived)


# Building model
model <- randomForest(Survived ~ Pclass + Sex + SibSp + Parch + Embarked + Age + Fare, data = titanic.train, ntree = 500, mtry = 4, nodesize = 0.01* nrow(titanic.train))

#Predicting the values 
Survived <- predict(model, newdata = titanic.test)
PassengerId <- titanic.test$PassengerId

output.df <- as.data.frame(PassengerId)
output.df$Survived <- Survived

#Store into CSV
write.csv(output.df, file = "Titanic Disaster Final Output.csv", row.names = FALSE)
