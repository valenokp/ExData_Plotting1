# set working dir
	setwd("D:/GitRepos/ExData_Plotting1")
# read in data
	A = read.table("household_power_consumption.txt",header=TRUE,sep=";",
		na.strings="?",nrows=2075259)
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
		plot(A[,nm],type="l",xlab="",ylab="Global Active Power",main="",axes=FALSE)
		axis(1,at=dys_coord,labels=dys)
		axis(2,ylim=range(A[,nm]))	
		box()	
	## Voltage
		nm = "Voltage"
		plot(A[,nm],type="l",xlab="datetime",ylab="Voltage",main="",axes=FALSE)
		axis(1,at=dys_coord,labels=dys)
		axis(2,ylim=range(A[,nm]))	
		box()	
	## Energy sub metering
		nm = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
		cl = c(1,2,4) # line colors
		rng = range(A[,nm])
		plot(c(1,n),rng,xlab="",ylab="Energy sub metering",
			main="",type="n",axes=FALSE)
		for (i in 1:length(nm)) lines(A[,nm[i]],col=cl[i])
		axis(1,at=dys_coord,labels=dys)
		axis(2,ylim=rng)	
		legend(legend=nm,col=c(1,2,4),lwd=1,bty="n",x="topright")
		box()	
	## Global reactive power
		nm = "Global_reactive_power"
		plot(A[,nm],type="l",xlab="datetime",ylab=nm,main="",axes=FALSE)
		axis(1,at=dys_coord,labels=dys)
		axis(2,ylim=range(A[,nm]))
		box()	
# save plot into png
	dev.copy(png,width=480,height=480,"plot4.png"); dev.off()
	
