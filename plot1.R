plot1 <- function() {
  
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
power<-read.csv2("./ExpDataAnalysis/household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, na.string = "?", stringsAsFactors = FALSE)
colnames(power)<-colnames(power.header)

png(filename = "plot1.png", width = 480, height = 480)
par(bg = "transparent")
hist(as.numeric(power$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
}