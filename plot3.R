plot3() <- function() {
  
## download file after checking if it or the directory already exist
destfile <- "./ExpDataAnalysis/ExpData.zip"
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
if (!file.exists(destfile)) {
    if(!file.exists("ExpDataAnalysis")){
      dir.create("ExpDataAnalysis")
    }
    
  download.file(fileUrl, destfile)
}
  
unzip("./ExpDataAnalysis/ExpData.zip", exdir = "./ExpDataAnalysis")

## read header info and the data from the desired dates, 2007-02-01 through 2007-02-02
power.header<-read.csv2("./ExpDataAnalysis/household_power_consumption.txt", header = TRUE, nrows = 1, stringsAsFactors = FALSE)
power<-read.csv2("./ExpDataAnalysis/household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, stringsAsFactors = FALSE)
colnames(power)<-colnames(power.header)

## convert date and time to a single date_and_time column of type POSIXct
power$date_and_time <- as.POSIXct(strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S"))

png(filename = "plot3.png", width = 480, height = 480)
plot(power$date_and_time, as.numeric(power$Sub_metering_1), type = "n", ylab = "Energy sub metering", xlab = "")
lines(power$date_and_time, as.numeric(power$Sub_metering_1))
lines(power$date_and_time, as.numeric(power$Sub_metering_2), col = "red")
lines(power$date_and_time, as.numeric(power$Sub_metering_3), col = "blue")
legend("topright", legend = colnames(power)[7:9], col = c("black","red","blue"), lty= 1)
dev.off()
}