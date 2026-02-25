
#Rithik Castelino (Yale University)

#Loading in Packages
if(!require(tidyverse)) { install.packages("tidyverse"); library(tidyverse)}

raw_ipTMs <- read.csv("Output/accession_ipTMs.csv", header=FALSE)

avg_ipTMs <- raw_ipTMs %>% 
  rename(score = V1) %>% 
  rename(accession = V2) %>% 
  group_by(accession) %>% 
  summarise(mean_ipTM = mean(score))

write.csv(avg_ipTMs, "Output/avg_ipTMs.csv", row.names=FALSE)
