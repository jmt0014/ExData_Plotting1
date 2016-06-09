Plot1<- function() {
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
 
   # creating the histogram
  hist(Gap, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
  
  #copying to a png file
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
  
}
plot1()
  