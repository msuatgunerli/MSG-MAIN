library(tidyverse)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE ) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)
?coord_fixed()
(y <- seq(1, 10, length.out = 5))
#ggplot(data = mpg) +
#  geom_point(mapping = aes(x = displ, y = hwy, alpha = 0.5, color = class))
#ggplot(data = <DATA>) +
#<GEOM_FUNCTION>(mapping = aes(<MAPPINGS>)