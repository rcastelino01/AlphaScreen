#!/bin/bash

jobtotal=$(ls AlphaScreen_Predictions/ | wc -l) 
echo $jobtotal

ARRAY_A_ID=$(sbatch --parsable --array=1-${jobtotal}%40 utilities/af_cpu.sh)
echo "Submitted CPU jobs with ID: $ARRAY_A_ID"

sbatch --dependency=afterany:$ARRAY_A_ID --array=1-${jobtotal}%20 utilities/af_gpu.sh
echo "Submitted GPU jobs with dependency on CPU jobs (ID: $ARRAY_A_ID)"
