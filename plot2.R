### WARNING: the code for downloading file will work if
### capabilities("libcurl") == TRUE
	capabilities("libcurl")
# all files are saved into the working dir
	dr = getwd()
# download data
	URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(URL,paste(dr,"Z.zip",sep="/"),method="libcurl")
	temp = unzip("C:/Users/Anastasija/Desktop/Z.zip",list=FALSE)
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
	nm = "Global_active_power"
	plot(A[,nm],type="l",xlab="",main="",
		ylab="Global Active Power (kilowatts)",xaxt="n")
	axis(1,at=dys_coord,labels=dys)
	box()	
# save plot into png
	dev.copy(png,width=480,height=480,"plot2.png"); dev.off()
	
