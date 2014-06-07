## plot3 is a function that creates a png of a line graph of each of the 3 sub metering stations
## vs time
plot3<-function() {
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
        png("plot3.png")
        ## The graph is plotted as a blank first, then the graph of each meter
        ## vs. datetime is added with lines(), each with a different color.
        with(powerdates,plot(datetime,Sub_metering_1,xlab="", ylab="Energy sub metering",type="n"))
        lines(powerdates$datetime,powerdates$Sub_metering_1)
        lines(powerdates$datetime,powerdates$Sub_metering_2,col="red")
        lines(powerdates$datetime,powerdates$Sub_metering_3,col="blue")
        ## creates a legend for the plot in the upper right of the plot
        legend("topright",lwd=c(1,1,1), col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        ## close the file graphic device
        dev.off()
}