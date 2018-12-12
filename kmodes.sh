#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=xinyi.li@yale.edu
#SBATCH --job-name=matrix
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day,pi_seto
#SBATCH --time=24:00:00
##SBATCH --mem-per-cpu=2048mb
#SBATCH -o Outfiles/KMODES.out

# running code
module load Apps/R/3.3.2-generic
module load MPI/OpenMPI

export OMPI_MCA_mtl=^psm
mpirun --oversubscribe -n 1 R --slave -f kmodes.R