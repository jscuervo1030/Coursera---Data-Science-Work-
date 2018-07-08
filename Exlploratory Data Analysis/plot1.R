## Exploratory Analysis Programming Assignment Week 1 
## Plotting Course Project 1 
## Juan Sebastian Cuervo 

## First We create a variable with the data in table format and with the separation implied as comma
## We are only concerned about the variable global active power 
## so we specify the type of the variable as character since the data has missinng values of symbol ? so when we call the function 
## we get expected 'a real', got '?'. To avoid this we load the data as character first 

## Important: I had problems to make the script reproducible in any computer ( make a general coding so the data is downloaded gfrom internet the wd is set and the data read). The script can be executed once
## he data is download and the working directory is established where the data is downloaded


mydata = read.table("household_power_consumption.txt",sep=";",header=TRUE, colClasses=c("Global_active_power"="character")) 


## We transform the values of ? which corresponds to missing values in the standard missing value format NA

mydata[mydata == "?"] <- NA

## We change the type of the Date variable to Date as recommended by the instructions in the required format

mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")

## Now we transform the data of the Global active power variable in to numeric for computing

mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

## We only need the data of two specified days so we create a  new data with only the points only correposnding to this dates

Basefechas <- mydata[(mydata$Date=="2007-02-01") | (mydata$Date=="2007-02-02"),]

## With our data already selected, we can plot the required variable with a histogram . 

hist(Basefechas$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")

## We open a device to create the Png graph with the histogram

dev.copy(png, file="plot1.png", width= 480, height=480)

## We close the device

dev.off()
