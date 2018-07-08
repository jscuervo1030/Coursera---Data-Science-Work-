## Exploratory Analysis Programming Assignment Week 1 
## Plotting Course Project 1 
## Juan Sebastian Cuervo 

## First We create a variable with the data in table format and with the separation implied as comma
## We are only concerned about the variables of Sub Mettering
## so we specify the type of the variables as character since the data has missinng values of symbol ? so when we call the function 
## we get expected 'a real', got '?'. To avoid this we load the data as character first 

## Important: I had problems to make the script reproducible in any computer ( make a general coding so the data is downloaded gfrom internet the wd is set and the data read). The script can be executed once
## The data is download and the working directory is established where the data is downloaded
## We load all the data and data types specified as chaarcter 

mydata = read.table("household_power_consumption.txt",sep=";",header=TRUE, colClasses=c("Sub_metering_1"="character","Sub_metering_2"="character","Sub_metering_3"="character", "Global_active_power"="character","Voltage"="character","Global_reactive_power"="character")) 


## We transform the values of ? which corresponds to missing values in the standard missing value format NA

mydata[mydata == "?"] <- NA

## We change the type of the Date variable to Date as recommended by the instructions in the required format

mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")

## Now we transform the data of Submtering Global active and reactive power and voltage  in to numeric for computing

mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

## We only need the data of two specified days so we create a  new data with only the points only correposnding to this dates

Basefechas <- mydata[(mydata$Date=="2007-02-01") | (mydata$Date=="2007-02-02"),]

## With our data already selected, we can plot the required variable  . We create a 
## date variable with all information of the date and we lot each of the variables

Basefechas <- transform(Basefechas, fechacompleta=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## e create a par in order to store all 4 graphs in one single plot

par(mfrow=c(2,2))

## We plot each of the graphs as reproduced in instructions 

plot(Basefechas$fechacompleta,Basefechas$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(Basefechas$fechacompleta,Basefechas$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(Basefechas$fechacompleta,Basefechas$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(Basefechas$fechacompleta,Basefechas$Sub_metering_2,col="red")
lines(Basefechas$fechacompleta,Basefechas$Sub_metering_3,col="blue")

## We add the leyend of the graphs in the top right corener of our graph 

legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), cex=0.75)



plot(Basefechas$fechacompleta,Basefechas$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")



## We open a device to create the Png graph with the histogram

dev.copy(png, file="plot4.png", width= 480, height=480)

## We close the device

dev.off()
