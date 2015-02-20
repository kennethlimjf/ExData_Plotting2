library(dplyr)
library(ggplot2)

setwd("~/r_projects/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetSCC <- SCC %>% filter(Data.Category == "Onroad") %>% select(SCC, Short.Name)
subsetNEI <- NEI %>% filter(fips == "24510" | fips == "06037")
joinDF <- inner_join(subsetNEI, subsetSCC)
plot6 <- joinDF %>% mutate(city=ifelse(fips == "24510", "Baltimore", "Los Angeles")) %>% group_by(year, city) %>% summarize(totalEmissions = sum(Emissions))

plot6.1 <- plot6 %>% filter(city == "Baltimore")
lm1 <- lm(totalEmissions ~ year, data = plot6.1)
coef1 <- as.character(round(lm1$coefficients[2],2))

plot6.2 <- plot6 %>% filter(city == "Los Angeles")
lm2 <- lm(totalEmissions ~ year, data = plot6.2)
coef2 <- as.character(round(lm2$coefficients[2],2))

# Plot Graph
png(file = "plot6.png", width=680, height=480)
g <- ggplot(plot6, aes(year, totalEmissions, color = city))
g + geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    scale_colour_manual(
      name = 'City: Coefficient',
      values = c("Baltimore"="springgreen3", "Los Angeles"="tomato"),
      labels = c(paste("Baltimore: ",coef1), paste("Los Angeles: ", coef2))
    ) +
    labs(x = "Year") +
    labs(y = "PM2.5 Emissions (in tons)") +
    labs(title = "PM2.5 Emissions from Motor Vehicle Sources in Baltimore and Los Angeles Cities")
dev.off()