#Load the source file and Data frame
source("DownloadSourceFile.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset Data by Baltimore
NEIbaltimore <- subset(NEI, fips == "24510")

#Aggregate by sum for Baltimore emissions data by year
aggTbaltimore <- aggregate(Emissions ~ year, NEIbaltimore, sum)

png("Plot2.png")
barplot((aggTbaltimore$Emissions)/10^6, names.arg = aggTbaltimore$year, xlab = "Year", ylab = "PM2.5 Emission (Mill Tons)",main = "Total PM2.5 Emission in Baltimore City ")

dev.off()
