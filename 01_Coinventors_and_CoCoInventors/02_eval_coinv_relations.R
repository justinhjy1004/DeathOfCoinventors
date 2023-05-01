library(tidyverse)
library(lubridate)

args <- commandArgs(trailingOnly = TRUE)

cocoinv <- read_csv("../Data/cocoinventors.csv")
coinv <- read_csv("../Data/coinventors.csv")

coinv_list <- read_csv(args[1])

coinv_list <- coinv_list$inventor_id

# For a given inventor
inventor <- coinv_list[1]
# Get the list of patents
patent_inventor <- coinv |>
  filter( inventor_id == inventor ,)
patent_inventor <- unique(patent_inventor$patent_id)

# Coinventor information
co_inventor <- cocoinv |>
  filter(
    inventor_id != inventor, # Exclude the inventor
    patent_id %in% patent_inventor # Get the coinventors of the paten
  ) |>
  rename( coinventor_id = inventor_id ) |>
  mutate(
    inventor_id = inventor # Create inventor, coinventor relation
  )

num_coinventor <- co_inventor |>
  group_by(inventor_id, patent_id) |>
  summarize( count = n() )

for ( i in 2:length(coinv_list) ) {
  # For a given inventor
  inventor <- coinv_list[i]
  # Get the list of patents
  patent_inventor <- coinv |>
    filter( inventor_id == inventor ,)
  patent_inventor <- unique(patent_inventor$patent_id)
  
  # Coinventor information
  co_inventor_temp <- cocoinv |>
    filter(
      inventor_id != inventor, # Exclude the inventor
      patent_id %in% patent_inventor # Get the coinventors of the paten
    ) |>
    rename( coinventor_id = inventor_id ) |>
    mutate(
      inventor_id = inventor # Create inventor, coinventor relation
    )
  
  co_inventor <- rbind(co_inventor, co_inventor_temp)
  
  num_coinventor_temp <- co_inventor_temp |>
    group_by(inventor_id, patent_id) |>
    summarize( count = n() )
  
  num_coinventor <- rbind(num_coinventor, num_coinventor_temp)
}

coinventor_file <- gsub("split_coinventors", "coinventor_info", args[1])
num_file <- gsub("split_coinventors", "num_coinventors", args[1])

write.csv(co_inventor, coinventor_file, row.names = F)
write.csv(num_coinventor, num_file, row.names = F)