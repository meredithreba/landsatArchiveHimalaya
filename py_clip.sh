#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=clip
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,scavenge
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=2048mb
#SBATCH -o Outfiles/clip.out

# running code
module load Langs/Python/2.7-anaconda 

# using my anaconda enviornment
source activate yatsm
python py_clip.py
