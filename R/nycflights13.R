library(nycflights13)
library(tidyverse)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))
near(sqrt(2)^2,2)
filter(flights, month == 11|month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))
#X1 <-  2
#is.na(X1)
#filter(flights, is.na(dep_time))
arrange(flights, order(year), month, day)

flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
transmute(flights, gain = arr_delay - dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)
flights_sml_modified <- mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60, hours = air_time / 60, gain_per_hour = gain / hours)
select(flights_sml_modified, gain, speed, hours, gain_per_hour, everything())

transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)
1:3 + 1:10

by_day <- group_by(flights, year, month)
#view(by_day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE)) #average monthly delay

by_dest <- group_by(flights, dest) 
delay <- summarize(by_dest, 
  count = n(),
  dist = mean(distance, na.rm = TRUE), delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)

delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize( delay = mean(arr_delay, na.rm = TRUE),
  n = n())
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)