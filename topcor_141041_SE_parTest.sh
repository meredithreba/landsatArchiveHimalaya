#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=141041SEParTest
#SBATCH --ntasks-per-node=12
#SBATCH --nodes=3
#SBATCH --cpus-per-task=1
#SBATCH --partition=week
#SBATCH --time=72:00:00
#SBATCH -o Outfiles/141041SEParTest_%A_%a.out

module load Apps/R
module load Rpkgs/RASTER
module load Rpkgs/RGDAL
module load Rpkgs/DOSNOW
module load Rpkgs/FOREACH
module load Rpkgs/RGEOS
module load Rpkgs/XML
module load Rpkgs/RMPI/0.6.3
module load MPI/OpenMPI

# running code

export OMPI_MCA_mtl=^psm
mpirun --oversubscribe -n 1 R --slave -f topcor_141041_SE_parTest.R
