## Unzip the dataset

zipfilename <- "exdata_data_household_power_consumption.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(filename)){
  unzip(zipfilename) 
}

## Read the data only for the required dates

data <- read.table(filename,
                   col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                   skip=66637,nrows=2880,sep =";",na.strings = "?")

## Remove missing values
data <- data[complete.cases(data),]

## Date formatting
## data$Date <- as.Date(data$Date, "%d/%m/%Y")

##  convert the Date and Time variables to Date/Time classes
DateTime <- paste(data$Date, data$Time)
DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")

## Add DateTime column
data <- cbind(DateTime, data)

## Plot2
plot(Global_active_power~DateTime,data=data,type="l",ylab="Global Active Power (kilowatts)",xlab="")

## save as png file
dev.copy(png,"plot2.png",width=480,height=480)
dev.off()
