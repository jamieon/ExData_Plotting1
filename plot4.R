## TO DOWNLOAD, UNZIP, AND READ THE DATA (UNLESS NOT SAVED ALREADY):
library(lubridate)
if (!file.exists('power-data.rds')) {
     download.file(paste0('https://d396qusza40orc.cloudfront.net/',
                          'exdata%2Fdata%2Fhousehold_power_consumption.zip'), destfile='raw-power-data.zip')
     unzip('raw-power-data.zip')
     power.df <- read.table('household_power_consumption.txt', header=TRUE,
                            sep=';', na.strings='?',
                            colClasses=c(rep('character', 2),
                                         rep('numeric', 7)))
     power.df$Date <- dmy(power.df$Date)
     power.df$Time <- hms(power.df$Time)
     start <- ymd('2007-02-01')
     end <- ymd('2007-02-02')
     power.df <- subset(power.df, year(Date) == 2007 &
                             month(Date) == 2 &
                             (day(Date) == 1 | day(Date) == 2))
     power.df$date.time <- power.df$Date + power.df$Time
     
     saveRDS(power.df, file='power-data.rds')
} else {
     power.df <- readRDS('power-data.rds')
}

## TO MAKE PLOT 4:
png(filename='plot4.png')
par(mfrow=c(2,2))
# TO MODIFY TOP:
plot(power.df$date.time, power.df$Global_active_power,
     ylab='Global Active Power', xlab='', type='l')
plot(power.df$date.time, power.df$Voltage,
     xlab='datetime', ylab='Voltage', type='l')
# TO MODIFY BOTTOM:
plot(power.df$date.time, power.df$Sub_metering_1, type='l',
     xlab='', ylab='Energy sub metering')
lines(power.df$date.time, power.df$Sub_metering_2, col='red')
lines(power.df$date.time, power.df$Sub_metering_3, col='blue')
legend('topright',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'),
       lty='solid', bty='n')
plot(power.df$date.time, power.df$Global_reactive_power,
     xlab='datetime', ylab='Global_reactive_power', type='l')
dev.off()