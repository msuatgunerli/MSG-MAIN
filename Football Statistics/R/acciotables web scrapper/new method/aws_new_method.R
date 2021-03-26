require(rvest)
require(dplyr)
page <- read_html("http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22/Major-League-Soccer-Stats&content_selector_id=%23stats_keeper_squads")
table <- page %>% html_table()
table <- table[[1]] 
print(table)

# instructions ------------------------------------------------------------

#find the css selector id for each table and add after the content_selector_id= section, remember to swap # with the ASCII value %23 in the provided link
#the result is a table in the html format