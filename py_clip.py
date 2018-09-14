import os
import re
os.chdir('/home/fas/seto/bc643/scripts')
import unziplandsat
from osgeo import gdal
import shutil # module for file manipulation (copying, moving, deleting, etc)
import subprocess

# set the directory
############################################################################################################################
directory = r"/home/fas/seto/bc643/scratch60/grace1/Suihua_Imagestack"

# change the directory to the given path
os.chdir(directory)
# list the files in the directory and save them as a variable (the Landsat tar files)
files = os.listdir(directory)
# folder for the outfiles to go to for intermediate/temp files
############################################################################################################################
outdirbase = r'/home/fas/seto/bc643/scratch60/grace1/Suihua_Imagestack_Hailun'

stacks = []
stacksCrop = []
MTLs = []

for x in range(0,len(files)):
	folname = files[x].split('.')[0].split('-')[0]
	outdirname = outdirbase + '/' + folname
	os.makedirs(outdirname)
	stacksCrop.append(outdirname + '/' + folname + '.tif')

# go through all the directories
for x in range(0,len(files)):
	presentdir = os.path.join(directory,files[x])
	y= range(0,len(os.listdir(presentdir)))
	for i in range(0,len(os.listdir(presentdir))):
		y[i] = 'tif' in os.listdir(presentdir)[i]
	fileindx = y.index(True)
	filenam = os.listdir(presentdir)[fileindx]
	stacks.append(os.path.join(presentdir,filenam))

# copy the MTL metadata file to clipped file folder
for x in range(0,len(files)):
	presentdir = os.path.join(directory,files[x])
	y= range(0,len(os.listdir(presentdir)))
	for i in range(0,len(os.listdir(presentdir))):
		y[i] = 'MTL' in os.listdir(presentdir)[i]
	fileindx = y.index(True)
	filenam = os.listdir(presentdir)[fileindx]
	MTLs.append(os.path.join(presentdir,filenam))
	folname = files[x].split('.')[0].split('-')[0]
	outdirname = outdirbase + '/' + folname
	shutil.copy(MTLs[x], outdirname)

for x in range(0,len(files)):	
	#os.system('gdalwarp -cutline /home/fas/seto/bc643/project/micro/Charikot/Charikot_extent_polygon.shp -crop_to_cutline re.sub('"', '', stacks[x]) re.sub('"', '', stacksCrop[x])')
	subprocess.call(["gdalwarp", "-cutline", "/home/fas/seto/bc643/scratch60/grace1/micro/Suihua/Hailun_test.shp", "-crop_to_cutline", stacks[x], stacksCrop[x]])
