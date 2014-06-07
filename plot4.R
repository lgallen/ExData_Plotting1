## plot4 is a function that creates a png of 4 plots, Global Active Power vs. time,
## Energy sub metering vs time, Voltage vs time, and Global reactive power vs. time
plot4<-function() {
        ## read in the data with variable name "power" and name the columns
        power<-read.table("household_power_consumption.txt", sep=";",colClasses="character")
        colnames(power)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        ## datetime is a variable that is created by pasting together the date and time of
        ## an observation. Once formated properly with strptime, it is bound onto power
        ## with cbind.
        datetime<-paste(power$Date,power$Time)
        datetime<-strptime(datetime, format="%d/%m/%Y %H:%M:%S")
        power<-cbind(power,datetime)
        ## change the class of the Date column from character to date
        power$Date<-as.Date(power$Date,"%d/%m/%Y")
        ## variable powerdates is a subset of power that only includes Feb 1 & 2 of 2007.
        powerdates<-subset(power,Date=="2007-02-01" | Date=="2007-02-02")
        ## open a png file graphic device called "plot3.png" for plotting
        ## open a png file graphic device called "plot4.png" for plotting
        png("plot4.png")
        ## sets base graphic parameter to 2 by 2 to be filled column-wise
        par(mfcol=c(2,2))
        ## upper left graph is Global_active_power vs time, same as plot2
        with(powerdates, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
        lines(powerdates$datetime,powerdates$Global_active_power)
        ## lower left graph is the Energy sub metering vs time, same as plot3, but with
        ## border removed in legend
        with(powerdates,plot(datetime,Sub_metering_1,xlab="", ylab="Energy sub metering",type="n"))
        lines(powerdates$datetime,powerdates$Sub_metering_1)
        lines(powerdates$datetime,powerdates$Sub_metering_2,col="red")
        lines(powerdates$datetime,powerdates$Sub_metering_3,col="blue")
        legend("topright",lwd=c(1,1,1), bty="n", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        ## upper right graph is Voltage vs time
        with(powerdates,plot(datetime,Voltage,type="n"))
        lines(powerdates$datetime,powerdates$Voltage)
        ## lower right graph is Global_reactive_power vs time
        with(powerdates,plot(datetime,Global_reactive_power,type="n"))
        lines(powerdates$datetime,powerdates$Global_reactive_power)
        ## close the file graphic device
        dev.off()
}
