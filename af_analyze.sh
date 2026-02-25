#!/bin/bash

rm -r Output
mkdir Output

find ./AlphaScreen_Predictions  -name "*summary_confidences.json" | cut -d '/' -f 3 | sort | uniq > Output/complete_accessions.txt

while read names; do
for i in {0..4}; do
ipTM_i=$(tail -4 ./AlphaScreen_Predictions/$names/af_output/inference_output/$names/seed-1_sample-$i/${names}_seed-1_sample-${i}_summary_confidences.json | head -1 | grep -E -o '[0-9]+\.[0-9]{1,2}')

echo "$ipTM_i" >> Output/ipTMs.txt 
echo "$names" >> Output/accessions.txt
done

done < "Output/complete_accessions.txt"

paste -d', ' Output/ipTMs.txt Output/accessions.txt > Output/accession_ipTMs.csv
rm Output/ipTMs.txt
rm Output/accessions.txt

#Loading in necessary modules
ml R/4.4.1-foss-2022b

#Calculating average of iPTM values
Rscript utilties/Mean_ipTM.R
