# Katherine Raney
# Coursera Exploratory Data Analysis
# December 2014
# Course Project 2, Plot 3

# setwd("C:\\raneykat_git\\ExploratoryDataAnalysis\\ExploratoryAnalysis\\CourseProject")

#get the data file we need and unzip it
library(downloader)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url,dest="dataset.zip", mode = "wb") 
unzip ("dataset.zip",exdir = ".")

# read in the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# plot emissions by year and type for the given city - GIVEN CITY FOR BOTH QUESTIONS? 

library(dplyr)

nei2 <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  mutate(TotalEmissions=sum(Emissions)) %>%
  select(year, type, TotalEmissions) 

library(ggplot2)
# send plot to a png file 
png(file="plot3.png",bg="transparent",width = 800, height = 800)
qplot(year, TotalEmissions, data = nei2, facets =.~ type,ylab="Total PM2.5 Emissions", xlab="Year"
      ,main="Baltimore City PM2.5 Emissions by Type",geom="line")
dev.off()
