zipFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(zipFile)) {
  download.file(url, zipFile)
}
if (!file.exists(dataFile)) {
  unzip(zipFile)
}

power <- read.csv(dataFile, sep = ";", na.strings = "?")
power$DateTime <- as.POSIXct(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")
power$Date <- strptime(power$Date, "%d/%m/%Y")
power$Time <- strptime(power$Time, "%H:%M:%S")
consumption <- subset(power, Date >= "2007-02-01" & Date <= "2007-2-02")

png("plot2.png", width = 480, height = 480)

plot(consumption$DateTime, consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
