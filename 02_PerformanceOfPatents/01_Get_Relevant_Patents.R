library(tidyverse)

# Get list of relevant patents
df <- read_csv("../Data/coinventors.csv")
rel_patents <- unique(df$patent_id)
rm(df)

files <- list.files("../Data/split_patents/")

colnames <- c("patent_id","patent_type","patent_date",    
              "patent_title","patent_abstract","wipo_kind",      
              "num_claims","withdrawn","filename")

# Read and filter patents
patents <- read_tsv(paste0("../Data/split_patents/",files[1]), col_names = FALSE)

patents |>
  filter(patents$X1 %in% rel_patents) -> patents

# Fruit Loop
for (i in 2: length(files)) {
  temp <- read_tsv(paste0("../Data/split_patents/",files[i]), col_names = FALSE)
  temp |>
    filter(temp$X1 %in% rel_patents) -> temp
  patents <- rbind(patents, temp)
  rm(temp)
}

# Write CSV
colnames(patents) <- colnames
write.csv(patents, paste0("../Data/relevant_patents.csv"), row.names = FALSE)
rm(patents)

#===================================================
# Do the same for citation!
#===================================================
files <- list.files("../Data/split_citation/")

### patent_id cites citation_patent_id 
### By counting how many times citation_patent_id, we can
### get how many patents cited the relevant patents
citation <- read_tsv(paste0("../Data/split_citation/",files[1]), col_names = F)
col_names <- c("patent_id","citation_sequence", "citation_patent_id",
               "citation_date","record_name","wipo_kind",        
               "citation_category")

citation |>
  filter(citation$X3 %in% rel_patents) -> citation

for (i in 2: length(files)) {
  temp <- read_tsv(paste0("../Data/split_citation/",files[i]), col_names = FALSE)
  temp |>
    filter(temp$X3 %in% rel_patents) -> temp
  citation <- rbind(citation, temp)
  rm(temp)
}

colnames(citation) <- col_names
write.csv(citation, "../Data/relevant_citation.csv", row.names = FALSE)
rm(citation)

