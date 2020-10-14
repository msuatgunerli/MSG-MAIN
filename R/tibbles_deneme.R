tb <- tibble(
  `:)` = "smile",
  ` ` = "space",
  `2000` = "number"
)
tb
view(tb)

A <- tribble( ~x, ~y, ~z, 
         #--|--|---
         "a", 2, 3.6,
         "b", 1, 8.5
)
view(A)
A

B <-  tibble( 
  a = lubridate::now() + runif(1e3) * 86400, 
  b = lubridate::today() + runif(1e3) * 30, 
  c = 1:1e3, 
  d = runif(1e3), 
  e = sample(letters, 1e3, replace = TRUE)
)