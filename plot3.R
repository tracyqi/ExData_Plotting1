## Exploratory Data Analysis
## Course Project 1

## Purpose
##1. Load the dataset
##2. Estimte the size
##3. subset the ata
##4. plot

## Note before run thi script
##1. file dependency
##  data file should be under \Data foler

#######################################################################
##1. Set variables
DateFrom <-  as.Date( as.character("2007-02-01"), "%Y-%m-%d")
DateTo <-  as.Date( as.character("2007-02-02"), "%Y-%m-%d")
PlotFile <- "plot3.png"

##2. Read data
power <- read.table("Data/household_power_consumption.txt", sep=";", header = T)
power$Date <- as.Date( as.character(power$Date), "%d/%m/%Y")

##3. Get subset of data
filterByDate <- function(x,y) { power[power$Date >= x & power$Date <= y,]}
subPower <- filterByDate(DateFrom, DateTo)

##4. Prepare data
subPower$Global_active_power <- as.numeric(as.character(subPower$Global_active_power))
subPower <- transform(subPower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
subPower$Sub_metering_1 <- as.numeric(as.character(subPower$Sub_metering_1))
subPower$Sub_metering_2 <- as.numeric(as.character(subPower$Sub_metering_2))
subPower$Sub_metering_3 <- as.numeric(as.character(subPower$Sub_metering_3))
#head(subPower)

##6. Plot the png
png(PlotFile, width=480, height=480)

plot(subPower$timestamp,subPower$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subPower$timestamp,subPower$Sub_metering_2, col="red")
lines(subPower$timestamp,subPower$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))

##6. Clean up
dev.off()