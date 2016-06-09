Plot4 <- function() {
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

  par(mfcol = c(2,2))

  plot(dt$timeline,dt$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex.lab=0.75)

  plot(dt$timeline,dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",cex.lab=0.75)  
  lines(dt$timeline,dt$Sub_metering_2,col="red")
  lines(dt$timeline,dt$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=0.5)

  plot(dt$timeline, dt$Voltage, type="l", xlab = "datetime", ylab = "Voltage", cex.lab=0.75)

  plot(dt$timeline, dt$Global_reactive_power, type = "l", xlab = "datetime", ylab ="Global_reactive_power", cex.lab=0.75)

  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}
Plot4()