## Code Book Getting Cleaning Data - Course Project -

# JUAN SEBASTIAN CUERVO SANCHEZ

The following document describes the procedure done to obtain the tidy data set as well as a description of the 
intermediate variables created. The attached" README.md" file shows the script in R that executes the desired output 

## Data Description

The base presented in this work is an analysis of the data of Samsung Galaxy Smartphone accelerometer. The purpose of this data is to register human activity, moving and workout along the day and to catch important information for Sports and Training Product Developments. The data registered was taken by work with 30 volunteers in 6 activities ( walking, satnding and laying in different ways) with the smartphone accelerometer and gyroscope. The data captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

## Initial Charge of Data

As shown in the "README.md" the first three chunks of code perform the following operations

1. Calling of the Required R packahge Libraries (lines 9 and 10)
2. Download URL Daa from Coursera Web Page Getting Cleaning Data Course
3. Unzipping the Required documents in the working directory of R 

## Variables and Execution Code 

## Data loading of Train and Test 

We first read the .txt data files and we order the data by the following variables: 

1. Trainsujetos = Data frame that represents the subjects of the training sessions
2. Trainvalores = Table representing the X dimension accelaration values of acceloremeter for Train 
3. Trainactividad = Table representing the Y dimension accelaration values of acceloremeter for Train 

4. Testsujetos = Data frame that represents the subjects of the tEST sessions
5. Testvalores = Table representing the dimension accelaration values of acceloremeter for Train 
6. Testactividad = Table representing the activity values. 

## Manipulating Data Features and Labes

As the labels of the activities are stored in different txt files, we uploaded the information with the following variable commnads

1 caracteris : The variables stores the features labels for the activities
2. actividades: The variables stores the activity labels of the 6 works done by participants in study

Once we load the activities data, we establish the column data headers corresponding to this information in particular, the Activity Id and The Activity Label variables 

## Mergin Process

Using the rbind and cbind cominds we merge Train and Test data "personasact" variable"" 

## Obtaining Mean and Standard Deviation variables 

We only store the required values stated by the instructions: Mean and Standar Deviation throyugh the manipulation of the values 

guardarcol <- grepl("subject|activity|mean|std", colnames(personasact))
personasact <- personasact[, guardarcol]

1. Guardacol: Stores the values of means and std of the original data base and removes extra data 

## Gruping by suject and Activity and Mean

The final variable

1. Mediaspersonact = Summarizes value means of personact variable by suject and activity

## Output data 

We end by doing output

write.table(Mediaspersonact, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)



