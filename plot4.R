## Please, consider that the "household_power_consumption.txt" 
## is already in the working directory


# Loading necessary packages
library(dplyr)
library(lubridate)


# Preparing the data set
pwrConsum <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";")
pwrConsumFeb <- tbl_df(subset(pwrConsum, Date == "1/2/2007" | Date == "2/2/2007"))

Date_Time <- dmy_hms(paste(pwrConsumFeb$Date, pwrConsumFeb$Time))
pwrConsumFeb <- apply(pwrConsumFeb[3:9], 2, as.character) %>%
                apply(2, as.numeric) %>%
                tbl_df


# Plotting
# Preparing the setup
Sys.setlocale(category = "LC_ALL", locale = "C") # to avoid labels in other languages

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,2))

# Plotting top left
plot(Date_Time, 
     pwrConsumFeb$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")

# Plotting top right
plot(Date_Time, 
     pwrConsumFeb$Voltage, 
     type = "l", 
     ylab = "Voltage",
     xlab = "datetime")

# Plotting bottom left
plot(Date_Time, 
     pwrConsumFeb$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(Date_Time, 
      pwrConsumFeb$Sub_metering_2,
      type = "l",
      col = "red")
lines(Date_Time, 
      pwrConsumFeb$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright", 
       legend = names(pwrConsumFeb)[5:7], 
       col = c("black", "red", "blue"), 
       bty = "n",
       lty = 1)

# Plotting bottom right
plot(Date_Time,
     pwrConsumFeb$Global_reactive_power,
     type = "l",
     ylab = "Globa_reactive_power",
     xlab = "datetime")

dev.off()
