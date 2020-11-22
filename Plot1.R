#Load the source file and Data frame
source("DownloadSourceFile.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Aggregated by sum for total emission by year
aggT <- aggregate(Emissions ~ year, NEI, sum)

png("Plot1.png")
barplot((aggT$Emissions)/10^6, names.arg = aggT$year, xlab = "Year", ylab = "PM2.5 Emission (Mill Tons)",main = "Total PM2.5 Emission ")

dev.off()
