#Load the source file and Data frame
source("DownloadSourceFile.R")

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]

# Subset the vehicles NEI data to Baltimore
NEIbaltimoreVeh <- subset(vehNEI,fips=="24510")

png("plot5.png")

library(ggplot2)

gplt <- ggplot(NEIbaltimoreVeh,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  labs(x="year", y=expression("Total PM2.5 Emission (Mill Tons)")) + 
  labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore"))

print(gplt)

dev.off()
