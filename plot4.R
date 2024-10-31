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

# Plot four graphs based on a 2x2 layout
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(3, 3, 2, 1), oma = c(1, 1, 1, 1), mgp = c(2, 0.5, 0), cex = 0.8)


# Define unique days and labels for all plots
unique_days <- seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day")
weekday_labels <- format(unique_days, "%a") # Generates abbreviated weekday names like "Thu", "Fri", "Sat"

# Plot 1: Global Active Power
plot(time_axis, data_power$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")
axis(1, at = unique_days, labels = weekday_labels)

# Plot 2: Voltage
plot(time_axis, data_power$Voltage, xlab = "datetime", ylab = "Voltage", type = "l", xaxt = "n")
axis(1, at = unique_days, labels = weekday_labels)

# Plot 3: Energy Sub Metering
plot(time_axis, data_power$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n")
lines(time_axis, data_power$Sub_metering_2, col = "red")
lines(time_axis, data_power$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), cex = 0.8, lty = 1 , bty = "n")
axis(1, at = unique_days, labels = weekday_labels)

# Plot 4: Global Reactive Power
plot(time_axis, data_power$Global_reactive_power, xlab = "datetime", ylab = "Global Reactive Power", type = "l", xaxt = "n")
axis(1, at = unique_days, labels = weekday_labels)

# Close the graphics device
dev.off()