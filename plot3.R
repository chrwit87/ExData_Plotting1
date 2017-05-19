## in this section, the file is read in and the date and
## time columns are converted into date and time variables.

bigdata <- read.table("household_power_consumption.txt",
                      header=TRUE, sep=";")
bigdata$Date <- as.Date(bigdata$Date, format="%d/%m/%Y")
bigdata$Time <- strptime(bigdata$Time, format="%H:%M:%S")

## here, a subset of the two days in february is created
##and the time column is converted so that it contains
##the full informations on date and time

dfpower <- subset(bigdata,bigdata$Date=="2007-02-01" |
                        bigdata$Date =="2007-02-02")
dfpower[1:1440,"Time"] <- format(dfpower[1:1440,"Time"],
                                 "2007-02-01 %H:%M:%S")
dfpower[1441:2880,"Time"] <- format(dfpower[1441:2880,"Time"],
                                    "2007-02-02 %H:%M:%S")

## this is the plotting section

plot(dfpower$Time, as.numeric(as.character(
      dfpower$Sub_metering_1)),type="l",
     xlab="", ylab="Energy sub metering", main=
           "Energy sub metering / Time")
lines(dfpower$Time,as.numeric(as.character
            (dfpower$Sub_metering_2)),col="red")
lines(dfpower$Time,as.numeric(as.character
            (dfpower$Sub_metering_3)),col="blue")
legend("topright", lty=1,col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2",
                "Sub_metering_3"))

## here the created plot is written into a png-file.

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()