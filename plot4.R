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
## Set the data and UI binding
dimension <- t
outputFileName = "plot4.png"
mainLabel = ""
chart1.measure <- ds$Global_active_power
chart1.xLabel <- ""
chart1.yLabel <- "Global Active Power"

chart2.measure <- ds$Voltage
chart2.xLabel <- "datetime"
chart2.yLabel <- "Voltage"

chart3.measures <- cbind(cbind(ds$Sub_metering_1, ds$Sub_metering_2), ds$Sub_metering_3)
chart3.measure.colours <- c("black", "red", "blue")
chart3.xLabel <- ""
chart3.yLabel <- "Energy sub metering"
chart3.legends <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

chart4.measure <- ds$Global_reactive_power
chart4.xLabel <- "datetime"
chart4.yLabel <- "Global_reactive_power"

## Open a PNG deivce to create a PNG file
## and send the output graphic to a file
png(file = outputFileName, width = 480, height = 480)

par(mfrow = c(2, 2))

## Chart upper left
plot(dimension, chart1.measure, type = "l", main = mainLabel, xlab = chart1.xLabel, ylab = chart1.yLabel)

## Chart upper right
plot(dimension, chart2.measure, type="l", xlab = chart2.xLabel, ylab = chart2.yLabel)

## Chart lower left
plot(dimension, chart3.measures[,1], col = chart3.measure.colours[1], type = "l", main = mainLabel, xlab = chart3.xLabel, ylab = chart3.yLabel)
lines(dimension, chart3.measures[,2], col = chart3.measure.colours[2], type = "l")
lines(dimension, chart3.measures[,3], col = chart3.measure.colours[3], type = "l")
legend("topright", chart3.legends, lty=1, lwd=2.5, col = chart3.measure.colours, bty = "n", cex = 0.90)

## Chart lower right
plot(dimension, chart4.measure, type="l", xlab = chart4.xLabel, ylab = chart4.yLabel)

dev.off()