#!/bin/bash
#SBATCH -A ##ACCOUNT NAME HERE##
#SBATCH --job-name="afscreen_cpuarray"
#SBATCH -p day
#SBATCH --cpus-per-task=8
#SBATCH --mem=24G
#SBATCH --time=0-08:00:00
#SBATCH -o "slurm_out/af-cpu-%A.%a.out"
#SBATCH -e "slurm_out/af-cpu-%A.%a.err"

module purge
module load AlphaFold/3.0.1

LINE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" inputs/uniprot_screen_prep.csv)
accession=$(echo $LINE | cut -d',' -f1)

home="AlphaScreen_Predictions"
mkdir $home/$accession/af_output/msa_output
alphafold --norun_inference --model_dir=weights --json_path=$home/$accession/af_input/alphafold_input.json --output_dir=$home/$accession/af_output/msa_output
