## ---- plot1 ----
## Validate if the code is executing from the R Markdown file
isChunkCode <- ifelse(exists("isChunkCode"), isChunkCode, FALSE)

## Getting and loading the data
#### The data must be stored in the **data** folder
if(!isChunkCode){
    ##Set the working Directory
    wdPath <- "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Exploratory Data Analysis/Week4/CourseProject/source"
    setwd(wdPath)
    ## Include the necessary R packages.
    library(dplyr)
    ## Load the data
    rdsEmi <- readRDS("data/summarySCC_PM25.rds")
    rdsSource <-readRDS("data/Source_Classification_Code.rds")
}

#### Using the Base Plotting system, make a plot showing the total PM2.5 emission 
#### from all sources for each of the years 1999, 2002, 2005, and 2008
byYear <- tbl_df(rdsEmi[,c("year","Emissions")])
byYear <- byYear %>% group_by(year)

##### Get the total amount of PM per year
emiYear <- byYear %>% summarise (totalPM = sum(Emissions))
##### Calculate the regresion model of the data across the years
lmEmiYear <- lm(totalPM~year, data=emiYear)

##### open the png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(emiYear, main = "Total PM2.5 per year", xlab = "Year", ylab = "Total PM2.5", xlim = range(1998:2008))
lines(emiYear$year, fitted(lmEmiYear), col="blue", lwd = 3)
dev.off()

#### Question1: 
##### *Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?*

#### Answer: 
###### *The total amount of PM was decreased like the blue line show (Linerar regresion)*