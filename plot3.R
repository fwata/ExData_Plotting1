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

pwrConsumFeb <- mutate(pwrConsumFeb, 
                       Date_Time = dmy_hms(paste(pwrConsumFeb$Date, 
                                                 pwrConsumFeb$Time)))

pwrConsumFeb$Sub_metering_1 <- 
        as.numeric(levels(pwrConsumFeb$Sub_metering_1))[pwrConsumFeb$Sub_metering_1]
pwrConsumFeb$Sub_metering_2 <- 
        as.numeric(levels(pwrConsumFeb$Sub_metering_2))[pwrConsumFeb$Sub_metering_2]

# Plotting
Sys.setlocale(category = "LC_ALL", locale = "C") # to avoid labels in other languages 

png(filename = "plot3.png", width = 480, height = 480)
with(pwrConsumFeb, plot(Date_Time, Sub_metering_1, 
                        type = "l", 
                        ylab = "Energy sub metering", 
                        xlab = ""))
with(pwrConsumFeb, lines(Date_Time, Sub_metering_2,
                         type = "l",
                         col = "red"))
with(pwrConsumFeb, lines(Date_Time, Sub_metering_3,
                         type = "l",
                         col = "blue"))
legend("topright", 
       legend = names(pwrConsumFeb)[7:9], 
       col = c("black", "red", "blue"), 
       lty = 1)
dev.off()
