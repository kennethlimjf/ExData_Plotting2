library(dplyr)
library(ggplot2)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetSCC <- SCC %>% filter(Data.Category == "Onroad") %>% select(SCC, Short.Name)
subsetNEI <- NEI %>% filter(fips == "24510")
joinDF <- inner_join(subsetNEI, subsetSCC)
plot5 <- joinDF %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Plot Graph
png(file = "plot5.png")
qplot(
  year,
  totalEmissions,
  data = plot5,
  geom = c("point", "smooth"),
  method = "lm",
  se = FALSE,
  ylab = "PM2.5 Emissions (in tons)",
  xlab = "Year",
  main = "PM2.5 Emissions from Motor Vehicle Sources in Baltimore City"
)
dev.off()