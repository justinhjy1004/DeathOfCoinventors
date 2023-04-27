library(tidyverse)
library(lubridate)

#==============================================================
# Drop observatiosn where ambiguity of death year and birthdate
#==============================================================
df <- read_csv("../Data/dead_inventors.csv") |>
  drop_na(a_obi_birth_date, a_obi_death_date, 
          min_death_year, max_death_year) |>
  filter(min_death_year == max_death_year)

#==============================================================
# Select relevant columns
#==============================================================
df |>
  select(inventor_id, first_name, middle_name, last_name,
         app_date_min, app_date_max, patent_date_min, patent_date_max,
         a_obi_birth_date, a_obi_death_date) |>
  distinct() -> df

#==============================================================
# Calculate approx age and length of inactivity
# Only consider inactivity for within 5 years
#==============================================================
df |>
  mutate(
    a_obi_birth_date = as.Date.character(a_obi_birth_date, format = "%m-%d-%Y"),
    a_obi_death_date = as.Date.character(a_obi_death_date, format = "%m-%d-%Y"),
    birth_year = year(a_obi_birth_date),
    death_year = year(a_obi_death_date),
    death_age  = death_year - birth_year,
    last_activity = year(app_date_max),
    inactivity = death_year - last_activity
  ) |> 
  filter(inactivity <= 5) -> df

# write data
write.csv(df, "../Data/processed_dead_inventors.csv", row.names = F)


