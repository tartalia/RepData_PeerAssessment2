library(dplyr)
library(ggplot2)
library(scales)

storms <- read.csv('repdata-data-StormData.csv', header=TRUE, comment.char="")
healthDamageByEventType <- summarise(group_by(storms, EVTYPE), totalFatalities = sum(FATALITIES), totalInjuries = sum(INJURIES))
healthDamageByEventType <- filter(healthDamageByEventType, totalFatalities != 0, totalInjuries != 0)
topFatalities <- slice(arrange(healthDamageByEventType, desc(totalFatalities)), 1:20)
topInjuries <- slice(arrange(healthDamageByEventType, desc(totalInjuries)), 1:20)

topFatalitiesGraph <- ggplot(topFatalities, aes(x = reorder(EVTYPE, totalFatalities) , y = totalFatalities))
topFatalitiesGraph + geom_bar(stat = "identity", width = .5) + coord_flip() + xlab("Event Type") + ylab("Total Fatalities") + ggtitle("Fatalities By Event Type (Top 20)")

topInjuriesGraph <- ggplot(topInjuries, aes(x = reorder(EVTYPE, totalInjuries) , y = totalInjuries))
topInjuriesGraph + geom_bar(stat = "identity", width = .5) + coord_flip() + xlab("Event Type") + ylab("Total Injuries") + ggtitle("Injuries By Event Type (Top 20)")




topDamagesGraph <- ggplot(topDamages, aes(x = reorder(EVTYPE, totalDamage) , y = totalDamage))
topDamagesGraph + geom_bar(stat = "identity", width = .5) + coord_flip() + scale_y_continuous(labels = comma) + xlab("Event Type") + ylab("Total Damage ($)") + ggtitle("Damages By Event Type (Top 20)")

