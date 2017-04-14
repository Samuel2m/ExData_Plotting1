library(lubridate) #getting required package
setwd("D:/Cours/Coursera/Exploratory")                                          #setting the work directory
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)   #reading the file, 1st line as titles

# Changing the "?" in NA then removing them
data[data == "?"] <- NA
data <- na.omit(data)

# Changing the date column into time object in the right format to subset the days we need
data[,1] = strftime(strptime(data[,1],"%d/%m/%Y"), format = "%Y-%m-%d")
finalData <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]


# Transforming the Date and Time columns into one column with the right format thanks to the lubridicate package
days <- ymd_hms(paste(as.character(finalData$Date), as.character(finalData$Time)))


# Need to transform the row into numeric so we can plot it
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
finalData$Global_active_power <- as.numeric(as.character(finalData$Global_active_power))
finalData$Sub_metering_1 <- as.numeric(as.character(finalData$Sub_metering_1))
finalData$Sub_metering_2 <- as.numeric(as.character(finalData$Sub_metering_2))
finalData$Sub_metering_3 <- as.numeric(as.character(finalData$Sub_metering_3))
finalData$Voltage <- as.numeric(as.character(finalData$Voltage))
finalData$Global_reactive_power <- as.numeric(as.character(finalData$Global_reactive_power))

# Plotting
png(filename = "plot4.png", width = 480, height = 480)                        #opening a png device of the proper size
par(mfrow=c(2,2))                                                             #to store the four graphs in one device
plot(finalData$Global_active_power ~ days, type= 'l', ylab='Global Active Power', xlab ="")   #almost like plot 1
plot(finalData$Voltage ~ days, type= 'l', xlab="datetime", ylab="Voltage")                    #plotting Voltage  ~ days with labels
plot(finalData$Sub_metering_1 ~ days, type ='l', col = "black", ylab="Energy sub metering", xlab="")  #almost like plot1
lines(finalData$Sub_metering_2 ~ days, type ='l', col = "red")                                       
lines(finalData$Sub_metering_3 ~ days, type ='l', col = "blue") 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col = c("black", "red", "blue"), bty="n")             #difference is bty="n" to delete the frame of the legends
plot(finalData$Global_reactive_power ~ days, type= 'l', xlab ="datetime", ylab="Global_reactive_power") #Reactive power ~ days
dev.off()                                                                      #closing the device
