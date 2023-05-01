library(tidyverse)

# Get coinventors
coinv <- read_csv("../Data/coinventors.csv")

# Get a list of coinventors
coinv_list <- coinv |>
  select(inventor_id) |>
  distinct() 

# Index each coinventor for splitting
coinv_list$index <- 1:nrow(coinv_list)

# Mod index to split file into 10,000 parts
coinv_list |>
  mutate(
    index = index %% 2000
  ) -> coinv_list

# Write for lapply
# Takes a dataframe and given directory name
# Write relevant dataframe
apply_write <- function(dataframe, directory_name = '../Data/split_coinventors/') {
  
  file_name <- paste0( directory_name, "coinventor_", 
                       dataframe$index[1], ".csv")
  
  write.csv( dataframe, file_name, row.names = FALSE)
  
}

# Split on index
df_dat <- split(coinv_list, coinv_list$index)
# Apply the write csv function
lapply(df_dat, apply_write)
