## Script - Course Project - Getting and Cleaning Data 
## Juan Sebastian Cuervo Sanchez

##The following instructions show the procedure done for the Course Project 

## Please I refer to the Readme and the Codebook in order to explain detail info of the transformations and the
##manipulation of the data


## Load required libraries for Windows usage of R ( %>% pipeline operator and magritrr)


library(dplyr)

## Magittr calculation package

library(magrittr)


## Download data from system or from web page of Coursera

## Creates an object with the Zip File . If the object doesnt exists, the variable "archivo" is null. The Url data variable
## stores the URL of Coursera data base

archivo <- "UCI HAR Dataset.zip"
urldata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


## The data is downloaded if archivo is null


if (!file.exists(archivo))
{
  
  download.file(urldata, archivo, mode ="wb")
}  

## If the folder of data is not created it Unzips the data downloaded

carpetadata <- "UCI HAR Dataset"

if (!file.exists(carpetadata)) 
{ 
  unzip(archivo) 
}
## Loading the data of Train and Test
## Train data LOADING ..

Trainsujetos <- read.table(file.path(carpetadata, "train", "subject_train.txt"))
Trainvalores <- read.table(file.path(carpetadata, "train", "X_train.txt"))
Trainactividad <- read.table(file.path(carpetadata, "train", "y_train.txt"))

## Test data LOADING ....

Testsujetos <- read.table(file.path(carpetadata, "test", "subject_test.txt"))
Testvalores <- read.table(file.path(carpetadata, "test", "X_test.txt"))
Testactividad <- read.table(file.path(carpetadata, "test", "y_test.txt"))

## Read the labels of features 

caracteris <- read.table(file.path(carpetadata, "features.txt"), as.is = TRUE)

## Read the labels of activity using the identifiers

actividades <- read.table(file.path(carpetadata, "activity_labels.txt"))
colnames(actividades) <- c("activityId", "activityLabel")

## Process for Merging the Data of people activity 
## The merge colpases the data through the c and rbind parameters. 

personasact <- rbind(cbind(Trainsujetos,Trainvalores,Trainactividad),cbind(Testsujetos,Testvalores,Testactividad))
colnames(personasact) <- c("subject", caracteris[,2],"activity")


## Obtain the Means and The Standard Deviation Data. 

## We store only this information and leave out the extra information not rquired statistics with "grepl


guardarcol <- grepl("subject|activity|mean|std", colnames(personasact))
personasact <- personasact[, guardarcol]


# replace activity values with named factor levels

personasact$activity <- factor(personasact$activity, levels = actividades[,1], labels = actividades[, 2])

# Columns names

Colpersonasact <- colnames(personasact)

# use new labels as column names
colnames(personasact) <- Colpersonasact 

# group by subject and activity and summarise using mean
Mediaspersonact <- personasact %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# output to file "tidy_data.txt"
write.table(Mediaspersonact, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

