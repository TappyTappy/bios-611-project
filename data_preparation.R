library(tidyverse)

df <- read_csv("https://raw.githubusercontent.com/TappyTappy/bios-611-project/main/source%20data/Stephen%20Curry%20Stats.csv")

sc_stat <- df %>% filter(complete.cases(.)) %>% 
mutate(sc_stat$Season_year = as.factor(sc_stats$Season_year),sc_stat$Season_div = as.factor(sc_stats$Season_div))

sc_stats %>% write_csv("derived_data/sc_stats.csv")
