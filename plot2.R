## plot2 is a function that creates a png of a line graph of Global Active Power
## vs time
plot2<-function() {
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
        ## open a png file graphic device called "plot2.png" for plotting
        png("plot2.png")
        ## The graph is plotted as a blank first, then the graph of Global_active_power
        ## vs. datetime is added with lines()
        with(powerdates, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n"))
        lines(powerdates$datetime,powerdates$Global_active_power)
        ## close the file graphic device
        dev.off()
}

