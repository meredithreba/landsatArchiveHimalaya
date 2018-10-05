#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=yatsm_clsf_Charikot
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=3000
#SBATCH --array=1-100
#SBATCH -o Outfiles/yatsm_clsf_Charikot_%A_%a.out

module load Langs/Python/2.7-anaconda 

# running code

source activate yatsm

yatsm -v classify T3_image_LC8_141041clippedTC_SE_5bands.yaml model_Charikot.pkl "${SLURM_ARRAY_TASK_ID}" 100
