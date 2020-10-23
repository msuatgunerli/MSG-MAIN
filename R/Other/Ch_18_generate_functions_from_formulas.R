library(tidyverse)
library(modelr)

# residuals ---------------------------------------------------------------
mod1 <- lm(y ~ x, data = sim1)

grid <- sim1 %>%
  data_grid(x) %>%
  add_predictions(mod1)
grid

ggplot(sim1, aes(x)) + 
  geom_point(aes(y = y)) +
  geom_line( 
    aes(y = pred),
    data = grid,
    colour = "red", size = 1
  )

sim1 <- sim1 %>% 
  add_residuals(sim1_mod)
sim1

ggplot(sim1, aes(resid)) +
  geom_freqpoly(binwidth = 0.5)

ggplot(sim1, aes(x, resid)) + 
  geom_ref_line(h = 0) + 
  geom_point()

# 1 -----------------------------------------------------------------------


ggplot(sim2) +
  geom_point(aes(x,y))

mod2 <- lm(y ~ x, data = sim2)

grid <- sim2 %>% 
  data_grid(x) %>% 
  add_predictions(mod2)
grid

ggplot(sim2, aes(x)) + 
  geom_point(aes(y = y)) + 
  geom_point( 
    data = grid, 
    aes(y = pred), 
    color = "red", 
    size = 4
)

# categorical varaibles ---------------------------------------------------


df <- tribble(
  ~ sex, ~ response, 
  "male", 1, 
  "female", 2,
  "male", 1
)
model_matrix(df, response ~ sex)

# combination of continuous and categorical vars --------------------------

ggplot(sim3, aes(x1, y)) + 
  geom_point(aes(color = x2))

mod1 <- lm(y ~ x1 + x2, data = sim3) 
mod2 <- lm(y ~ x1 * x2, data = sim3)

grid <- sim3 %>% 
  data_grid(x1, x2) %>% 
  gather_predictions(mod1, mod2)
grid

ggplot(sim3, aes(x1, y, color = x2)) + 
  geom_point() + 
  geom_line(data = grid, aes(y = pred)) + 
  facet_wrap(~ model)

sim3 <- sim3 %>% 
  gather_residuals(mod1, mod2)
ggplot(sim3, aes(x1, resid, color = x2)) + 
  geom_point() + 
  facet_grid(model ~ x2)


# two continuous vars -----------------------------------------------------

mod1 <- lm(y ~ x1 + x2, data = sim4) 
mod2 <- lm(y ~ x1 * x2, data = sim4)

grid <- sim4 %>% 
  data_grid( 
    x1 = seq_range(x1, 5),
    x2 = seq_range(x2, 5) ) %>% 
  gather_predictions(mod1, mod2) 
grid

ggplot(grid, aes(x1, x2)) + 
  geom_tile(aes(fill = pred)) + 
  facet_wrap(~ model)

ggplot(grid, aes(x1, pred, color = x2, group = x2)) + geom_line() + facet_wrap(~ model)
ggplot(grid, aes(x2, pred, color = x1, group = x1)) + geom_line() + facet_wrap(~ model)
