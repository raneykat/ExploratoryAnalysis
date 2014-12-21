# Katherine Raney
# Coursera Exploratory Data Analysis
# December 2014
# Course Project 2, Plot 2

# setwd("C:\\raneykat_git\\ExploratoryDataAnalysis\\ExploratoryAnalysis\\CourseProjectv2")

#get the data file we need and unzip it
library(downloader)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url,dest="dataset.zip", mode = "wb") 
unzip ("dataset.zip",exdir = ".")

# read in the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? 


#plot of TOTAL emissions by year
# dataset only includes the ps25 emissions

library(dplyr)

nei2 <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(TotalEmissions=sum(Emissions)) %>%
  select(year,TotalEmissions) 

# send plot to a png file 
png(file="plot2.png",bg="transparent",width = 480, height = 480)
with(nei2,plot(year,TotalEmissions,ylab="Total PM2.5 Emissions", xlab="Year"
               ,main="Baltimore City PM2.5 Emissions",type="o"))
dev.off()

