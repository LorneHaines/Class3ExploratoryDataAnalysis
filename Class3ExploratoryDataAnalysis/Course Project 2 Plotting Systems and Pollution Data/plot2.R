# Title: plot2.R
# Purpose: Make plot seeing if PM2.5 emmissions  have decreased 
# in Baltimore City from 1999 to 2008
# Date: 12/12/2016

setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")

# reading in data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emmisions decreased in Baltimore from 1999 to 2008?
# subset data so only includes baltimore observations
Baltimore <- subset(NEI, fips == "24510")

# plotting all data for baltimore its hard to determine a pattern, so will look at sums
with(Baltimore, plot(year, Emissions, xlab = "Year", ylab = "Tons of PM2.5", 
                     main = "Baltimore PM2.5 Levels from 1999 to 2008")) 

# spliting data by year and finding sum for each year
balt_year_total <- aggregate(Emissions ~ year, data = NEI, sum)

png("plot2.png")
# creating a bar plot of total PM 2.5 levles in Baltimore
with(balt_year_total, barplot(height = Emissions, names.arg = year, 
        xlab = "Years", ylab = "Tons of PM2.5", 
        main = "Yearly Total Baltimore PM2.5 Levels from 1999 to 2008"))
dev.off()