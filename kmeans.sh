#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=visual
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=2048mb
#SBATCH -o Outfiles/kmeans.out

# running code
module load Apps/Matlab/R2014a

matlab -nodisplay < kmeans_urban_only_HPC.m