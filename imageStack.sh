#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=meredith.reba@yale.edu
#SBATCH --job-name=imageStackTest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH -o yatsm_%A_%a.out

# running code
#module load Langs/Python/2.7.10 

# using my anaconda environment
source activate yatsm
python /home/fas/seto/mra37/scripts/yatsm_unzipStackImages_right.py