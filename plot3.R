## ---- plot3 ----
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
    library(ggplot2)
    ## Load the data
    rdsEmi <- readRDS("data/summarySCC_PM25.rds")
    rdsSource <-readRDS("data/Source_Classification_Code.rds")
}

#### Using the Base Plotting system, make a plot showing the total PM2.5 emission 
#### from all sources for each of the years 1999, 2002, 2005, and 2008
byYear <- tbl_df(rdsEmi[,c("fips","year","type","Emissions")])
byYearTypeBaltimore <- byYear %>% filter(fips == "24510") %>% group_by(year, type)

##### Get the total amount of PM per year
emiYear <- byYearTypeBaltimore %>% summarise (totalPM = sum(Emissions))

##### open the png device
png(filename = "plot3.png", width = 960, height = 960, units = "px")

ggplot(data = emiYear, aes(x = year, y = totalPM)) +
    ggtitle("Total PM2.5 per year and type in Baltimore City, Maryland") +
    facet_grid(type ~ .) +
    geom_smooth(method = "lm", se = FALSE) +
    coord_cartesian(ylim = c(0:2010))

dev.off()

#### Question3: 
##### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable:
##### *Which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
##### *Which have seen increases in emissions from 1999–2008?

#### Answer: 
###### *The sources * **NON-ROAD, NON-POINT and ON-ROAD** *was decreased like the line show (Linerar regresion)*
###### *The source * **POINT** *was increased like the line show (Linerar regresion)*