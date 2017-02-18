rm(list = ls())
##  Coursera Data Science Specialization by Johns Hopkins University
##  Course 4 - Exploratory Data Analysis
##  Week 4 Assignment - PM2.5 Fine Particulate Matter
##  Plot 2
##  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
##  from 1999 to 2008? Use the base plotting system to make a plot answering this question.


## Read in the source data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("C:/Users/cowens/Documents/Coursera-Exploratory/Week4_Assignment/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/cowens/Documents/Coursera-Exploratory/Week4_Assignment/Source_Classification_Code.rds")

## checking out what's in the source data
str(NEI)
head(NEI)
summary(NEI)

## subset the source data to only read Baltimore City, Maryland (fips == "24510")
## keep only only the year and the Emissions data
NEI0 <- subset(NEI, fips == "24510", c(year,Emissions))

## use tapply function to separate the data by year and get the sums for those years
sum0 <- with(NEI0, tapply(Emissions, year, sum, na.rm=T))

## convert this into a data frame
dtotal <- data.frame(year = names(sum0), sum = sum0)

## make a new column called EmissionsInMills so your plot will be more easily readable
dtotal$EmissInThou <- with(dtotal, sum/1000)


## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename="Plot2.png", height=480, width=480)
with(dtotal, barplot(EmissInThou,
                  ylim = c(0,3.5),
                  xlab = "Year",
                  ylab = "PM2.5 Emissions (thousands)",
                  main = "Baltimore City, MD PM2.5 Emissions - Sum by Year"))
dev.off()


