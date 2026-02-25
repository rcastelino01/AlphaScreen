#!/bin/bash

mkdir Output
touch Output/complete_accession.csv
find ./AlphaScreen_Predictions  -name "*summary_confidences.json" | cut -d '/' -f 3 | sort | uniq > Output/complete_accession.csv

#Loading in necessary modules
ml R/4.4.1-foss-2022b

#Converting fasta to csv
Rscript utilities/ReviveAccession.R


