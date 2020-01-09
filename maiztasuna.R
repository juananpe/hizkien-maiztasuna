setwd("/opt/hizkien-maiztasuna/")
freq <- read.csv(file = 'table.csv',header = FALSE)
head(freq)
names(freq) <- c("hizkia", "maiztasuna")

# lock in factor level order
freq$hizkia <- factor(freq$hizkia, levels = freq$hizkia)

library(ggplot2)
library(dplyr)
library(scales)
library(gridExtra)


freq %>% 
  mutate(perc = maiztasuna / sum(maiztasuna)) -> freq


# remove values (text) < 0.044
# freq %>% mutate(perc = replace(perc, perc<=0.044, NaN)) -> freq

ggplot(data=freq, aes(x=hizkia, y=perc)) + geom_bar(stat="identity",
                                                    width = 0.9, 
                                                    position = position_nudge(x = 0.4), lwd=0.5) + 
  geom_text(data = subset(freq, perc>0.043) , stat='identity', aes(label=paste(perc %>% round(3))), colour="black", vjust=-0.25, nudge_x = 0.2) +
  scale_y_continuous(labels=scales::percent) + 
  theme(axis.title.x=element_blank(), axis.title.y=element_blank())


# 
# grid.arrange( irudia, irudia, nrow = 2, 
#              top = "Hizkien agerpen maiztasuna")
