## Set all data sources and load all required
## librarbies used by the R script.
setwd("~/Coursera/Exploratory Data Analysis")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "household_power_consumption.zip"
download.file(url, f)
library(data.table, chron, lubridate)

###########################
## Loading data into memory
###########################
## Read data into data table
dt <- fread("household_power_consumption.txt")

## Subset only the records within the required
## date range over a 2-day period in February, 
## 2007.
## Convert columns to the correct data type
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")
ds <- dt[(dt$Date >= "2007-02-01" & dt$Date <= "2007-02-02"), ]
ds$Time <- chron::times(ds$Time)
ds$Global_active_power <- as.numeric(ds$Global_active_power)
ds$Global_reactive_power <- as.numeric(ds$Global_reactive_power)
ds$Global_intensity <- as.numeric(ds$Global_intensity)
ds$Voltage <- as.numeric(ds$Voltage)
ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)

## Read date/time info into a single column
## in format 'm/d/y h:m:s'
dates <- as.character(ds$Date)
times <- as.character(ds$Time)
x <- paste(dates, times)
t <- strptime(x, "%Y-%m-%d %H:%M:%S")

#####################
## Data visualization
#####################
## Set parameters for the chart
outputFileName = "plot2.png"
yLabel = "Global Active Power (kilowatts)"
xLabel = ""
mainLabel = ""
measure <- ds$Global_active_power
dimension <- t

## Open a PNG deivce to create a PNG file
## and send the output graphic to a file
png(file = outputFileName, width = 480, height = 480)
plot(dimension, measure, type = "l", main = mainLabel, ylab = yLabel, xlab = xLabel)
dev.off()