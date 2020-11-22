#Load the source file and Data frame
source("DownloadSourceFile.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
veh<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
NEIBaltimoreveh <- subset(vehNEI,fips=="24510")
NEIBaltimoreveh$city <- "Baltimore City"

NEILAveh <- subset(vehNEI,fips=="06037")
NEILAveh$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
both <- rbind(NEIBaltimoreveh,NEILAveh)

png("plot6.png")

library(ggplot2)

gplt <- ggplot(both, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM2.5Emission (Kilo-Tons)")) + 
  labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA"))

print(gplt)

dev.off()
