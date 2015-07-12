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

#Convert data into numeric class
reqdata$Global_active_power <- as.numeric(reqdata$Global_active_power)

#Initiate png graphic device, construct histogram and close device
png(filename = "plot1.png", width = 480, height = 480)
hist(reqdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab= "Frequency", main = "Global Active Power")
dev.off()