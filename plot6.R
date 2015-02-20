library(dplyr)
library(ggplot2)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetSCC <- SCC %>% filter(Data.Category == "Onroad") %>% select(SCC, Short.Name)
subsetNEI <- NEI %>% filter(fips == "24510" | fips == "06037")
joinDF <- inner_join(subsetNEI, subsetSCC)
plot6 <- joinDF %>% mutate(city=ifelse(fips == "24510", "Baltimore", "Los Angeles")) %>% group_by(year, city) %>% summarize(totalEmissions = sum(Emissions))

# Plot Graph
png(file = "plot6.png", width=680, height=480)
qplot(
  year,
  totalEmissions,
  data = plot6,
  color = city,
  geom = c("point", "smooth"),
  method = "lm",
  se = FALSE,
  ylab = "PM2.5 Emissions (in tons)",
  xlab = "Year",
  main = "PM2.5 Emissions from Motor Vehicle Sources in Baltimore and Los Angeles Cities"
)
dev.off()