############################################################################################
## Reprojecting, Resampling, Cropping & Masking DEMs for Topographic Correction    #########
## March 5, 2018                                                                   #########
############################################################################################


# load packages
library(rgdal)
library(raster)


# set the working directory
setwd ('E:\\Dropbox (Yale_FES)\\NASA_HimalayaProject_Dropbox\\topographicCorrection\\testOutput')

# read the Landsat scene tiff 
testScene <- raster("E:/Dropbox (Yale_FES)/sampleLandsat/LT051410411998010901T1-SC20171112170914/LT051410411998010901T1.tif")

# get extent for cropping SRTM data
extentScene <- extent(testScene)

#take only non NA values for masking later
testSceneSame <- !is.na(testScene)

# get the projection of the test Landsat image for reprojecting SRTM data
testSceneProjection <- crs(testScene)

# read the SRTM data
srtm <- raster("F:\\datashare\\NASA_Himalaya_project\\SRTM\\141041\\141041_SRTM_mosaic_tif.tif") # full mosaic tile

# reproject this SRTM data
srtmReproject = projectRaster(srtm, crs=testSceneProjection)

# crop the SRTM data using the extentPolygon
srtmCropped <- crop(srtmReproject, extent(extentScene))

# resample this SRTM data
## DEM should be resampled by BILINEAR
srtmResampled <- resample(srtmCropped, testScene, method="bilinear")

#mask the original landsat scene by these values
srtmCropMasked <- mask(srtmResampled, testSceneSame, maskvalue = 0)

writeRaster(srtmCropMasked,"E:\\Dropbox (Yale_FES)\\NASA_HimalayaProject_Dropbox\\topographicCorrection\\testOutput\\srtmCropMasked.tif",format="GTiff",datatype='INT2S')


