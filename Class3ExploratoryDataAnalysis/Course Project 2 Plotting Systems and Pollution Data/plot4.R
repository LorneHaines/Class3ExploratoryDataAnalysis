# Title: plot4.R
# Purpose: Create a plot to help determine how emmisions from coal
# combustion sources have changed from 1999-2008
# Date: 12/12/2016

library(ggplot2)
setwd("F:/Coursera/Course 4 Exploratory Data Analysis/Course_Proj_2")

# reads in data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#searches for coal in the names of sources of pollution and returns indicies where it is found
coal_indicies <- grep("[Cc]oal", SCC$Short.Name)

# puts all the source id's associated with coal into alist
coal_SCC <- SCC$SCC[coal_indicies]

# subsets the emmisions data to include observations with coal
coaldata <- subset(NEI, SCC %in% coal_SCC)

# making plot for coal combustion related resources by type
# its not very helpful, so we will try totals
xyplot(Emissions ~ year | type, data = coaldata)

# finding total coal emmisions for each year
Total_by_year <- aggregate(Emissions ~ year + type, coaldata, sum)


# coal emmision total by year plotted in a histogram
png("plot4.png")
g <- ggplot(Total_by_year, aes(year, Emissions))
g <- g + geom_col() +
        xlab("Year") + 
        ylab("Total Tons of PM2.5") +
        ggtitle("Total Emmisions from Coal Sourses from 1999 to 2008")
print(g)
dev.off()


