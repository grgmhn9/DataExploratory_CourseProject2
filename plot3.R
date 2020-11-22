#Load the source file and Data frame
source("DownloadSourceFile.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset Data by Baltimore
NEIbaltimore <- subset(NEI, fips == "24510")

#Aggregate by sum for Baltimore emissions data by year
aggTbaltimore <- aggregate(Emissions ~ year, NEIbaltimore, sum)

png("Plot3.png")

library(ggplot2)


gplt <- ggplot(NEIbaltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free")  + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City by Source Type"))
  
print(gplt)


dev.off()
