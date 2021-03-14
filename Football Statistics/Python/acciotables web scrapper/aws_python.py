#site = "https://fbref.com/en/comps/26/Super-Lig-Stats"
#table = "#stats_keeper_squads"
#table_rep = table.string.replace("#", "%")
#address = "http://acciotables.herokuapp.com/?page_url=" + site + "content_selector_id=" + table_rep

import pandas as pd
url = "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22/Major-League-Soccer-Stats&content_selector_id=%23stats_keeper_squads"

df = pd.read_html(url, header=0)
print(df)
