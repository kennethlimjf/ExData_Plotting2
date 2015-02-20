library(dplyr)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
plot1 <- NEI %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# Plot Graph
png(file = "plot1.png", width=480, height=480)
par(mar = c(6, 6, 5, 4))
with(
  plot1,
  barplot(
    totalEmissions,
    names.arg = year,
    col = heat.colors(6),
    main = "Total PM2.5 Emission (in tons) from Year 1999 to 2008",
    ylab = "Total PM2.5 Emitted (in tons)",
    xlab = "Year"
  )
)
dev.off()