#!/bin/bash

rm -r Output
mkdir Output

read -p "Enter number of baits: " num_baits

find ./AlphaScreen_Predictions  -name "*summary_confidences.json" | cut -d '/' -f 3 | sort | uniq > Output/complete_accessions.txt

while read names; do
for i in {0..4}; do
for ((bait_i=1; bait_i<=$num_baits; bait_i++)); do
ipTM_pos=$((6+(4*$num_baits)+($num_baits**2)+bait_i))
pae_min_pos=$((11+8*$num_baits+2*($num_baits**2)+bait_i))
ipTM_bait_i=$(head -$ipTM_pos ./AlphaScreen_Predictions/$names/af_output/inference_output/$names/seed-1_sample-$i/${names}_seed-1_sample-${i}_summary_confidences.json | tail -1 | grep -E -o '[0-9]+\.[0-9]{1,2}')
pae_min_bait_i=$(head -$pae_min_pos ./AlphaScreen_Predictions/$names/af_output/inference_output/$names/seed-1_sample-$i/${names}_seed-1_sample-${i}_summary_confidences.json | tail -1 | grep -E -o '[0-9]+\.[0-9]{1,2}')

echo "$pae_min_bait_i" >> Output/pae_mins.txt
echo "$ipTM_bait_i" >> Output/ipTMs.txt 
echo "$names" >> Output/accessions.txt
echo "$bait_i" >> Output/baitindices.txt
done
done
done < "Output/complete_accessions.txt"

paste -d ',' Output/pae_mins.txt Output/ipTMs.txt Output/accessions.txt Output/baitindices.txt > Output/statistics.csv
#rm Output/pae_mins.txt
#rm Output/ipTMs.txt
#rm Output/accessions.txt
#rm Output/baitindices.txt

#Loading in necessary modules
ml R/4.4.1-foss-2022b

#Calculating average of iPTM values
Rscript utilities/Statistics.R
