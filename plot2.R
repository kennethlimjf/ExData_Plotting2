library(dplyr)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
plot2 <-  baltimore %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))
model <- lm(totalEmissions ~ year, plot2)

# Plot Graph
png(file = "plot2.png", width=480, height=480)
par(mar = c(6, 6, 5, 4))
with(
  plot2,
  plot(
    year,
    totalEmissions,
    main = "PM2.5 Emission (in tons) from Year 1999 to 2008",
    sub = "Baltimore City, Maryland",
    xlab = "Year",
    ylab = "Total PM2.5 Emitted (in tons)",
    ylim = c(0, max(totalEmissions) * 1.1),
    pch = 20
  )
)
abline(model)
dev.off()