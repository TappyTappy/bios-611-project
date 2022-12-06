library(tidyverse)
library(stringi)
library(viridis)
library(glmnet)
library(rsample)

astros <- read_csv("derived_data/astros.csv")
schedule <- read_csv("derived_data/schedule.csv")
schedule_all <- read_csv("derived_data/schedule_all.csv")
standings <- read_csv("derived_data/standings.csv")
bangs <- read_csv("derived_data/bangs.csv")
none <- read_csv("derived_data/none.csv")

NBbP1 <- group_by(astros, bangs) %>%
  ggplot(aes(x=bangs, fill=pitch_category)) + geom_bar() + labs(x="Number of Bangs before Pitch", y="Count") + ggtitle("Distribution of the Number of Bangs Before a Pitch")
saveRDS(NBbP, file="figures/NBbP1.rds")


NBbP2 <-group_by(bangs, bangs) %>%
  ggplot(aes(x=bangs, fill=pitch_category)) + geom_bar() + labs(x="Number of Bangs before Pitch", y="Count") + ggtitle("Distribution of the Number of Bangs Before a Pitch")
saveRDS(NBbP, file="figures/NBbP2.rds")


NBbP3 <- group_by(astros, bangs) %>%
  ggplot(aes(x=bangs, fill=pitch_category)) + geom_bar(position="fill") + labs(x="Number of Bangs before Pitch", y="Proportion Per Pitch Category") + ggtitle("Pitch Catergories for Each Number of Bangs")
saveRDS(NBbP, file="figures/NBbP3.rds")

#######################################################

bd <-group_by(bangs, game_date) %>%
  summarize(s=sum(ind))
bd<- mutate(bd, date=as.Date.character(game_date, "%m/%d"))
bd<- mutate(arrange(bd, date), game_number=seq(1:55))
bd<-select(bd, game_number, s, game_date)

NPwB <- ggplot(bd, aes(x=game_number, y=s)) + geom_line() + labs(x="Game Number", y="Number of Pitches with Bangs") + ggtitle("Distribution of the Number of Bangs Before a Pitch")
saveRDS(NPwB, file="figures/NPwB.rds")

######################################################

bases <- function(d, n) {
  v <- vector(mode="character", length=n)
  for(i in 1:n) {
    if (d$on_1b[i]==F && d$on_2b[i]==F && d$on_3b[i]==F) {
      v[i] <-"0"
    } else{
      v[i] <- ""
      if(d$on_1b[i]==T) {
        v[i] <- paste(v[i], "1", sep="")
      }
      if(d$on_2b[i]==T) {
        v[i] <- paste(v[i], "2", sep="")
      }
      if(d$on_3b[i]==T) {
        v[i] <- paste(v[i], "3", sep="")
      }
    }
  }
  d <- mutate(d, runners=v)
  return(d)
}
r1 <- bases(bangs, 1142) %>%
  group_by(runners) %>%
  summarize(n=n()) %>%
  mutate(per=(n/sum(n))*100)
r2 <- bases(none, 7132) %>%
  group_by(runners) %>%
  summarize(n=n()) %>%
  mutate(per=(n/sum(n))*100)
r <- full_join(r1, r2, by="runners") %>%
  rename(bangs_per=per.x, no_bangs_per=per.y)


POB <- pivot_longer(r, ends_with("_per"), names_to="b", values_to="per") %>%
  ggplot(aes(x=runners, y=per, fill=b)) + geom_col(position="dodge") + labs(x="Location of Runners", y="Percentage") + ggtitle("Percentages of On Base Situations (per pitch)")
saveRDS(POB, file = "figures/POB.rds")

##################################################

r1 <- select(bangs, game_id, inning, batter, at_bat_event, atbat_playid, on_1b, on_2b, on_3b) %>%
  distinct() %>%
  bases(638) %>%
  group_by(runners) %>%
  summarize(n=n()) %>%
  mutate(per=(n/sum(n))*100)
#629, 638
r2 <- select(none, game_id, inning, batter, at_bat_event, atbat_playid, on_1b, on_2b, on_3b) %>%
  distinct() %>%
  bases(2150) %>%
  group_by(runners) %>%
  summarize(n=n()) %>%
  mutate(per=(n/sum(n))*100)
#2090, 2150
r <- full_join(r1, r2, by="runners") %>%
  rename(bangs_per=per.x, no_bangs_per=per.y)

POB_bat <- pivot_longer(r, ends_with("_per"), names_to="b", values_to="per") %>%
  ggplot(aes(x=runners, y=per, fill=b)) + geom_col(position="dodge") + labs(x="Location of Runners", y="Percentage") + ggtitle("Percentage of On Base Situations (per at bat)")
saveRDS(POB_bat, file = "figures/POB_bat.rds")


##################################
b1 <- group_by(bangs, batter) %>%
  summarize(pitches_with_bangs=n())
b2 <- group_by(astros, batter) %>%
  summarize(total_pitches=n())
b <- full_join(b1, b2, by="batter") %>%
  mutate(pct=(pitches_with_bangs/total_pitches)*100)
b <- mutate(b, pct=ifelse(is.na(pitches_with_bangs), 0, pct), pitches_with_bangs=ifelse(is.na(pitches_with_bangs), 0, pitches_with_bangs))
player <- filter(b, !is.na(pct)) %>%
  ggplot(aes(x=reorder(batter, pitches_with_bangs), y=pct)) + geom_col() + theme(axis.text.x=element_text(angle=90)) + labs(x="Name of Batter", y="Percentage of Pitches with Bangs") + ggtitle("Percentage of Each Players' Total Pitches that Have Bangs")
saveRDS(player, file = "figures/player.rds")

###############################################
s <- select(standings, Tm, w_pct) %>%
  filter(Tm!="Avg")
t1 <- group_by(bangs, opponent) %>%
  summarize(bangs=n()) %>%
  left_join(s, by=c("opponent"="Tm"))
t2 <- group_by(astros, opponent) %>%
  summarize(total_pitches=n()) %>%
  left_join(s, by=c("opponent"="Tm"))
t3 <- full_join(t1, t2, by="opponent") %>%
  select(-w_pct.y) %>%
  rename(w_pct=w_pct.x) %>%
  mutate(pct_bangs=(bangs/total_pitches)*100)

opponent <- ggplot(t3, aes(x=reorder(opponent, w_pct), y=pct_bangs)) + geom_col() + theme(axis.text.x=element_text(angle=90)) + labs(x="Opponent", y="Percentage of Pitches with Bangs") + ggtitle("Percentage of Pitches with Bangs Against Each Opponent")
saveRDS(opponent, file = "figures/opponent.rds")

#################################################

bp <- group_by(bangs, description) %>%
  summarize(bangs_count=n())
bp <- mutate(bp, bangs_pct=(bangs_count/sum(bangs_count))*100)
nbp <- group_by(none, description) %>%
  summarize(no_bangs_count=n())
nbp <- mutate(nbp, no_bangs_pct=(no_bangs_count/sum(no_bangs_count))*100)
by_pitch <- full_join(bp, nbp, by="description")
individual <- filter(by_pitch, !is.na(bangs_count)) %>%
  pivot_longer(ends_with("_pct"), names_to="b", values_to="per") %>%
  ggplot(aes(x=description, y=per, fill=b)) + geom_col(position="dodge") + theme(axis.text.x=element_text(angle=90)) + labs(x="Outcome of Pitch", y="Percentage") + ggtitle("Percentages of Pitch Outcomes")
saveRDS(individual, file = "figures/individual.rds")

######################################################


