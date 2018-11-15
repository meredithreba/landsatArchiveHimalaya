#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=matrix
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=2048mb
#SBATCH -o Outfiles/matrix.out

# running code
module load Langs/Python/2.7.10

python matrix_txt_HPC.py