library(tidyverse) 
library(modelr) 
options(na.action = na.warn)

library(nycflights13)
library(lubridate)

# Diamonds Data -----------------------------------------------------------

ggplot(diamonds, aes(cut, price)) +
  geom_boxplot() 
ggplot(diamonds, aes(color, price)) +
  geom_boxplot() 
ggplot(diamonds, aes(clarity, price)) + 
  geom_boxplot()

ggplot(diamonds, aes(carat, price)) +
  geom_hex(bins = 50)

# Focus on diamonds smaller than 2.5 carats (99.7% of the data).
# Log-transform the carat and price variables:

diamonds2 <- diamonds %>% 
  filter(carat <= 2.5) %>% 
  mutate(lprice = log2(price), lcarat = log2(carat))

ggplot(diamonds2, aes(lcarat, lprice)) + 
  geom_hex(bins = 50)

# We first make the pattern explicit by fitting a model:

mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

# back-transform the predictions, undoing the log transformation, so I can overlay the predictions on the raw data

grid <- diamonds2 %>%
  data_grid(carat = seq_range(carat, 20)) %>% 
  mutate(lcarat = log2(carat)) %>% 
  add_predictions(mod_diamond, "lprice") %>% 
  mutate(price = 2 ^ lprice)

ggplot(diamonds2, aes(carat, price)) + 
  geom_hex(bins = 50) + 
  geom_line(data = grid, color = "red", size = 1)

# Now we can look at the residuals, which verifies that we’ve successfully removed the strong linear pattern

diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond, "lresid")

ggplot(diamonds2, aes(lcarat, lresid)) + 
  geom_hex(bins = 50)

# redo our motivating plots using those residuals instead of price:

ggplot(diamonds2, aes(cut, lresid)) + geom_boxplot() 
ggplot(diamonds2, aes(color, lresid)) + geom_boxplot() 
ggplot(diamonds2, aes(clarity, lresid)) + geom_boxplot()

#include color, cut, and clarity into the model so that we also make explicit the effect of these three categorical variables
mod_diamond2 <- lm(
  lprice ~ lcarat + color + cut + clarity,
  data = diamonds2
  )

# To make the process a little easier, we’re going to use the .model argument to data_grid:
grid <- diamonds2 %>%
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)
grid

ggplot(grid, aes(cut, pred)) + 
  geom_point()

diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond2, "lresid2")
ggplot(diamonds2, aes(lcarat, lresid2)) + 
  geom_hex(bins = 50)

# look at unusual values individually

diamonds2 %>% 
  filter(abs(lresid2) > 1) %>% 
  add_predictions(mod_diamond2) %>% 
  mutate(pred = round(2 ^ pred)) %>% 
  select(price, pred, carat:table, x:z) %>% 
  arrange(price)


# Flights13 Data Analysis -------------------------------------------------
# the number of flights that leave NYC per day, counting the number of flights per day and visualizing it 
daily <- flights %>%
  mutate(date = make_date(year, month, day)) %>% 
  group_by(date) %>% 
  summarize(n = n())
daily

ggplot(daily, aes(date, n)) +
  geom_line()

# looking at the distribution of flight numbers by day of week:

daily <- daily %>% 
  mutate(wday = wday(date, label = TRUE))

ggplot(daily, aes(wday, n)) + 
  geom_boxplot()

#One way to remove this strong pattern is to use a model. First, we fit the model, and display its predictions overlaid on the original data:

mod <- lm(
  n ~ wday, data = daily)

grid <- daily %>% 
  data_grid(wday) %>% 
  add_predictions(mod, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() + 
  geom_point(data = grid, color = "red", size = 4)

# compute and visualize the residuals:

daily <- daily %>% 
  add_residuals(mod)

daily %>% 
  ggplot(aes(date, resid)) + 
  geom_ref_line(h = 0) +
  geom_line()

# Our model seems to fail starting in June: you can still see a strong regular pattern that our model hasn’t captured. Drawing a plot with one line for each day of the week makes the cause easier to see:

ggplot(daily, aes(date, resid, color = wday)) + 
  geom_ref_line(h = 0) + 
  geom_line()

# Our model fails to accurately predict the number of flights on Saturday: during summer there are more flights than we expect, and during fall there are fewer.
#There are some days with far fewer flights than expected:

daily %>% 
  filter(resid < -100)

#There seems to be some smoother long-term trend over the course of a year. We can highlight that trend with geom_smooth()

daily %>% 
  ggplot(aes(date, resid)) + 
  geom_ref_line(h = 0) +
  geom_line(color = "grey50") + 
  geom_smooth(se = FALSE, span = 0.20)
#> `geom_smooth()` using method = 'loess'

#Let’s first tackle our failure to accurately predict the number of flights on Saturday. 

daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n)) + 
  geom_point() + 
  geom_line() + 
  scale_x_date( 
    NULL,
    date_breaks = "1 month", 
    date_labels = "%b"
  )

#it’s less common to plan family vacations during the fall because of the big Thanksgiving and Christmas holidays.
#create a “term” variable that roughly captures the three school terms, and check our work with a plot:

term <- function(date) { 
  cut(date, breaks = ymd(20130101, 20130605, 20130825, 20140101), 
      labels = c("spring", "summer", "fall")
  ) 
}

daily <- daily %>% 
  mutate(term = term(date))

daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n, color = term)) + 
  geom_point(alpha = 1/3) + 
  geom_line() + 
  scale_x_date( 
    NULL,
    date_breaks = "1 month", 
    date_labels = "%b"
)

#see how this new variable affects the other days of the week:

daily %>% 
  ggplot(aes(wday, n, color = term)) + 
  geom_boxplot()

#there is significant variation across the terms, so fitting a separate day-of-week effect for each term is reasonable

mod1 <- lm(n ~ wday, data = daily) 
mod2 <- lm(n ~ wday * term, data = daily)

daily %>%
  gather_residuals(without_term = mod1, with_term = mod2) %>% 
  ggplot(aes(date, resid, color = model)) + 
  geom_line(alpha = 0.75)

#see the problem by overlaying the predictions from the model onto the raw data:

grid <- daily %>% 
  data_grid(wday, term) %>% 
  add_predictions(mod2, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() + 
  geom_point(data = grid, color = "red") +
  facet_wrap(~ term)

#alleviate this problem by using a model that is robust to the effect of outliers: MASS::rlm(). This greatly reduces the impact of the outliers on our estimates

mod3 <- MASS::rlm(n ~ wday * term, data = daily)

daily %>%
  add_residuals(mod3, "resid") %>% 
  ggplot(aes(date, resid)) + 
  geom_hline(yintercept = 0, size = 2, color = "white") + 
  geom_line()

#We could use a more flexible model and allow that to capture the pattern we’re interested in. A simple linear trend isn’t adequate, so we could try using a natural spline to fit a smooth curve across the year:

library(splines) 
mod <- MASS::rlm(n ~ wday * ns(date, 5), data = daily)

daily %>% 
  data_grid(wday, date = seq_range(date, n = 13)) %>% 
  add_predictions(mod) %>% 
  ggplot(aes(date, pred, color = wday)) + 
  geom_line() + 
  geom_point()