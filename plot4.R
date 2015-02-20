library(dplyr)
library(ggplot2)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetSCC <- SCC %>% filter(grepl("Comb(.+)Coal", SCC$Short.Name)) %>% select(SCC, Short.Name)
joinDF <- inner_join(NEI, subsetSCC)
plot4 <- joinDF %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Plot Graph
png(file = "plot4.png")
qplot(
  year,
  totalEmissions,
  data = plot4,
  geom = c("point", "smooth"),
  method = "lm",
  se = FALSE,
  ylab = "PM2.5 Emissions (in tons)",
  xlab = "Year",
  main = "PM2.5 Emissions (in tons) for Coal Combustion-related Sources"
)
dev.off()