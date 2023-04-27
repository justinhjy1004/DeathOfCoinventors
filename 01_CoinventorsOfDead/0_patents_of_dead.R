library(tidyverse)

dead <- read_csv("../Data/processed_dead_inventors.csv")

inventors <- read_tsv("../Data/inventors.tsv") 

# Get inventors

inventors |>
  select(patent_id, inventor_id, disambig_inventor_name_first, disambig_inventor_name_last) |>
  mutate(
    first_name = toupper(disambig_inventor_name_first),
    last_name = toupper(disambig_inventor_name_last)
  ) |>
  select( -disambig_inventor_name_first, -disambig_inventor_name_last ) |>
  filter( first_name %in% dead$first_name, last_name %in% dead$last_name) -> inventors

dead |>
  select(-inventor_id) |>
  right_join(inventors, by = c("first_name", "last_name")) -> inventors

write.csv(inventors, "../Data/patents_of_dead.csv", row.names = F)
