
#Rithik Castelino (Yale University)

#Loading in Packages
if(!require(tidyverse)) { install.packages("tidyverse"); library(tidyverse)}

raw_ipTMs <- read.csv("Output/statistics.csv", header=FALSE)

avg_ipTMs <- raw_ipTMs %>% 
  rename(pae_min = V1) %>%
  rename(ipTM = V2) %>% 
  rename(accession = V3) %>%
  rename(bait_num = V4) %>% 
  group_by(accession, bait_num) %>% 
  summarise(mean_ipTM = mean(ipTM), mean_pae_min = mean(pae_min)) 

write.csv(avg_ipTMs, "Output/avg_statistics.csv", row.names=FALSE)
