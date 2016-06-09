Plot3 <- function() {
    if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
  }
  #read in the data
  data <- read.table(file, header=T, sep=";")
  
  #subset and manipulate data for use
  data$Date <- as.Date(data$Date,format= "%d/%m/%Y")
  elec <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
  elec$Global_active_power <- as.numeric(as.character(elec$Global_active_power))
  Gap <- elec$Global_active_power
  dt <- transform(elec, timeline=as.POSIXct(paste(Date, Time)))
  dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
  dt$Voltage <- as.numeric(as.character(dt$Voltage))
  dt <- transform(dt, timeline=as.POSIXct(paste(Date, Time)))

  dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
  dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
  dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))

  plot(dt$timeline,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")  
  lines(dt$timeline,dt$Sub_metering_2,col="red")
  lines(dt$timeline,dt$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
}
Plot3()