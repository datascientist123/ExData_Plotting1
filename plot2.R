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

#Concatenate Date and Time variables and parse into date/time format
reqdata$datetime <- paste(reqdata$Date, reqdata$Time)
reqdata$datetime <- strptime(reqdata$datetime, "%Y-%m-%d %H:%M:%S")

#Initiate png graphic device, construct plot and close device
png(filename = "plot2.png", width = 480, height = 480)
with(reqdata, plot(datetime, Global_active_power, pch = NA, xlab ="", ylab = "Global Active Power(kilowatts)"))
lines(reqdata$datetime, reqdata$Global_active_power)
dev.off()
