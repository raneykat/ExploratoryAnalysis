# Katherine Raney
# Coursera Exploratory Data Analysis
# December 2014

# setwd("C:\\raneykat_git\\ExploratoryDataAnalysis\\ExploratoryAnalysis\\CourseProject")

#get the data file we need and unzip it
library(downloader)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url,dest="dataset.zip", mode = "wb") 
unzip ("dataset.zip",exdir = ".")

# read in the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? 
#Using the base plotting system, make a plot showing 
#the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

#plot of emissions by year
# dataset only includes the ps25 emissions
