# -*- coding: utf-8 -*-
"""
Created on Sun Oct 22 23:02:20 2017

@author: Katie
"""

import os
import rasterio
import numpy as np

directory = r"Z:\NASA_Himalaya_Project\YATSM\YATSM_processOutput\yatsm_testData_allcoefb5"  #The directory where coefficient image time series are

os.chdir(directory)
files = os.listdir(directory)  # Read files in the directory where coefficient image time series are
#file1 = rasterio.open(files[0]) # Open the first file

with rasterio.open(files[0]) as src:
    profile = src.profile
    profile.update(count=1)

# Get the metadata for the output file 
#profile = file1.profile
#profile.update(dtype=rasterio.float32, count=1)
# Update the number of bands for the output file. We only want one band.
#meta.update(count = 1)  

# Get the time dimension (2000, 2002, 2004, 2006, 2008, 2010, 2012)
time = np.linspace(2000,2012,7)

# Create a numpy array filled with zeros with data format for float 32
# Single precision float: sign bit, 8 bits exponent, 23 bits mantissa
output = np.zeros((300,300),'float32')

# create an intermediate array to store the values like the one of the slope output bands
#imageopen = rasterio.open('coef20000801b5.gtif')
#bandread = fileopen.read_band(2)
#output = np.zeros_like(bandread)

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
        fileopen = rasterio.open(files[i])
		# read band two
        band = fileopen.read_band(2)
		#####
		# for the band 2 image take the first row and all columns and put it in the first column and 
		# all of the rows of outarr
        outarr[:,i] = band[row,:]
	# now for each of these 300 arrays of 300x7 pixels for each of the rows, 
	# loop through them all
    # j = each row in outarr
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

# write the final raster
## this is NOT attaching the metadata. need to fix
with rasterio.open('corrcoef11_4.tif', 'w',**profile) as dst:
    dst.write(output.astype(rasterio.float32), 1)


#pixcc=rasterio.open('corrcoef11.tif', 'w',**profile)   
#pixcc.write(output,1)

pixcc = None
fileopen = None
