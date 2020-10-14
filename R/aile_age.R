library(tidyverse)
library(ggplot2)
#
data1 <- tibble( 
  Age = c(41,50,60,62,66,70,70,71,72,75,76,76,77,78,79,80,81,83,83,85,88,88,91,91,93,115),
  Index = 1:26
)

data2 <- select(data1,Index,Years_Alive = Age)
print(data2)

data2 %>%
  summarize(
  mean_age =  mean(Years_Alive),
  median_age = median(Years_Alive),
  stdev_age = sd(Years_Alive),
  quart1_age = quantile(Years_Alive, 0.25),
  quart2_age = quantile(Years_Alive, 0.75)
  )

ggplot(data2, aes(x = Index, y = Years_Alive)) +
  #geom_bar(aes(Index, Years_Alive, color = Years_Alive), stat = "identity") +
  #geom_point(aes(Index, Years_Alive, color = Years_Alive, size = Years_Alive), stat = "identity") +
  geom_boxplot(aes(Index, Years_Alive), color = "blue", 
               fill = "black", outlier.color= "red", outlier.shape=16, notch = FALSE)+
  #stat_summary(fun.y = mean, geom = "point")+
  coord_flip()
