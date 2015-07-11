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
# create plot
	nm = "Global_active_power"
	hist(A[,nm],col=2,main="Global Active Power",xlab="Global Active Power (kilowatts)")
# save plot into png
	dev.copy(png,width=480,height=480,"plot1.png"); dev.off()
	
