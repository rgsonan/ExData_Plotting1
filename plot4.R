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

## Plot4

par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(Global_active_power~DateTime,data=data,type="l",ylab="Global Active Power",xlab="")
plot(Voltage~DateTime,data=data,type="l",ylab="Voltage",xlab="datetime")

with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='red')
  lines(Sub_metering_3~DateTime,col='blue')
}
)

legend("topright", col=c("black", "red", "blue"), cex=0.7,lty=1, lwd=c(1,1,1), bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(Global_reactive_power~DateTime,data=data,type="l",ylab="Global_reactive_power",xlab="datetime")

## save as png file
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
