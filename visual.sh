#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=visual
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=2048mb
#SBATCH -o Outfiles/visual.out

# running code
module load Apps/Matlab/R2014a

matlab -nodisplay < trajectory_full_HPC_medium.m
matlab -nodisplay < urban_only_HPC.m
#matlab -nodisplay < traj_visualization_HPC_mode.m


#the sequence of visualization is:
#1.matrix.sh (matrix.py)
#2.visual.sh (trajectory_full_HPC_medium.m + urban_only_HPC.m)
#3.kmodes.sh (kmodes.R)
#4.visual.sh (traj_visualization_HPC_mode.m)