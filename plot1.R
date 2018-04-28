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
power$Date <- strptime(power$Date, "%d/%m/%Y")
consumption <- subset(power, Date >= "2007-02-01" & Date <= "2007-2-02")

png("plot1.png", width = 480, height = 480)

hist(consumption$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
