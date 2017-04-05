## Please, consider that the "household_power_consumption.txt" 
## is already in the working directory


# Loading necessary packages
library(dplyr)
library(lubridate)


# Preparing the data set
pwrConsum <- read.table("household_power_consumption.txt", 
               header = TRUE, 
               sep = ";")
pwrConsumFeb <- tbl_df(subset(pwrConsum, 
                              Date == "1/2/2007" | Date == "2/2/2007"))


# Plotting
pwrConsumFeb$Global_active_power <- 
        as.numeric(levels(pwrConsumFeb$Global_active_power))[pwrConsumFeb$Global_active_power]

png(filename = "plot1.png", width = 480, height = 480)
hist(pwrConsumFeb$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()




