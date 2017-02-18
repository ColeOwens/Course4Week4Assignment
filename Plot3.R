rm(list = ls())
##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 3
##  Of the four types of sources indicated by the type (point, nonpoint, onroad, 
##  nonroad) variable, which of these four sources have seen decreases in emissions
##  from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
##  1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(tidyr)
library(dplyr)
library(ggplot2)


## Read in the source data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("C:/Users/HAL/Dropbox/Coursera/Exploratory/Week4_Assignment/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/HAL/Dropbox/Coursera/Exploratory/Week4_Assignment/Source_Classification_Code.rds")

## checking out what's in the source data
str(NEI)
head(NEI)
summary(NEI)

## subset the source data to only read Baltimore City, Maryland (fips == "24510")
## keep only only the year and the Emissions data
NEI3 <- subset(NEI, fips == "24510", c(year,type, Emissions))

## use tapply function to separate the data by year and type and get the sums for those years/types
sum3 <- with(NEI3, tapply(Emissions, list(year,type), sum, na.rm=T))
## convert this into a data frame
sum3b <- data.frame(Year = rownames(sum3), sum3)

## check the column names
colnames(sum3)
##[1] "NON-ROAD" "NONPOINT" "ON-ROAD"  "POINT"   
## edit the column names
colnames(sum3)[1] = 'NON.ROAD'
colnames(sum3)[3] = 'ON.ROAD'

## make the data tidy
dtotal3 <- gather(sum3b, key = Type, value = sum, NON.ROAD:POINT)

## make a new column called EmissInHund so your plot will be more easily readable
dtotal3$EmissInHund <- with(dtotal3, sum/100)

## Check the range
range(dtotal3$EmissInHund)
## [1]  0.5582356 21.0762500


## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot3.png", height=480, width=600)
P3 <- ggplot(dtotal3, aes(Year, EmissInHund, color = Type)) 
P3 <- P3 + geom_line(linetype = "solid", size = 2) + xlab("Year") + ylab("PM2.5 Emissions (Hundreds)") + ggtitle("Baltimore City, MD PM2.5 Emissions - Sum by Year & Type")
print(P3)
dev.off()
