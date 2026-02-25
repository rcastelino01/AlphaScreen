#!/bin/bashi

ARRAY_A_ID=$(sbatch --parsable utilities/af_cpu.sh)
echo "Submitted CPU jobs with ID: $ARRAY_A_ID"

sbatch --dependency=aftercorr:$ARRAY_A_ID utilities/af_gpu.sh
echo "Submitted GPU jobs with dependency on CPU jobs (ID: $ARRAY_A_ID)"
