# -*- coding: utf-8 -*-
"""
Created on Wed Oct 25 20:03:28 2017

@author: mra37
"""

import os
from osgeo import gdal, osr
import numpy as np

directory = r"Z:\NASA_Himalaya_Project\YATSM\YATSM_processOutput\yatsm_testData_allcoefb5"  #The directory where coefficient image time series are

os.chdir(directory)
files = os.listdir(directory)  # Read files in the directory where coefficient image time series are

# Set GeoTiff driver
driver = gdal.GetDriverByName("GTiff")
driver.Register()

# Get information to write the raster
# Open raster and read number of rows, columns, bands
# gtif = gdal.Open(files[0], gdal.GA_ReadOnly)
# gtif.GetMetadata() #{'AREA_OR_POINT': 'Area'}?


# Get the time dimension (2000, 2002, 2004, 2006, 2008, 2010, 2012)
time = np.linspace(2000,2012,7)

# Create a numpy array filled with zeros with data format for float 32
# Single precision float: sign bit, 8 bits exponent, 23 bits mantissa
output = np.zeros((300,300),'float32')

fileopen = gdal.Open('coef20000801b5.gtif', gdal.GA_ReadOnly)
type(fileopen)
fileopen.GetProjection()
fileopen.RasterXSize
fileopen.RasterYSize
fileopen.RasterCount
fileopen.GetMetadata()

# read band two
band = fileopen.GetRasterBand(2)
type(band)
gdal.GetDataTypeName(band.DataType)

# We have 300 rows in an image
for row in range(0,300):
	# create a numpy array filled with zeros for 300 rows and 7 columns
	# this will store one line for each of the time periods
    outarr= np.zeros((300, 7))
	# fill a 1-D numpy array with zeros
    outarrcor = np.zeros(300)
	# for each of the yatsm output files for each of the seven dates
    for i in range(0,7):
		# open the files
        fileopen = gdal.Open(files[i], gdal.GA_ReadOnly)
		# read band two
        band = fileopen.GetRasterBand(2)
        rasterArray = band.ReadAsArray()
        # read band as an array
        #def get_raster_cells(band, cols, rows):
            #return band.ReadAsArray(0, 0, cols, rows)
        
        #array = get_raster_cells(band, cols,rows)
		# for the band 2 image take the first row and all columns and put it in the first column and 
		# all of the rows of outarr
        outarr[:,i] = rasterArray[row,:]
	# now for each of these 300 arrays of 300x7 pixels for each of the rows, 
	# loop through them all
    for j in range(0,300):
		# calculate the correlation coefficient between the row (band 2 slope of each image) and 
		# corresponding time
		# for the correlation coefficient take the first value in the second column
		# corrcoef prints a 2x2 array
        outarrcor[j]  = np.corrcoef(outarr[j,],time)[0,1]
		# change all na values to 0
        outarrcor[np.isnan(outarrcor)]=0
    # now in the output array of 300x300pixels take all of these 300 rows and all the columns and print them
	# to outarrcor
    output[row,:] = outarrcor
    print row
    
# write the final raster - this seems inefficient
def array2raster(rasterfn,newRasterfn,array):
    raster = gdal.Open(rasterfn)
    geotransform = raster.GetGeoTransform()
    originX = geotransform[0]
    originY = geotransform[3]
    pixelWidth = geotransform[1]
    pixelHeight = geotransform[5]
    cols = raster.RasterXSize
    rows = raster.RasterYSize

    driver = gdal.GetDriverByName('GTiff')
    outRaster = driver.Create(newRasterfn, cols, rows, 1, gdal.GDT_Float32)
    outRaster.SetGeoTransform((originX, pixelWidth, 0, originY, 0, pixelHeight))
    outband = outRaster.GetRasterBand(1)
    outband.WriteArray(array)
    outRasterSRS = osr.SpatialReference()
    outRasterSRS.ImportFromWkt(raster.GetProjectionRef())
    outRaster.SetProjection(outRasterSRS.ExportToWkt())
    outband.FlushCache()


rasterfn = 'coef20000801b5.gtif'
newRasterfn = 'Z:\NASA_Himalaya_Project\YATSM\YATSM_processOutput\output\corrcoef11_66.tif'
array2raster(rasterfn,newRasterfn,output)


# close out everything 
fileopen = None
band = None


'''
###################################################################################################################
## Trash heap

# Get array of raster cell values.  The two zeros tell the
# iterator which cell to start on and the 'cols' and 'rows'
# tell the iterator to iterate through all columns and all rows.
def get_raster_cells(band, cols, rows):
    return band.ReadAsArray(0, 0, cols, rows)

#Bind array to a variable
rasterData = get_raster_cells(band,cols,rows)

#The array will look something like this if you print it
print rasterData

# create a numpy array filled with zeros for 300 rows and 7 columns
# this will store one line for each of the time periods
outarr= np.zeros((300, 7))

# fill a 1-D numpy array with zeros
outarrcor = np.zeros(300)
    
# for the band 2 image take the first row and all columns and put it in the first column and 
# all of the rows of outarr
outarr[:,i] = band[row,:]


# iterate through your data in a nested loop
for row in raster data:
    for val in row:
        print val

# or flatten your 2-D array with a list comprehension
flat = [val for row in rasterData for val in row]

pixcc=rasterio.open('corrcoef11.tif', 'w',**src.meta)    
pixcc.write(output,1)

pixcc = None
fileopen = None

def array_to_raster(array):
    """Array > Raster
    Save a raster from a C order array.

    :param array: ndarray
    """
    dst_filename = '/a_file/name.tiff'


    # You need to get those values like you did.
    x_pixels = 16  # number of pixels in x
    y_pixels = 16  # number of pixels in y
    PIXEL_SIZE = 3  # size of the pixel...        
    x_min = 553648  
    y_max = 7784555  # x_min & y_max are like the "top left" corner.
    wkt_projection = 'a projection in wkt that you got from other file'

    driver = gdal.GetDriverByName('GTiff')

    dataset = driver.Create(
        dst_filename,
        x_pixels,
        y_pixels,
        1,
        gdal.GDT_Float32, )

    dataset.SetGeoTransform((
        x_min,    # 0
        PIXEL_SIZE,  # 1
        0,                      # 2
        y_max,    # 3
        0,                      # 4
        -PIXEL_SIZE))  

    dataset.SetProjection(wkt_projection)
    dataset.GetRasterBand(1).WriteArray(array)
    dataset.FlushCache()  # Write to disk.
    return dataset, dataset.GetRasterBand(1)  #If you need to return, remenber to return  also the dataset because the band don`t live without dataset.


# Set GeoTiff driver
driver = gdal.GetDriverByName("GTiff")
driver.Register()
'''


## Convert Raster to array
#rasterArray = raster2array(rasterfn)
#
## Get no data value of array
#noDataValue = getNoDataValue(rasterfn)
#
## Updata no data value in array with new value
#rasterArray[rasterArray == noDataValue] = newValue
#
## Write updated array to new raster
#array2raster(rasterfn,newRasterfn,rasterArray)
