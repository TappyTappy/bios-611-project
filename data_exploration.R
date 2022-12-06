library(tidyverse)
library(stringi)
library(viridis)


astros <- read_csv("source_data/astros_bangs_20200127.csv")
schedule <- read_csv("source_data/Astros_Schedule.csv")
standings <- read_csv("source_data/MLB_Standings.csv")

astros <- select(astros, -top_bottom, -youtube_id, -pitch_youtube_seconds, -youtube_url)

for(i in 1:162) {
  if (is.na(schedule$At[i])) {
    schedule$At[i]="H"
  } else {
    schedule$At[i]="A"
  }
}
schedule <- select(schedule, -Boxscore, -Tm)
schedule <- rename(schedule, Loc=At)

schedule$Date <- str_replace_all(schedule$Date, "Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday", "")
astros$game_date <- str_replace_all(astros$game_date, "/2017", "")
astros$game_date <- str_split(astros$game_date, "/")
astros <- mutate(astros, game_date=lapply(game_date, rev))
apse <- function(c) {
  c <- str_c(c, collapse="/")
  c
}
astros <- mutate(astros, game_date=lapply(game_date, apse))
astros <- mutate(astros, game_date=as.character(game_date))

numerize <- function(c) {
  c <- str_replace_all(c, "Apr", "4/")
  c <- str_replace_all(c, "May", "5/")
  c <- str_replace_all(c, "Jun", "6/")
  c <- str_replace_all(c, "Jul", "7/")
  c <- str_replace_all(c, "Aug", "8/")
  c <- str_replace_all(c, "Sep", "9/")
  c <- str_replace_all(c, "Oct", "10/")
}

schedule <- mutate(schedule, Date = numerize(Date))
schedule$Date <- str_replace_all(schedule$Date, "/ ", "/")
schedule$Date <- str_replace_all(schedule$Date, "[()]1[)]", "")
schedule$Date <- str_trim(schedule$Date)

a <- vector(mode="character")
for(i in 1:81) {
  if(is.element(unique(schedule$Date)[i], unique(astros$game_date))){
  } else {
    a[i] <- unique(schedule$Date)[i]
  }
}

astros <- select(astros, -game_pk, -pitch_datetime, -away_team_id, -home_team_id)
astros <- mutate(astros, bangs=ifelse(is.na(bangs), "0B", bangs))

astros <- mutate(astros, opponent=ifelse(opponent=="ANA", "LAA", opponent))
astros <- mutate(astros, ind=ifelse(has_bangs=="y", 1, 0))
standings <- mutate(standings, Tm=ifelse(Tm=="CHW", "CWS", Tm))
standings <- mutate(standings, Tm=ifelse(Tm=="KCR", "KC", Tm))
standings <- mutate(standings, Tm=ifelse(Tm=="TBR", "TB", Tm))
standings <- mutate(standings, Tm=ifelse(Tm=="WSN", "WAS", Tm))
schedule <- mutate(schedule, Opp=ifelse(Opp=="CHW", "CWS", Opp))
schedule <- mutate(schedule, Opp=ifelse(Opp=="KCR", "KC", Opp))
schedule <- mutate(schedule, Opp=ifelse(Opp=="TBR", "TB", Opp))
schedule <- mutate(schedule, Opp=ifelse(Opp=="WSN", "WAS", Opp))

schedule_all <- schedule
schedule_all %>% write_csv("derived_data/schedule_all.csv")

schedule <- filter(schedule, Loc=="H")
schedule %>% write_csv("derived_data/schedule.csv")

standings <- rename(standings, w_pct=`W-L%`)
standings %>% write_csv("derived_data/standings.csv")

bangs <- filter(astros, has_bangs=="y")
none <- filter(astros, has_bangs=="n")

astros %>% write_csv("derived_data/astros.csv")
bangs %>% write_csv("derived_data/bangs.csv")
none %>% write_csv("derived_data/none.csv")











