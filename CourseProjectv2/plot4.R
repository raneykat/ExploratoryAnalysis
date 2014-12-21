# Katherine Raney
# Coursera Exploratory Data Analysis
# December 2014
# Course Project 2, Plot 4

# setwd("C:\\raneykat_git\\ExploratoryDataAnalysis\\ExploratoryAnalysis\\CourseProject")

#get the data file we need and unzip it
library(downloader)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url,dest="dataset.zip", mode = "wb") 
unzip ("dataset.zip",exdir = ".")

# read in the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?

#NEI$year <- as.factor(NEI$year)

library(dplyr)

scc2 <- SCC %>%
    filter(grepl('[Cc]ombustion',SCC.Level.One),grepl('[Cc]oal',SCC.Level.Three)) %>%
    select(SCC)

nei2 <- NEI %>%
  inner_join(scc2, c("SCC" = "SCC")) %>%
  group_by(year) %>%
  summarise(TotalEmissions=sum(Emissions)) %>%
  select(year, TotalEmissions) 


library(ggplot2)
# send plot to a png file 
png(file="plot4.png",bg="transparent",width = 480, height = 480)
qplot(year, TotalEmissions, data = nei2,ylab="Combustion Coal PM2.5 Emissions", xlab="Year"
      ,main="US Combustion Coal PM2.5 Emissions",geom="line")
dev.off()

