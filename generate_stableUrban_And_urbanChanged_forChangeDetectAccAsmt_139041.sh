#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=139041gentest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day, pi_seto
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=100
#SBATCH -o Outfiles/139041gen_SU_UC_traj_%A_%a.out

module load Apps/R/3.3.2-generic
module load Rpkgs/RASTER
module load Rpkgs/RGDAL
module load Rpkgs/RGEOS
module load Rpkgs/XML

R --vanilla --no-readline -q  << 'EOF'

##############################################################
#Disorderly file of urban trajectory within shp extent, created by running in bash: 'shuf -n line_num urbtraj_WithinShpNoOverlay.txt > output'
file <- "/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbtraj_WithinShpNoOverlay_139041_disorderly.txt"

con <- file(file,"r")
stable_urb_ct <- 0
urb_change_ct <- 0
#com <- paste("wc -l ", file, " | awk '{ pri>  $1 }'", sep="")
#n <- system(command=com, intern=TRUE)
############################################################## Number of pixels (lines) in the urban traj (urbtraj_WithinShpNoOverlay_139041_disorderly.txt) file, change accordingly
line_num <- 4912
############################################################## Number of needed stable_urb random pixels (or urb_change random pixels), change according to Dropbox\NASA_HimalayaProject\Baohui\ sampleNumCalculationForCluserNumTest.xlsx, line 18-28, col E
n <- 100
for (i in 1:line_num){
	this_line <- readLines(con,n=1)
	if((strsplit(this_line,' ')[[1]][1])!=""){
		this_line <- paste(" ", this_line, sep='')
		
		x <- strsplit(this_line,' ')[[1]][2]
		y <- strsplit(this_line,' ')[[1]][3]
		
		if(stable_urb_ct < n && grepl( '5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5', this_line, fixed=TRUE)==TRUE){
			##############################################################
			cat(paste(x, y, sep=' '),file="~/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay_smplForClsfAccAsmnt/stable_urbTraj_WithinShpNoOverlay_smplForClsfAccAsmnt_139041.txt",sep="\n",append=TRUE)
			stable_urb_ct <- stable_urb_ct+1
			print(paste("stable_urb_ct=",stable_urb_ct, sep=''))
		} else if (urb_change_ct < n && grepl('5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5', this_line, fixed=TRUE)==FALSE){
			for(j in 4: 335){
				if(strsplit(this_line,' ')[[1]][j]!=strsplit(this_line,' ')[[1]][j+1]){
					year <- floor((j+1-3)/12)+1990
					month <- (j+1-3)%%12
					##############################################################
					cat(paste(x, " ", y, ' from class', strsplit(this_line,' ')[[1]][j], ' to class', strsplit(this_line,' ')[[1]][j+1], " ", year,'-',month, sep=''),file="~/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay_smplForClsfAccAsmnt/urb_changeTraj_WithinShpNoOverlay_smplForClsfAccAsmnt_139041.txt",sep="\n",append=TRUE)
				}
			}
			urb_change_ct <- urb_change_ct+1
			print(paste("urb_change_ct=",urb_change_ct, sep=''))
		} else if (stable_urb_ct >= n && urb_change_ct >= n){break}
		else{next}
	} else{
		x <- strsplit(this_line,' ')[[1]][2]
		y <- strsplit(this_line,' ')[[1]][3]
		
		if(stable_urb_ct < n && grepl( '5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5', this_line, fixed=TRUE)==TRUE){
			##############################################################
			cat(paste(x, y, sep=' '),file="~/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay_smplForClsfAccAsmnt/stable_urbTraj_WithinShpNoOverlay_smplForClsfAccAsmnt_139041.txt",sep="\n",append=TRUE)
			stable_urb_ct <- stable_urb_ct+1
			print(paste("stable_urb_ct=",stable_urb_ct, sep=''))
		} else if (urb_change_ct < n && grepl('5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5', this_line, fixed=TRUE)==FALSE){
			for(j in 4: 335){
				if(strsplit(this_line,' ')[[1]][j]!=strsplit(this_line,' ')[[1]][j+1]){
					year <- floor((j+1-3)/12)+1990
					month <- (j+1-3)%%12
					##############################################################
					cat(paste(x, " ", y, ' from class', strsplit(this_line,' ')[[1]][j], ' to class', strsplit(this_line,' ')[[1]][j+1], " ", year,'-',month, sep=''),file="~/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay_smplForClsfAccAsmnt/urb_changeTraj_WithinShpNoOverlay_smplForClsfAccAsmnt_139041.txt",sep="\n",append=TRUE)
				}
			}
			urb_change_ct <- urb_change_ct+1
			print(paste("urb_change_ct=",urb_change_ct, sep=''))
		} else if (stable_urb_ct >= n && urb_change_ct >= n){break}
		else{next}
	}
}

close(con)

EOF