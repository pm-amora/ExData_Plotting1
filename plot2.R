unzip("exdata_data_household_power_consumption.zip", exdir = "C:/Users/Pedro/Documents/data/Exploratory Data Analysis")

# Read data with specific date parsing
data_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE, dec = ".")

# Filter data for specific dates and create a subset of those dates
data_power <- data_power[data_power$Date %in% c("1/2/2007","2/2/2007"), ]

# Set language to English (days in the x-axis)
Sys.setlocale("LC_TIME", "English")

# Convert data to weekdays
time_axis <- as.POSIXct(paste(date_converted, data_power[, 2]))

# Set the output to the new PNG file and create plot2
png("plot2.png", width = 480, height = 480)
plot(time_axis, data_power[, 3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")

# Automatically generate weekdays for each unique date
unique_days <- seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day")
weekday_labels <- format(unique_days, "%a") # Generates abbreviated weekday names like "Thu", "Fri", "Sat"
axis(1, at = unique_days, labels = weekday_labels)

# Close the graphics device
dev.off()