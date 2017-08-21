## Loading the libraries required to run the script

library(dplyr)
library(data.table)

## Downloading the zip file and unziping 

url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- paste0(getwd(), "/" , "Electric_power_consumption.zip")
download.file(url, dest)
zipF<- "./Electric_power_consumption.zip"
outDir<-"./Electric_power_consumption"
unzip(zipF, exdir = outDir)
setwd("./Electric_power_consumption")

## Reading data set

Electric_power_consumption <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = FALSE, skip = 66637, nrows = 2880)
names <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, nrows = 1)
names(Electric_power_consumption) <- names(names)

Electric_power_consumption$newdate <- strptime(paste(Electric_power_consumption$Date, Electric_power_consumption$Time), format="%d/%m/%Y%H:%M:%S", tz = "GMT")

## Plot 4

png(file = "Plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(Electric_power_consumption, {
        plot(newdate, Global_active_power, xlab = "", ylab="Global Active Power", type = "l")
        plot(newdate, Voltage, xlab = "datatime", ylab="Voltage", type = "l")
        plot(newdate, Sub_metering_1, type = "l", xlab = "", ylab = "", col = "black", ylim=c(0,38))
        par(new=TRUE)
        plot(newdate, Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red", ylim=c(0,38))
        par(new=TRUE)
        plot(newdate, Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue", ylim=c(0,38))
        title(ylab = "Energy sub metering")
        legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(newdate, Global_Reactive_power, xlab = "datatime", ylab="Global reacctive Power", type = "l")
})

dev.off()
