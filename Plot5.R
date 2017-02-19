rm(list = ls())
##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 3
##  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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

## Merge the two dataframes by SCC to determine which are coal related
## NEI5 <- merge(NEI, SCC, by = "SCC")
## Filter for anything that has vehicle in the variable Short.Name
## NEI5b <- NEI5[grepl("vehicle", NEI5$Short.Name, ignore.case=TRUE),]
## Pull out the year and emissions data
## NEI5c <- NEI5b[,c("year", "Emissions")]


## Subset NEI data by Baltimore City (fips = 24510) and motor vehicles (type = on-road)
NEI5 <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
## Pull out just the year and emissions data
NEI5b <- NEI5[,c("year", "Emissions")]

## Get the sums of the data by year
sum5 <- with(NEI5b, tapply(Emissions, year, sum, na.rm=T))
dtotal5 <- data.frame(Year = as.numeric(rownames(sum5)), sum5)

## Get the range of the plotted data
range(dtotal5$sum5)
## [1]  88.27546 346.82000

## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot5.png", height=480, width=600)
with(dtotal5, barplot(sum5,
                      ylim = c(0,350),
                      xlab = "Year",
                      ylab = "PM2.5 Emissions (Tons)",
                      main = "Baltimore City, MD PM2.5 Emissions from Motor Vehicles - Sum by Year"))
dev.off()
