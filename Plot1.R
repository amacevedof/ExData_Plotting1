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

## Plot 1

png(file = "Plot1.png")
hist(Electric_power_consumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

