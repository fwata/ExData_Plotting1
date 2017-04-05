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

pwrConsumFeb$Global_active_power <- 
        as.numeric(levels(pwrConsumFeb$Global_active_power))[pwrConsumFeb$Global_active_power]

pwrConsumFeb <- mutate(pwrConsumFeb, 
                       Date_Time = dmy_hms(paste(pwrConsumFeb$Date, 
                                                pwrConsumFeb$Time)))

# Plotting
png(filename = "plot2.png", width = 480, height = 480)
with(pwrConsumFeb, plot(Date_Time, Global_active_power, 
               type = "l", 
               ylab = "Global Active Power (kilowats)", 
               xlab = ""))
dev.off()
