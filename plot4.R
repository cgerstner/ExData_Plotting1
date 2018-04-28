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

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

# Top left
plot(consumption$DateTime, consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Top right
plot(consumption$DateTime, consumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Bottom left
plot(consumption$DateTime, consumption$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
with(consumption, lines(DateTime, Sub_metering_1, col = "black"))
with(consumption, lines(DateTime, Sub_metering_2, col = "red"))
with(consumption, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Bottom right
plot(consumption$DateTime, consumption$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
