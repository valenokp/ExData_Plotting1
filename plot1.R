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
# create plot
	nm = "Global_active_power"
	hist(A[,nm],col=2,main="Global Active Power",xlab="Global Active Power (kilowatts)")
# save plot into png
	dev.copy(png,width=480,height=480,"plot1.png"); dev.off()
	
