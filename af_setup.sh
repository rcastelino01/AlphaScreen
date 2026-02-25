#!/bin/bash

#Loading in necessary modules
ml R/4.4.1-foss-2022b

#Converting fasta to csv
Rscript ./utilities/FastaToCSV.R >/dev/null 2>&1
tr -d '"' < inputs/uniprot_screen.csv > inputs/uniprot_screen_prep.csv 
sed -i '1d' inputs/uniprot_screen_prep.csv
sed -i '1i TEST,RRRR,4' inputs/uniprot_screen_prep.csv
rm inputs/uniprot_screen.csv

#Defining baits
read -p "Enter number of baits: " num_baits

count=1
bait_length=0
total_baitlength=()
while [ $count -le $num_baits ];
do
	read -p "Enter the sequence of each bait, pressing enter between each: " bait_temp
	baits+=(${bait_temp^^})
	bait_length=${#bait_temp}
	total_baitlength=$((total_length + bait_length))
	((count++))
done


#Creating home folder
home=AlphaScreen_Predictions
rm -r $home
mkdir AlphaScreen_Predictions

chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ"  

IFS=","

while read -r accession sequence sequencelength; do
pred_length=$((total_baitlength + $sequencelength))
max_length=3000
if [ $pred_length -ge $max_length ]; then
	continue
fi

mkdir $home/$accession
mkdir $home/$accession/af_input
mkdir $home/$accession/af_output

#Creating input_files
cat <<EOF >> $home/$accession/af_input/alphafold_input.json
{
  "name": "$accession",
  "sequences": [
EOF


count=0
while [ $count -lt $num_baits ];
do
cat <<EOF >> $home/$accession/af_input/alphafold_input.json
    {
      "protein": {
        "id": ["${chars:$count:1}"],
        "sequence": "${baits[$count]^^}"
      }
    }
    ,
EOF
((count++))
done

cat << EOF >> $home/$accession/af_input/alphafold_input.json
    {
      "protein": {
    	"id": ["${chars:$count:1}"],
	"sequence": "$sequence"
    }
    }
  ],
  "modelSeeds": [1],
  "dialect": "alphafold3",
  "version": 1
} 
EOF

done < inputs/uniprot_screen_prep.csv

rm -r slurm_out
mkdir slurm_out 
