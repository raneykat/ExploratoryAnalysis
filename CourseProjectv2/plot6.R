# Katherine Raney
# Coursera Exploratory Data Analysis
# December 2014
# Course Project 2, Plot 6

# setwd("C:\\raneykat_git\\ExploratoryDataAnalysis\\ExploratoryAnalysis\\CourseProject")

#get the data file we need and unzip it
library(downloader)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url,dest="dataset.zip", mode = "wb") 
unzip ("dataset.zip",exdir = ".")

# read in the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County,
#California (fips == "06037"). Which city has seen greater changes 
#over time in motor vehicle emissions?

library(dplyr)
scc2 <- SCC %>%
  filter(grepl('Highway Vehicles',SCC.Level.Two)) %>%
  select(SCC)

City <- c('Baltimore City','Los Angeles')
fips <- c("24510","06037")
  
c <- data.frame(City, fips)

nei2 <- NEI %>%
  inner_join(scc2, c("SCC" = "SCC")) %>%
  inner_join(c,c("fips"="fips")) %>%
  group_by(year, City) %>%
  summarise(TotalEmissions=sum(Emissions)) %>%
  select(year, City, TotalEmissions) 

library(ggplot2)
# send plot to a png file 
png(file="plot6.png",bg="transparent",width = 480, height = 480)
qplot(year, TotalEmissions, data = nei2, color=City
      ,ylab="Highway Vehicle PM2.5 Emissions", xlab="Year"
      ,main="Baltimore City vs LA Highway Vehicle PM2.5 Emissions",geom="line")
dev.off()

