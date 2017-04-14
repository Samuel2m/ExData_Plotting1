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

# Need to transform the rows into numeric so we can plot them
finalData$Sub_metering_1 <- as.numeric(as.character(finalData$Sub_metering_1))
finalData$Sub_metering_2 <- as.numeric(as.character(finalData$Sub_metering_2))
finalData$Sub_metering_3 <- as.numeric(as.character(finalData$Sub_metering_3))

# Plotting
png(filename = "plot3.png", width = 480, height = 480)                      #opening a png device of the proper size
plot(finalData$Sub_metering_1 ~ days, type ='l', col = "black",             #drawing the first colmun~days first with lines
     ylab="Energy sub metering", xlab="")                                   #setting the legends here since there are few
lines(finalData$Sub_metering_2 ~ days, type ='l', col = "red")              #drawing the second column on the same device
lines(finalData$Sub_metering_3 ~ days, type ='l', col = "blue")             #drawing the third column on the same device
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col = c("black", "red", "blue"))                       #legends topright with the appropirate lines and colours
dev.off()                                                                   #closing the device