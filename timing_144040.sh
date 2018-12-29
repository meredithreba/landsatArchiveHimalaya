#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=from_to_144040
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=9G
#SBATCH -o Outfiles_1/from_to_144040.out

# running code
module load Apps/Matlab/R2014a

matlab -nodisplay < ismember_timing_144040.m
matlab -nodisplay < hist_timing_5class_144040.m