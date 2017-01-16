# Title: plot1.R
# Purpose: Make plot showing total Pm2.5 emmisions from all sources
# Date: 12/12/2016

setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")

# reading in data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# making years a factor variable so the data can be easily summarized by year
NEI$year <- as.factor(NEI$year)
# finding sum of emmisions for each year in the pm2.5 dataset
totalemiss <- with(NEI, tapply(Emissions, year, sum))

# making the plot
# chaging dates from character to numeric
names(totalemiss) <- as.numeric(names(totalemiss))

# creating plot with pm2.5 emmisions from all sources
png('plot1.png')
plot(names(totalemiss), totalemiss, pch = 19, xlab = "Year", 
     ylab = "Tons of PM2.5", main = "Average PM2.5 Levels from 1999 to 2008")
dev.off()
