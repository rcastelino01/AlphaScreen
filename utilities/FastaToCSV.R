
#Rithik Castelino (Yale University, 2026)

#Loading in Packages
if(!require(tidyverse)) { install.packages("tidyverse"); library(tidyverse)}
if(!require(seqinr)) { install.packages("seqinr"); library(seqinr)}

#Loading in FASTA Data & cleaning
fasta_raw <- read.fasta("inputs/uniprot_screen.fasta", as.string="TRUE")
fasta_dataframe_temp <- as.data.frame(fasta_raw)
fasta_dataframe <- data.frame(Names = names(fasta_dataframe_temp), Sequences = t(fasta_dataframe_temp))
fasta_csv <- fasta_dataframe %>%
  separate_wider_delim(cols = "Names", delim = ".", names_sep = "") %>%
  select(Names2, Sequences) %>%
  rename(Accession = "Names2") %>% 
  mutate(Sequences = toupper(Sequences)) %>%
  mutate(SequenceLength = nchar(Sequences)) %>% 
  arrange(SequenceLength)

write.csv(fasta_csv, "inputs/uniprot_screen.csv", row.names=FALSE)
