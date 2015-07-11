### WARNING: the code for downloading file will work if
### capabilities("libcurl") == TRUE
	capabilities("libcurl")
# all files are saved into the working dir
	dr = getwd()
# download data
	URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(URL,paste(dr,"Z.zip",sep="/"),method="libcurl")
	temp = unzip(paste(dr,"Z.zip",sep="/"),list=FALSE)
	A = read.table(temp,header=TRUE,sep=";",na.strings="?",nrows=2075259)
# format dates to yyyy-mm-dd
	A$Date = as.Date(A$Date,format="%d/%m/%Y")
# leave only needed dates
	dt_lim = as.Date(c("2007-02-01","2007-02-02"))
	a = ( A$Date %in% dt_lim )
	A = A[a,]; n = nrow(A); n
# get days coordinates
	dys = weekdays(c(dt_lim,dt_lim[2]+1),TRUE)
	dys_coord = numeric(3); dys_coord[3] = nrow(A)+1
	for (i in 1:(length(dys_coord)-1)) dys_coord[i] = min(which(A$Date==dt_lim[i]))
# create plot
	par(mfrow=c(2,2),mar=c(5,4,2,1))
	## Global Active Power
		nm = "Global_active_power"
		plot(A[,nm],type="l",xlab="",ylab="Global Active Power",main="",xaxt="n")
		axis(1,at=dys_coord,labels=dys)
		box()	
	## Voltage
		nm = "Voltage"
		plot(A[,nm],type="l",xlab="datetime",ylab="Voltage",main="",xaxt="n")
		axis(1,at=dys_coord,labels=dys)
		box()	
	## Energy sub metering
		nm = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
		cl = c(1,2,4) # line colors
		plot(c(1,n),range(A[,nm]),xlab="",ylab="Energy sub metering",
			main="",type="n",xaxt="n")
		for (i in 1:length(nm)) lines(A[,nm[i]],col=cl[i])
		axis(1,at=dys_coord,labels=dys)
		legend(legend=nm,col=c(1,2,4),lwd=1,bty="n",x="topright")
		box()	
	## Global reactive power
		nm = "Global_reactive_power"
		plot(A[,nm],type="l",xlab="datetime",ylab=nm,main="",xaxt="n")
		axis(1,at=dys_coord,labels=dys)
		box()	
# save plot into png
	dev.copy(png,width=480,height=480,"plot4.png"); dev.off()
	
