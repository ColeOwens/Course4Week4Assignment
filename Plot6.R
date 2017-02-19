rm(list = ls())
##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 6
##  Compare emissions from motor vehicle sources in Baltimore City (fips = 24510) with 
##  emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
##  Which city has seen greater changes over time in motor vehicle emissions?

library(tidyr)
library(dplyr)
library(ggplot2)

## Read in the source data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("C:/Users/HAL/Dropbox/Coursera/Exploratory/Week4_Assignment/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/HAL/Dropbox/Coursera/Exploratory/Week4_Assignment/Source_Classification_Code.rds")

## checking out what's in the source data
##str(NEI)
##head(NEI)
##summary(NEI)

## Subset NEI for only Baltimore City (fips 24510) and Los Angeles (fips 06037) for only motor vehciles (type on-road)
NEI6 <- NEI[(NEI$fips == "24510" | NEI$fips == "06037") & NEI$type == "ON-ROAD", ]

## get the sums by year for each location (fips)
sum6 <- with(NEI6, tapply(Emissions, list(year, fips), sum, na.rm=T))
## convert this to a data frame
sum6b <- data.frame(Year = as.numeric(rownames(sum6)),sum6)

## check the column names
colnames(sum6b)
## [1] "Year"   "X06037" "X24510"
## edit the column names
colnames(sum6b)[2] = 'LosAngelesCounty'
colnames(sum6b)[3] = 'BaltimoreCity'

## make the data tidy
dtotal6 <- gather(sum6b, key = fips, value = sum, LosAngelesCounty:BaltimoreCity)

## Check the range
range(dtotal6$sum)
## [1]  88.27546 4601.41493


## Construct the plot and save it to a PNG file.
png(filename="Plot6.png", height=480, width=600)
P6 <- ggplot(dtotal6, aes(Year, sum, color = fips))
P6 <- P6 + geom_line(linetype = "solid", size = 2) +
  xlab("Year") +
  ylab(expression("Emissions (Tons)")) +
  ggtitle("Total Emissions in Baltimore City, Maryland vs Los Angeles County, California")
print(P6)
dev.off()
