#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=Charikot_train
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,scavenge
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=3000
#SBATCH -o Outfiles/Charikot_train_%A_%a.out

module load Langs/Python/2.7-anaconda 

# running code

source activate yatsm

yatsm train T3_image_LC8_141041clippedTC_SE_5bands.yaml RandomForest.yaml  model_Charikot
