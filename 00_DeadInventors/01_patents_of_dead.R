library(tidyverse)

dead <- read_csv("../Data/processed_dead_inventors.csv")

inventors <- read_tsv("../Data/inventors.tsv") 

#==========================================================
# Get Patent Information and
#==========================================================

inventors |>
  select(patent_id, inventor_id, disambig_inventor_name_first, disambig_inventor_name_last) |>
  mutate(
    first_name = toupper(disambig_inventor_name_first),
    last_name = toupper(disambig_inventor_name_last),
    full_name = paste(first_name, last_name, sep = " ")
  ) |>
  select( -disambig_inventor_name_first, 
          -disambig_inventor_name_last ) |>
  filter( full_name %in% dead$full_name ) -> inventors

#==========================================================
# Remove repeated names
#==========================================================

inventors |>
  select( full_name, inventor_id ) |>
  distinct() |>
  group_by( inventor_id ) |>
  summarize( count = n() ) -> repeats

rm(repeats)
## NO REPEATS FOUND!

dead |>
  select(-inventor_id) |>
  right_join(inventors, by = c("full_name")) -> inventors

write.csv(inventors, "../Data/patents_of_dead.csv", row.names = F)
