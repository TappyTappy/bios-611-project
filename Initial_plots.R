library(tidyverse)

df <- read_csv("source_data/Stephen_Curry_Stats.csv")

sc_stats <- df %>% select(Season_year, Season_div, MIN, `FG%`, `3P%`, PTS)

#sc_stats <- sc_stat %>% mutate(Season_year = as.factor(sc_stats$Season_year), Season_div = as.factor(sc_stats$Season_div))



pres <- sc_stats %>% dplyr::filter(Season_div=="Pre") %>% group_by(Season_year)


pre_avg_min <- pres %>% group_by(Season_year) %>% summarise(Mean_minutes=mean(MIN))

pre_avg_min_plot <- pre_avg_min %>% ggplot(aes(Season_year,Mean_minutes, fill=Season_year)) +
  geom_col(show.legend = T) + theme_light()

#ggsave("figures/pre_avg_min_plot.png", plot=pre_avg_min_plot)
saveRDS(pre_avg_min_plot, file="figures/pre_avg_min_plot.rds");


pre_avg_FGP <- pres %>% group_by(Season_year) %>% select(Season_year, `FG%`)

pre_avg_FGP_plot <- pre_avg_FGP %>% ggplot(aes(Season_year,`FG%`, fill=Season_year)) +
  geom_boxplot() + theme_light()

#ggsave("figures/pre_avg_FGP_plot.png", plot=pre_avg_FGP_plot)

saveRDS(pre_avg_FGP_plot, file="figures/pre_avg_FGP_plot.rds")


