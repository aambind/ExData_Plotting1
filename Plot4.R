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

#Plot 4:
par(mfrow = c( 2, 2))
plot(power$datetime, power$Global_active_power, type="l", xlab = "Day", ylab = "Global Active Power")
plot(power$datetime, power$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
plot(power$datetime, power$Sub_metering_1, type = "l")
lines(power$datetime, power$Sub_metering_2, type = "l", col = "red")
lines(power$datetime, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend= c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       col=c("black", "red", "blue"), lty = 1)
plot(power$datetime, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "Plot4.png")
dev.off()