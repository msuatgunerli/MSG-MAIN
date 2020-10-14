library(tidyverse)
#br
who1 <- who %>%
  #bundan once reoder edip oyle de gather yapılabilir
  gather(
    new_sp_m014:newrel_f65, key = "key", 
    value = "cases", 
    na.rm = TRUE
  )
who1 %>%
  count(key)

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% 
  count(new)
who4 <- who3 %>%
  select(-new, -iso2, -iso3)

who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

#bu sekilde tek tek yapmak yerine complex bir pipe olustur

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate( 
    code = stringr::str_replace(code, "newrel", "new_rel")
  ) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)