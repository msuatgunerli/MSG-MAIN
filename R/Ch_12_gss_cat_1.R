library(tidyverse)
library(forcats)

forcats::gss_cat
#?forcats::gss_cat

gss_cat %>%
  count(race)

ggplot(gss_cat,aes(race)) +
  geom_bar() +
  scale_x_discrete(drop=FALSE)

relig <- gss_cat %>%
  group_by(relig) %>%
  summarize(
    age = mean(age, na.rm=TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) + geom_point()

#veya aynı plotu aes dışında daha organize şekilde

relig %>% 
  mutate(relig = fct_reorder(relig, tvhours)) %>% 
  ggplot(aes(tvhours, relig)) + geom_point()
#-------------------------------------------------------------------------------
rincome <- gss_cat %>% 
  group_by(rincome) %>% 
  summarize( 
    age = mean(age, na.rm = TRUE), 
    tvhours = mean(tvhours, na.rm = TRUE), 
    n = n()
)
#-------------------------------------------------------------------------------
#mean median deneme
gss_cat %>%
  group_by(rincome) %>% 
    tvhours1 <-  mean(tvhours, na.rm = TRUE) %>%
    tvhours2 <-  median(tvhours, na.rm = TRUE) %>%
ggplot(relig, aes(tvhours1,relig), color = "blue") +
  geom_point()
#-------------------------------------------------------------------------------
ggplot(rincome, aes(age, rincome)) + 
  geom_point() #+\
  #scale_y_reverse()

ggplot( rincome, aes(age, fct_relevel(rincome, "Not applicable"))
) + geom_point()

###################################################################

by_age <- gss_cat %>% 
  filter(!is.na(age)) %>% 
  group_by(age, marital) %>% 
  count() %>% 
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, color = marital)) + 
  geom_line(na.rm = TRUE)

ggplot( 
  by_age, 
  aes(age, prop, color = fct_reorder2(marital, age, prop))
) +
  geom_line() + 
  labs(color = "marital")

gss_cat %>% 
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>% 
  ggplot(aes(marital)) +
    geom_bar()
