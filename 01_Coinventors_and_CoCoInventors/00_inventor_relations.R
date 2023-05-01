library(tidyverse)

dead_patents <- read_csv("../Data/patents_of_dead.csv")

inventors <- read_tsv("../Data/inventors.tsv")

#==========================================================
# Coinventors of Dead
#==========================================================
inventors |>
  filter(
    patent_id %in% dead_patents$patent_id,
    !(inventor_id %in% dead_patents$inventor_id) 
  ) -> coinventors

#==========================================================
# Co-Coinventors of Dead
#==========================================================
inventors |>
  filter(
    patent_id %in% coinventors$patent_id
  ) -> cocoinventors

# write csv
write.csv(coinventors, "../Data/coinventors.csv", row.names = F)
write.csv(cocoinventors, "../Data/cocoinventors.csv", row.names = F)
