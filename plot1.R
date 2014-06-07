## plot1 is a function that creates a png graphic of a histogram of the Global_active_power
## variable
plot1<-function() {
        ## read in the data with variable name "power" and name the columns
        power<-read.table("household_power_consumption.txt", sep=";",colClasses="character")
        colnames(power)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
        ## change the class of the Date column from character to date
        power$Date<-as.Date(power$Date,"%d/%m/%Y")
        ## variable powerdates is a subset of power that only includes Feb 1 & 2 of 2007.
        powerdates<-subset(power,Date=="2007-02-01" | Date=="2007-02-02")
        ## open a png file graphic device called "plot1.png" for plotting
        png("plot1.png")
        ## create the histogram as specified in the assignment
        hist(as.numeric(powerdates$Global_active_power), breaks=12, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        ## close the file graphic device
        dev.off()
}