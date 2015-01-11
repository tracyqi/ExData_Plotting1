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
PlotFile <- "plot2.png"

##2. Read data
power <- read.table("Data/household_power_consumption.txt", sep=";", header = T)
power$Date <- as.Date( as.character(power$Date), "%d/%m/%Y")

##3. Get subset of data
filterByDate <- function(x,y) { power[power$Date >= x & power$Date <= y,]}
subPower <- filterByDate(DateFrom, DateTo)

##4. Prepare data
subPower$Global_active_power <- as.numeric(as.character(subPower$Global_active_power))
subPower <- transform(subPower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##5. Plot the png
png(PlotFile, width=480, height=480)
plot(subPower$timestamp, subPower$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##6. Clean up
dev.off()