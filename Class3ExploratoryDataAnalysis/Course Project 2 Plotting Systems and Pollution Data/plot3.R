# Title: plot3.R
# Purpose: Create a plot to help determine which four types of 
# sources of of polution have decreased in Baltimore from 199 to 2008
# Date: 12/12/2016

setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")
library(ggplot2)
library(tidyr)

# reading in data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emmisions of each type decreased in Baltimore from 1999 to 2008?
# subset data so it includes only baltimore
Baltimore <- subset(NEI, fips == "24510")

# creating plot with all data points for each year and type in baltimore
g <- ggplot(Baltimore, aes(year, Emissions))
g + geom_point() + facet_grid(~ as.factor(type))


# graphs where unclear whether decreasing or decreasing, so finding
# sum for each year then graphing
totalmiss <- with(Baltimore, tapply(Emissions, list(year, type), sum))
total_type <- data.frame(year = rownames(totalmiss), totalmiss)

# changes data frame from short format to long format where
# type of pollution is a factor varialbe
long_total_type <- gather(total_type, key = type, Emissions, 2:5, factor_key = T)

# plots emmisions for each pollution type as seperate graphs
g2 <- ggplot(long_total_type, aes(year, Emissions, group = type))
g2 <- g2 + geom_line() + facet_grid(~ as.factor(type)) +
        xlab("year") +
        ylab("Total Tons of PM2.5") +
        ggtitle("Total Emmisions in Baltimore from 1999 to 2008")
print(g2)

png("plot3.png")
# total for each year on one plot
g3 <-  ggplot(long_total_type, aes(year, Emissions, color = type, group = type))
g3<- g3 + geom_line() +
        xlab("Year") +
        ylab("Total Tons of PM2.5") +
        ggtitle("Total Emmisions in Baltimore from 1999 to 2008")
print(g3)
dev.off()
        