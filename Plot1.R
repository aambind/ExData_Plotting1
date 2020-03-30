library(tidyverse)
library(data.table)
library(downloader)

if(!file.exists("data")){dir.create("data")}
fileUrl<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download(fileUrl, dest="./data/dataanalysis1.zip", mode="wb")
unzip (zipfile = "./data/dataanalysis1.zip", exdir = "./data")
list.files("./data")
power<-fread("./data/household_power_consumption.txt")
class(power$Date)
class(power$Time)
power<-power %>% mutate(datetime = paste(Date, Time))
power$datetime
power$datetime<-strptime(power$datetime, format=("%d/%m/%Y %H:%M:%S"))
class(power$datetime)
power$datetime<-as.POSIXct(power$datetime)
power<-power %>% filter(datetime >= "2007-02-01 00:00:00" & datetime <= "2007-02-02 23:59:59")
power$Global_active_power<-as.numeric(power$Global_active_power)

#Plot 1: 
par(mfrow = c( 1, 1))
hist(power$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col = "red")
dev.copy(png, file = "Plot1.png")
dev.off()