library(dplyr)
library(ggplot2)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
plot3 <-  baltimore %>% group_by(year, type) %>% summarize(totalEmissions = sum(Emissions))

# Plot Graph
png(file = "plot3.png", width=480, height=480)
qplot(
  year,
  totalEmissions,
  data = plot3,
  color = type,
  geom = c("point", "smooth"),
  method = "lm",
  se = FALSE,
  ylab = "PM2.5 Emissions (in tons)",
  xlab = "Year",
  main = "PM2.5 Emissions by type from 1999 to 2008 in Baltimore City"
)
dev.off()