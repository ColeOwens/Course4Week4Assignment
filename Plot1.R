##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 1
##  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##  Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##  sources for each of the years 1999, 2002, 2005, and 2008.

## Read in the source data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("C:/Users/cowens/Documents/Coursera-Exploratory/Week4_Assignment/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/cowens/Documents/Coursera-Exploratory/Week4_Assignment/Source_Classification_Code.rds")

## checking out what's in the source data
str(NEI)
head(NEI)
summary(NEI)

## subset the source data into only the Year and the PM2.5 data (Emissions)
NEI0 <- NEI[,c(6,4)]

## use tapply function to separate the data by year and get the sums for those years
sum0 <- with(NEI0, tapply(Emissions, year, sum, na.rm=T))

## convert this into a data frame
dtotal <- data.frame(year = names(sum0), sum = sum0)

## make a new column called EmissionsInMills so your plot will be more easily readable
dtotal$EmissionsInMils <- with(dtotal, sum/1000000)


## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot1.png", height=480, width=480)
with(dtotal, barplot(EmissionsInMils,
                  ylim = c(0,8),
                  xlab = "Year",
                  ylab = "PM2.5 Emissions (millions)",
                  main = "PM2.5 Emissions - Sum by Year"))
dev.off()


## THis was my original thought process and has no bearing on the actual plot
## Just keeping it for historical purposes and to show I shouldn't code when I'm tired. 

## subset the NEI data frame into 4 frames, one for each year
## y1999 <- subset(NEI, year == 1999)
## y2002 <- subset(NEI, year == 2002)
## y2005 <- subset(NEI, year == 2005)
## y2008 <- subset(NEI, year == 2008)
## 
## sum1999 <- with(y1999, tapply(Emissions, year, sum, na.rm=T))
## sum2002 <- with(y2002, tapply(Emissions, year, sum, na.rm=T))
## sum2005 <- with(y2005, tapply(Emissions, year, sum, na.rm=T))
## sum2008 <- with(y2008, tapply(Emissions, year, sum, na.rm=T))
## 
## d1999 <- data.frame(year = names(sum1999), sum = sum1999)
## d2002 <- data.frame(year = names(sum2002), sum = sum2002)
## d2005 <- data.frame(year = names(sum2005), sum = sum2005)
## d2008 <- data.frame(year = names(sum2008), sum = sum2008)
## 
## dtotal <- rbind(d1999, d2002, d2005, d2008)
## 
## d1999$EmissionsInMils <- with(d1999, sum/1000000)
## d2002$EmissionsInMils <- with(d2002, sum/1000000)
## d2005$EmissionsInMils <- with(d2005, sum/1000000)
## d2008$EmissionsInMils <- with(d2008, sum/1000000)
## 