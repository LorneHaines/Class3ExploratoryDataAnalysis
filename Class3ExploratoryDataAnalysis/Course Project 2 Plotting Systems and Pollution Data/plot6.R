# Title: plot6.R
# Purpose: Create graphs to help determine if Emissions from motor vehicle 
# sources in Baltimore City  or Los Angeles County, California
# are changing greater over time
# Date: 12/12/2016


setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")
library(ggplot2)
# read in data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# searching for names that have vehicles
vehicle_indicies <- grep("[Vv]ehicles", SCC$Short.Name)

# getting id's of vehicle sources of pollution in a vector
vehicle_SCC <- SCC$SCC[vehicle_indicies]

# subsetting data to only include vehicle pollution
vehicledata <- subset(NEI, vehicle_SCC %in% NEI$SCC)

# subsetting data so it only includes Los Angeles County CA
Baltimore_LA_Data <- subset(vehicledata, fips == "24510" | fips == "06037")

# fiinding sums for each location and year
Baltimore_LA_vehcicle_sums <- aggregate(Emissions ~ year + fips, data = Baltimore_LA_Data, sum)

# making a new column with location name instead of fips
Baltimore_LA_vehcicle_sums$Location.Name <- gsub("24510", "Baltimore City", Baltimore_LA_vehcicle_sums$fips)
Baltimore_LA_vehcicle_sums$Location.Name <- gsub("06037", "Los Angeles County, California", Baltimore_LA_vehcicle_sums$Location.Name)

png("plot6.png")
# ploting vehicle emmisions in LA county and baltimore
g <- ggplot(data = Baltimore_LA_vehcicle_sums, mapping = aes(year, Emissions, color = Location.Name, group = Location.Name))
g + geom_line() +
        xlab("Year") +
        ylab("Total Tons of PM2.5") +
        ggtitle("Total Vehicle Emissions from 1999 to 2008")
dev.off()



