rm(list = ls())
##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 3
##  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

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
NEI4 <- merge(NEI, SCC, by = "SCC")
## Filter for anything that has coal in the variable Short.Name
NEI4b <- NEI4[grepl("coal", NEI4$Short.Name, ignore.case=TRUE),]
## Pull out the year and emissions data
NEI4c <- NEI4b[,c("year", "Emissions")]

## Get the sums of the data by year
sum4 <- with(NEI4c, tapply(Emissions, year, sum, na.rm=T))
dtotal4 <- data.frame(Year = as.numeric(rownames(sum4)), sum4)

## create another column for the Emissions in Hundreds of Thousands
dtotal4$EmissInHunThou <- dtotal4$sum4/100000

## Get the range of the plotted data
range(dtotal4$EmissInHunThou)
## [1] 3.580839 6.026241

## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot4.png", height=480, width=480)
with(dtotal4, barplot(EmissInHunThou,
                      ylim = c(0,6.5),
                      xlab = "Year",
                      ylab = "PM2.5 Emissions (Hundred Thousands of Tons)",
                      main = "US PM2.5 Emissions from Coal - Sum by Year"))
dev.off()