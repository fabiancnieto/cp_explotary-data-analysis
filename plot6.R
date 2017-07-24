## ---- plot4 ----
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

#### Read the sources related to coal combustion
motorPos <- grep("motor|vehicle", rdsSource$EI.Sector, ignore.case = TRUE)
motorSource <- rdsSource[motorPos, c("SCC", "Data.Category")]

#### Using the Base Plotting system, make a plot showing the total PM2.5 emission 
#### from all sources for each of the years 1999, 2002, 2005, and 2008
byYear <- tbl_df(rdsEmi[,c("SCC","fips","year","type","Emissions")])
byYearMotorEmi <-
    byYear %>% filter(SCC %in% motorSource$SCC & (fips == "24510" | fips == "06037")) %>% 
        mutate(city = ifelse(fips == "24510", "Baltimore City", "Los Angeles")) %>% 
        group_by(year, type, city)

##### Get the total amount of PM per year
emiYear <- byYearMotorEmi %>% summarise (totalPM = sum(Emissions))

##### open the png device
png(filename = "plot6.png", width = 960, height = 960, units = "px")

ggplot(data = emiYear, aes(x = year, y = totalPM)) +
    ggtitle("Total PM2.5 from motor related sources in Baltimore City / Los Angeles per year") +
    geom_point() +
    facet_grid(. ~ city) +
    geom_smooth(method = "lm", se = TRUE, level = 0.1) +
    xlab ("Year") + ylab("Total PM2.5")

dev.off()

#### Question6: 
##### *Which city has seen greater changes over time in motor vehicle emissions between Baltimore City and Los Angeles?*

#### Answer: 
###### *Baltimore City was decreased its PM values while Los Angeles City was increased its PM values*