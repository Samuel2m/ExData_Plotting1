library(lubridate) #getting required package
setwd("D:/Cours/Coursera/Exploratory")                                          #setting the work directory
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)   #reading the file, 1st line as titles

# Changing the "?" in NA then removing them
data[data == "?"] <- NA
data <- na.omit(data)

# Changing the date column into time object in the right format to subset the days we need
data[,1] = strftime(strptime(data[,1],"%d/%m/%Y"), format = "%Y-%m-%d")
finalData <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

# Need to transform the row into numeric so we can plot it
finalData$Global_active_power <- as.numeric(as.character(finalData$Global_active_power))

# Transforming the Date and Time columns into one column with the right format thanks to the lubridicate package
days <- ymd_hms(paste(as.character(finalData$Date), as.character(finalData$Time)))

# Plotting
png(filename = "plot2.png", width = 480, height = 480)                      #opening a png device of the proper size
plot(finalData$Global_active_power ~ days, type= 'l',                       #plotting as a line
     ylab='Global Active Power (kilowatts)', xlab ="")                      #setting the right legends
dev.off()                                                                   #closing the device