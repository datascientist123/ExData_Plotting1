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

#Concatenate Date and Time variables and parse into date/time format
reqdata$datetime <- paste(reqdata$Date, reqdata$Time)
reqdata$datetime <- strptime(reqdata$datetime, "%Y-%m-%d %H:%M:%S")

#Initiate png graphic device, construct plot
png(filename = "plot3.png", width = 480, height = 480)
with(reqdata, plot(datetime, Sub_metering_1, pch = NA, xlab="", ylab = "Energy sub metering"))
lines(reqdata$datetime, reqdata$Sub_metering_1)
points(reqdata$datetime, reqdata$Sub_metering_2, pch=NA)
lines(reqdata$datetime, reqdata$Sub_metering_2, col="red")
points(reqdata$datetime, reqdata$Sub_metering_3, pch=NA)
lines(reqdata$datetime, reqdata$Sub_metering_3, col="blue")

#Add Legend
legend("topright", pch = c(NA, NA, NA), lty = 1, col = c("black", "red", "blue"), text.col = "black", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#Close device
dev.off()
