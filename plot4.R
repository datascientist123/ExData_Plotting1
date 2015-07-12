# Read Data and Understand Structure
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
str(data)
dim(data)
# Convert Date variable into Date class
data$Date <- strptime(data$Date, "%d/%m/%Y")
data$Date <- as.Date(data$Date)

#Subset data for 2007-02-01 and 2007-02-02
reqdata <- subset(data, Date == "2007-02-01")
reqdata2 <- subset(data, Date == "2007-02-02")
reqdata <- rbind(reqdata, reqdata2)

#Convert class from factor to numeric
reqdata$Global_active_power <- as.numeric(reqdata$Global_active_power)
reqdata$Sub_metering_1 <- as.numeric(reqdata$Sub_metering_1)
reqdata$Sub_metering_2 <- as.numeric(reqdata$Sub_metering_2)
reqdata$Voltage <- as.numeric(reqdata$Voltage)
reqdata$Global_reactive_power <- as.numeric(reqdata$Global_reactive_power)

#Concatenate Date and Time variables and parse into date/time format
reqdata$datetime <- paste(reqdata$Date, reqdata$Time)
reqdata$datetime <- strptime(reqdata$datetime, "%Y-%m-%d %H:%M:%S")

#Initiate png graphic device, construct histogram
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1))
#Plot 1 of 4 - Top left
with(reqdata, plot(datetime, Global_active_power, pch = NA, xlab ="", ylab = "Global Active Power"))
lines(reqdata$datetime, reqdata$Global_active_power)
#Plot 2 of 4 - Top Right
with(reqdata, plot(datetime, Voltage, pch=NA))
lines(reqdata$datetime, reqdata$Voltage)
#Plot 3 of 4 - Bottom Left
with(reqdata, plot(datetime, Sub_metering_1, pch = NA, xlab="", ylab = "Energy sub metering"))
lines(reqdata$datetime, reqdata$Sub_metering_1)
points(reqdata$datetime, reqdata$Sub_metering_2, pch=NA)
lines(reqdata$datetime, reqdata$Sub_metering_2, col="red")
points(reqdata$datetime, reqdata$Sub_metering_3, pch=NA)
lines(reqdata$datetime, reqdata$Sub_metering_3, col="blue")
legend("topright", pch = c(NA, NA, NA), lty = 1, bty ="n", col = c("black", "red", "blue"), text.col = "black", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
# Plot 4 of 4 - bottom right
with(reqdata, plot(datetime, Global_reactive_power, pch=NA))
lines(reqdata$datetime, reqdata$Global_reactive_power)

dev.off()
