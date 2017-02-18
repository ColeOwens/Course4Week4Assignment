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

## check the column names
colnames(sum3)
##[1] "NON-ROAD" "NONPOINT" "ON-ROAD"  "POINT"   
## edit the column names
colnames(sum3)[1] = 'NON.ROAD'
colnames(sum3)[3] = 'ON.ROAD'
years <- data.frame(Year = row.names(sum3))

#years <- row.names(sum3)
#sum3b <- merge(years, sum3)


## use gather to convert the data frame
dtotal3 <- gather(sum3, key = Type, value = sum, NON.ROAD:POINT)
##Error in eval(expr, envir, enclos) : object 'NON' not found

## convert this into a data frame
## dtotal3 <- data.frame(year = names(sum3), sum = sum0)

## make a new column called EmissInHund so your plot will be more easily readable
dtotal3$EmissInHund <- with(dtotal3, sum/100)


## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot3.png", height=480, width=480)
with(dtotal3, barplot(EmissInThou,
                      ylim = c(0,3.5),
                      xlab = "Year",
                      ylab = "PM2.5 Emissions (thousands)",
                      main = "Baltimore City, MD PM2.5 Emissions - Sum by Year"))
dev.off()


## get first observation for each Species in iris data -- base R
#mini_iris <- iris[c(1, 51, 101), ]
## gather Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
#gather(mini_iris, key = flower_att, value = measurement,
#Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
## same result but less verbose
#gather(mini_iris, key = flower_att, value = measurement, -Species)
#
## repeat iris example using dplyr and the pipe operator
#library(dplyr)
#mini_iris <-
#iris %>%
#group_by(Species) %>%
#slice(1)
#mini_iris %>% gather(key = flower_att, value = measurement, -Species)
