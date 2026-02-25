#!/bin/bash
#SBATCH -A pi_st2222
#SBATCH --job-name="afscreen_gpuarray"
#SBATCH -p gpu_h200
#SBATCH --gpus=1
#SBATCH --array=1-2%10
#SBATCH --cpus-per-task=12
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH -o "slurm_out/af-gpu-%A.%a.out"
#SBATCH -e "slurm_out/af-gpu-%A.%a.err"

module purge
module load AlphaFold/3.0.1

LINE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" inputs/uniprot_screen_prep.csv)
accession=$(echo $LINE | cut -d',' -f1)

home="AlphaScreen_Predictions"
mkdir $home/$accession/af_output/inference_output
alphafold --norun_data_pipeline --model_dir=weights --json_path=$home/$accession/af_output/msa_output/$accession/${accession}_data.json --output_dir=$home/$accession/af_output/inference_output
