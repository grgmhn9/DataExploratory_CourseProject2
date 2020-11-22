#Load the source file and Data frame
source("DownloadSourceFile.R")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
combRel <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRel <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalComb <- (combRel & coalRel)
combSCC <- SCC[coalComb,]$SCC
combNEI <- NEI[NEI$SCC %in% combSCC,]

png("plot4.png")

library(ggplot2)

gplt <- ggplot(combNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM2.5 Emission (Mill Tons)")) + 
  labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US "))

print(gplt)

dev.off()