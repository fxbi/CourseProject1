## Set all data sources and load all required
## librarbies used by the R script.
setwd("~/Coursera/Exploratory Data Analysis")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "household_power_consumption.zip"
install.packages("data.table")
download.file(url, f)
library(data.table, lubridate)

###########################
## Loading data into memory
###########################
## Read data into the data table and subset
## only the records within the required range
## over a 2-day period in February, 2007
## before converting the data types.
dt <- fread("household_power_consumption.txt")
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")
ds <- dt[(dt$Date >= "2007-02-01" & dt$Date <= "2007-02-02"), ]
#ds$Time <- strptime(ds$Time)
ds$Global_active_power <- as.numeric(ds$Global_active_power)
ds$Global_reactive_power <- as.numeric(ds$Global_reactive_power)
ds$Global_intensity <- as.numeric(ds$Global_intensity)
ds$Voltage <- as.numeric(ds$Voltage)
ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)

#####################
## Data visualization
#####################
## Set parameters for the chart
outputFileName = "plot1.png"
barColour = "red"
xLabel = "Global Active Power (kilowatts)"
mainLabel = "Global Active Power"
chartOption <- 1
if (chartOption == 1) {
    viz <- hist(ds$Global_active_power, col = barColour, xlab = xLabel, main = mainLabel)
} else if (chartOption == 2) {
    viz <- hist(ds$Global_active_power, col = barColour, xlab = xLabel, main = mainLabel)
}

## Open a PNG deivce to create a PNG file
## and send the output graphic to a file
png(file = outputFileName)
with(ds, viz)
dev.off()