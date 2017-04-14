setwd("D:/Cours/Coursera/Exploratory")                                          #setting the work directory
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)   #reading the file, 1st line as titles

# Changing the "?" in NA then removing them
data[data == "?"] <- NA
data <- na.omit(data)

# need to transform the row into numeric so we can plot it
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Plotting
png(filename = "plot1.png", width = 480, height = 480)                        #opening a png device of the proper size
hist(data$Global_active_power, col ='red', breaks= 12,                        #plotting the histogram with 12 breaks
     xlab='Global Active Power (kilowatts)', main = 'Global Active Power')    #and the right legends
dev.off()                                                                     #closing the device