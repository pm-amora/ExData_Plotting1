# Unzip and load the data
unzip("exdata_data_household_power_consumption.zip", exdir = "C:/Users/Pedro/Documents/data/Exploratory Data Analysis")
data_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                         na.strings = "?", stringsAsFactors = FALSE, dec = ".")

# Filter data for specific dates
data_power <- data_power[data_power$Date %in% c("1/2/2007", "2/2/2007"), ]

# Set locale for English weekday labels
Sys.setlocale("LC_TIME", "English")

# Create a POSIXct datetime axis
time_axis <- as.POSIXct(paste(data_power$Date, data_power$Time), format = "%d/%m/%Y %H:%M:%S")

# Plot sub-metering values
png("plot3.png", width = 480, height = 480)
plot(time_axis, data_power$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black", xaxt = "n")
lines(time_axis, data_power$Sub_metering_2, col = "red")
lines(time_axis, data_power$Sub_metering_3, col = "blue")

# Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Add x-axis with weekday labels
unique_days <- seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day")
weekday_labels <- format(unique_days, "%a") # Generates abbreviated weekday names like "Thu", "Fri", "Sat"
axis(1, at = unique_days, labels = weekday_labels)

# Close the graphics device
dev.off()