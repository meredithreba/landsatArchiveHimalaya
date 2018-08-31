#!/bin/bash

#SBATCH --array=1-300
#SBATCH --mail-type=ALL
#SBATCH --mail-user=meredith.reba@yale.edu
#SBATCH --job-name=YatsmLine
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=week
#SBATCH --time=120:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH -o yatsmline_%A_%a.out

# running code
# using my anaconda environment
source activate yatsm

yatsm -v line /home/fas/seto/mra37/scripts/T3_image.yaml "${SLURM_ARRAY_TASK_ID}" 300



