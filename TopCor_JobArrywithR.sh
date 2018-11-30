#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=141041clipSEJobArry
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day
#SBATCH --time=24:00:00
#SBATCH --array=1-668
#SBATCH --mem-per-cpu=30G
#SBATCH -o Outfiles/141041clipSEJobArry_%A_%a.out

module load Apps/R/3.3.2-generic
module load Rpkgs/RASTER
module load Rpkgs/RGDAL
module load Rpkgs/RGEOS
module load Rpkgs/XML

file=$(ls /home/fas/seto/bc643/scratch60/grace1/141041clipped/L?0?141041????????????_clipped/L?0?141041????????????_clipped.tif | head -n $SLURM_ARRAY_TASK_ID | tail -1 )
export  file
R --vanilla --no-readline -q  << 'EOF'

##############################################################
#Remember to change '#SBATCH --array=xxx-xxx' accordingly
file <- Sys.getenv(c('file'))
library(rgdal)
library(raster)
library(RStoolbox)

###############################################################
if (file.exists('/home/fas/seto/bc643/scratch60/grace1/141041clipped_topCor_SE_5bandsAndQA_0920test')==FALSE) {
	dir.create('/home/fas/seto/bc643/scratch60/grace1/141041clipped_topCor_SE_5bandsAndQA_0920test', showWarnings = TRUE)
}

print(file)
###############################################################
#e.g., /home/fas/seto/bc643/scratch60/grace1/141041clipped/LC081410412013042401T1_clipped
wkdir <- paste0("/home/fas/seto/bc643/scratch60/grace1/141041clipped/",strsplit(file[1],'[/]')[[1]][9],sep='')
print(wkdir)
setwd(wkdir)
files1 <- list.files()
Oristack <- grep('tif', files1, value=TRUE)
print(Oristack)
tifNameFirstPart <- strsplit(Oristack,'[.]')[[1]][1] #e.g., LC081410412013042401T1
outfile <- paste(tifNameFirstPart,"topCor_SE",sep='_')

#Stack bands 2,3,4,5,7
###############################################################
fullpath <- paste0("/home/fas/seto/bc643/scratch60/grace1/141041clipped_topCor_SE_5bandsAndQA_0920test/",outfile,sep='')
fullpathTif_se <- paste0(fullpath,"/",outfile,sep='')
if (file.exists(fullpath)==FALSE) {
	dir.create(fullpath, showWarnings = TRUE)
	print(fullpathTif_se)
	#For original image stack with 6 bands (Landsat bands 23457 & pixel qa), next line should be: tif <- stack(Oristack, bands = as.integer(c(1,2,3,4,5)))
	tif <- stack(Oristack, bands = as.integer(c(2,3,4,5,6)))

###############################################################
	wholesrtm <- raster("/home/fas/seto/bc643/scratch60/grace1/141041_SRTM_mosaic_tif.tif")

	#crop, reproject and resample the SRTM
	wholesrtm_30_utm <- projectRaster(wholesrtm, tif, method="bilinear", alignOnly=FALSE, over=FALSE)
	mysrtm <- wholesrtm_30_utm
	#pixel qa band as mask
	#For original image stack with 6 bands (Landsat bands 23457 & pixel qa), next line should be: m = raster(Oristack,band=6)
	m = raster(Oristack,band=8)
	#mark the values of cloud-free clear & water pixels as 2
	m[m==66|m==130|m==68|m==132|m==322|m==386|m==400|m==834|m==898|m==1346|m==324|m==388|m==836|m==900] <- 2   
	if(sum(m[]!=2)==ncell(Oristack)){
		file.remove(fullpath)
	}
	else{
		#change the values of cloud pixels into NA
		m[m!=2]<-NA    
		#mask out cloud
		tif_masked <- mask(tif,m)    

		tif_se <- topCor(tif_masked, dem = mysrtm, metaData = grep('txt', files1, value=TRUE), method = "stat")
		
		tif_se <- addLayer(tif_se, m)
		writeRaster(tif_se,fullpathTif_se,format="GTiff",datatype='INT2S')
		print(fullpathTif_se)

		#copy MTL file to TopCor folder
		file.copy(from=grep('txt', files1, value=TRUE), to=fullpath, overwrite = TRUE, recursive = FALSE, copy.mode = TRUE)
	}
	
}
EOF
