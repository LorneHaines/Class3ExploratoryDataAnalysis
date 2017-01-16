# Title: plot5.R
# Purpose: Create a plot to help determine emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City
# combustion sources have changed from 1999-2008
# Date: 12/12/2016

library(ggplot2)
setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset data
Baltimore <- subset(NEI, fips == "24510")

# searching for names that have vehicles
vehicle_indicies <- grep("[Vv]ehicles", SCC$Short.Name)

# getting id's of vehicle sources of pollution in a vector
vehicle_SCC <- SCC$SCC[vehicle_indicies]

# subsetting Baltimore data to only include vehicle pollution
vehicledata <- subset(Baltimore, SCC %in% vehicle_SCC)
# finiding sum of vehicle emmissions per each year
vehicledata <- aggregate(Emissions ~ year + type, data = vehicledata, sum)

# creating bar plot for vehicle emissions nationwide for each year
png("plot5.png")
g <- ggplot(vehicledata, aes(factor(year), Emissions))
g + geom_col() + 
        xlab("Year") +
        ylab("Total Tons of PM 2.5") +
        ggtitle("Total Baltimore Vehicle Emissions from 1999 to 2008")
dev.off()

