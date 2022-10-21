
library(tidyverse)

df <- read_csv("source_data/Stephen_Curry_Stats.csv")

sc_stats <- df %>% select(Season_year, Season_div, MIN, `FG%`, `3P%`, PTS) %>% filter(complete.cases(.))

sc_stats$Season_year <- as.factor(sc_stats$Season_year)
sc_stats$Season_div <- as.factor(sc_stats$Season_div)

sc_stats %>% write_csv("derived_data/sc_stats.csv")
