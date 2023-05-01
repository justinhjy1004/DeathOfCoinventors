library(tidyverse)

df <- read_csv("../Data/coinventor_info.csv")

df |>
  filter( patent_id != "patent_id" ) -> df

write.csv(df, "../Data/coinventor_info.csv", row.names = F)
