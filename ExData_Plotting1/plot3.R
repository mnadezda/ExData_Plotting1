fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile = '/Users/nadya-mas/ExData_Plotting1/EPC.zip', method = 'curl')
list.files('/Users/nadya-mas/ExData_Plotting1')
setwd('/Users/nadya-mas/ExData_Plotting1')
EPC <- read.table(unzip('EPC.zip'), header = TRUE, sep = ';', stringsAsFactors=F, na.strings='?')

EPC_DT <- data.frame(as.Date(EPC[,1], '%d/%m/%Y'), strptime(EPC[,2], '%X'), EPC[,3:9])
colnames(EPC_DT)[1] <- 'Date'
colnames(EPC_DT)[2] <- 'Time'

EPC_DDT <- rbind(subset(EPC_DT, Date == '2007-02-01'), subset(EPC_DT, Date == '2007-02-02'))

EPC_DDTx <- data.frame(EPC_DDT[,1], strptime(EPC_DDT[,2], format='%Y-%m-%d %X'), EPC_DDT[,3:9])
EPC_DDTx <- data.frame(EPC_DDTx[,1], strftime(EPC_DDTx[,2], format='%X'), EPC_DDTx[,3:9])
colnames(EPC_DDTx)[1] <- 'Date'
colnames(EPC_DDTx)[2] <- 'Time'
EPC_Data <- cbind(as.POSIXct(paste(EPC_DDTx$Date, EPC_DDTx$Time), format="%Y-%m-%d %H:%M:%S"), EPC_DDTx)
colnames(EPC_Data)[1] <- 'DT'

png("plot3.png",  width = 480, height = 480, units = "px")
plot(EPC_Data$DT, EPC_Data$Sub_metering_1, type = 'l', ylab='Energy sub metering', xlab = NA)
lines(EPC_Data$DT, EPC_Data$Sub_metering_2, type = 'l', col = 'red')
lines(EPC_Data$DT, EPC_Data$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', lty = 1, col = c("black","red", 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()