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
setwd("..")

## Plot 3

png(file = "Plot3.png")
with(Electric_power_consumption, {
        plot(newdate, Sub_metering_1, type = "l", xlab = "", ylab = "", col = "black", ylim=c(0,38))
        par(new=TRUE)
        plot(newdate, Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red", ylim=c(0,38))
        par(new=TRUE)
        plot(newdate, Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue", ylim=c(0,38))
        title(ylab = "Energy sub metering")
        legend("topright", lty=1, lwd=2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
