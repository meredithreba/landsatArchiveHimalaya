#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=ismember
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH -o Outfiles_2/ismember.out

# running code
module load Apps/Matlab/R2014a

matlab -nodisplay < random_ismember_142040.m