##############################################################
setwd("/home/fas/seto/bc643/project/scratch60_temp/141041Imagestack")
library(rgdal)
library(raster)
library(RStoolbox)
library(Rmpi)

files <- list.files()

wkdir_for_log <- "/home/fas/seto/bc643/scripts/Outfiles"
setwd(wkdir_for_log)

# initialize an Rmpi environment
ns <- mpi.universe.size()
mpi.spawn.Rslaves(nslaves=ns)

# send these commands to the slaves
mpi.bcast.cmd( id <- mpi.comm.rank() )
mpi.bcast.cmd( ns <- mpi.comm.size() )
mpi.bcast.cmd( host <- mpi.get.processor.name() )

###############################################################
if (file.exists('/home/fas/seto/bc643/scratch60/grace1/141041_topCor_SE')==FALSE) {
	dir.create('/home/fas/seto/bc643/scratch60/grace1/141041_topCor_SE', showWarnings = TRUE)
}

topCor <- function(n,files){
	library(rgdal)
	library(raster)
	library(RStoolbox)
	print(n)
	###############################################################
	#e.g., /home/fas/seto/bc643/scratch60/grace1/141041clipped/LC081410412013042401T1_clipped
	wkdir <- paste0("/home/fas/seto/bc643/project/scratch60_temp/141041Imagestack/",files[n],sep='')
	print(wkdir)
	setwd(wkdir)
	files1 <- list.files()
	tifNameFirstPart <- strsplit(files1[1],'[.]')[[1]][1] #e.g., LC081410412013042401T1
	outfile <- paste(tifNameFirstPart,"topCor_SE",sep='_')
	files2 <- files1[1]
	#Stack bands 2,3,4,5,7

	###############################################################
	fullpath <- paste0("/home/fas/seto/bc643/scratch60/grace1/141041_topCor_SE/",outfile,sep='')
	fullpathTif_se <- paste0(fullpath,"/",outfile,sep='')
	if (file.exists(fullpath)==FALSE) {
		dir.create(fullpath, showWarnings = TRUE)
		print(fullpathTif_se)
		tif <- stack(files2, bands = as.integer(c(1,2,3,4,5)))

		###############################################################
		wholesrtm <- raster("/home/fas/seto/bc643/scratch60/grace1/141041_SRTM_mosaic_tif.tif")

		#crop, reproject and resample the SRTM
		wholesrtm_30_utm <- projectRaster(wholesrtm, tif, res, crs, method="bilinear", alignOnly=FALSE, over=FALSE)
		mysrtm <- wholesrtm_30_utm
		#pixel qa band as mask
		m = raster(files2,band=6)
		#mark the values of water&cloud-free clear pixels as 2
		m[m==66|m==130|m==322|m==386|m==400|m==834|m==898|m==1346] <- 2   
	
		if(sum(m[]!=2)==ncell(tif)){
			file.remove(fullpath)
			next
		}
		else{
			#change the values of water and cloud pixels into NA
			m[m!=2]<-NA    
			#mask out water and cloud
			tif_masked <- mask(tif,m)    

			tif_se <- topCor(tif_masked, dem = mysrtm, metaData = files1[2], method = "stat")

			writeRaster(tif_se,fullpathTif_se,format="GTiff",datatype='INT2S')
			print(fullpathTif_se)
		}
	}
}

# all slaves execute this command
x <- seq_len(300)
mpi.applyLB(x, topCor, files=files)

 
# close down the Rmpi environment
mpi.close.Rslaves(dellog = FALSE)
mpi.exit()
