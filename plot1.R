unzip("exdata_data_household_power_consumption.zip", exdir = "C:/Users/Pedro/Documents/data/Exploratory Data Analysis")

# Read data with specific date parsing
data_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
 
# Convert Date and Time columns to classes
data_power$Date <- as.Date(data_power$Date, format = "%d/%m/%Y")
data_power$Datetime <- as.POSIXct(paste(data_power$Date, data_power$Time), format = "%Y-%m-%d %H:%M:%S")

# Filter data for specific dates
subset_data_power <- data_power %>%
    filter(data_power$Date == as.Date("2007-02-01") | data_power$Date == as.Date("2007-02-02"))

# Set the output to a PNG file
png("plot1.png", width = 480, height = 480)

# Create plot1 
hist(subset_data_power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Close the graphics device
dev.off()