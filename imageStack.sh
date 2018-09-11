#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=CongoStack
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=week
#SBATCH --time=48:00:00
#SBATCH -o Outfiles/CongoStack_%A_%a.out

# running code
module load Langs/Python/2.7-anaconda 

# using my anaconda enviornment
source activate yatsm
python yatsm_unzipStackImages_5bands_qa_stack_174067Congo.py
