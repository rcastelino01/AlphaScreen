#Rithik Castelino (Yale University)

#Loading in Packages
if(!require(tidyverse)) { install.packages("tidyverse"); library(tidyverse)}

accessions <- read.csv("Output/complete_accession.csv", header=FALSE)
initial_input <- read.csv("inputs/uniprot_screen_prep.csv", header=FALSE)

new_input <- initial_input %>% 
  filter(., !(V1 %in% accessions$V1))

write.table(new_input, "inputs/revive_screen_prep.csv", sep=',', row.names=FALSE, col.names=FALSE)

