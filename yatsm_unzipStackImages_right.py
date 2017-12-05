import os
os.chdir('/home/fas/seto/bc643/scripts')
import unziplandsat
from osgeo import gdal
import shutil # module for file manipulation (copying, moving, deleting, etc)

# set the directory
directory = r"/home/fas/seto/bc643/project/test/testStackZipped"

# change the directory to the given path
os.chdir(directory)
# list the files in the directory and save them as a variable (the Landsat tar files)
files = os.listdir(directory)
# folder for the outfiles to go to for intermediate/temp files
outdirbase= r'/home/fas/seto/bc643/project/test/Junk'
#outdirbase= r'Z:\NASA_Himalaya_Project\Satellite_imagery\Junk'

# work through the folders -- could you use walk function instead? i think we used it for UC
# if there is nothing in the out directory then loop through the length of directories
if (len(os.listdir(outdirbase))==0):
    for i in range(0,len(files)): # loop through the list of downloaded Landsat tiles
        name = files[i] # get each image's file name
        # split the folder names and use the first part before period which removes the .tar.gz
        folname = files[i].split('.')[0]
        # go to the out directory base (which is landat\junk where we will create these new files paths to
        # these new folders named by folname above
        outdirname = outdirbase + '/' + folname
        # make the new directories which are named using the outdirname above
        os.makedirs(outdirname)
        # use the unzip function (in folder) name=input file and outdirname=outdirectory(where tar files are extracted)
        unziplandsat.unziplandsat(name,outdirname)
    print "Unzip Done"

else:
    print "Unzip Done"

# list all the directories in the outdirbase where all the unzipped files are now
# alldirs looks like this: 'LE071460392015101801T1-SC20171003190640'
alldirs = os.listdir(outdirbase)
# initialize a new list to hold band1 list for extent
allfilesband1 = []

# go through all the directories
# range generates a list of numbers which is generally used to iterate over in for loops
for x in range(0,len(alldirs)):
	presentdir = os.path.join(outdirbase,alldirs[x])
	x= range(0,len(os.listdir(presentdir)))
	for i in range(0,len(os.listdir(presentdir))):
		x[i] = 'band1' in os.listdir(presentdir)[i]
	fileindx = x.index(True)
	filenam = os.listdir(presentdir)[fileindx]
	allfilesband1.append(os.path.join(presentdir,filenam))

# need to open the file first and make it writeable by indicating "w"
thefile = open('/home/fas/seto/bc643/project/test/'+ 'test.txt', 'w')
#thefile = open('Z:/NASA_Himalaya_Project/Satellite_imagery/'+ 'test.txt', 'w')

# loop through the list of all band1 files
for item in allfilesband1:
    #write the list to a file but you must open the file first which is done in the step above
  thefile.write("%s\n" % item)
# close the file
thefile.close()
# change the directory back to the Dehradun sample images
os.chdir(directory)

# this builds a VRT from a list of datasets in test.txt (it is a R function?)
# VRT allows virtual GDAL datasets to be composed from other GDAL datasets with repositioning and other algorithms
# potentially applied and various kinds of metadata altered or added.
# the resulting file can be edited to modify mappings and metadata for other purposes
# this line builds the vrt of all the images in the input file list and takes the largest extent
os.system('gdalbuildvrt -separate -input_file_list /home/fas/seto/bc643/project/test/test1a.txt /home/fas/seto/bc643/project/test/out.vrt')
#os.system('gdalbuildvrt -separate -input_file_list Z:/NASA_Himalaya_Project/Satellite_imagery/test.txt Z:/NASA_Himalaya_Project/Satellite_imagery/out.vrt')
# gdal_translate can be used to convert raster data between different formats, potentially performing some operations
# like subsettings, resampling, or rescaling pixels. we are using it to edit the extent
#Then we will use this later to unify all bands
# we take the out VRT for band1 and convert it to an out GTiff
os.system('gdal_translate /home/fas/seto/bc643/project/test/out1a.vrt -b 1 -of GTiff /home/fas/seto/bc643/project/test/out.tif')
#os.system('gdal_translate Z:/NASA_Himalaya_Project/Satellite_imagery/out.vrt -b 1 -of GTiff Z:/NASA_Himalaya_Project/Satellite_imagery/out.tif')

print "All Done"

# creating the layer stack
for x in range(0,len(alldirs)):
    # this is the directory of each image tile again from above, we are creating the directory path
	presentdir = os.path.join(outdirbase,alldirs[x])

	# list all the files in the present directory for one image tile/scene
	filesinpresentdir = os.listdir(presentdir)

	# take all the s surface reflectance bands
	# go through the files in this directory and look for ones including "sr_band" in the name
	files = [ y for y in filesinpresentdir if "sr_band" in y]
	# for all of these sr bands, put join them to the current directory
	files = [os.path.join(presentdir,z) for z in files]
	files.sort()
	# now do the same thing for the quality band
	filesqa = [ y for y in filesinpresentdir if "pixel_qa" in y]
	# take the qa band and join it to the current directory
	filesqa = [os.path.join(presentdir,z) for z in filesqa]
	filesqa = filesqa[0] # append the quality band first in list/stack?
	files.append(filesqa)

	files.append(r"/home/fas/seto/bc643/project/test/out1a.tif") # append the outtif from before to the files/image stack
	#files.append(r"Z:\NASA_Himalaya_Project\Satellite_imagery\out.tif") # append the outtif from before to the files/image stack

	# create names for the new directories by splitting the direcory name after the 4th set of /
	# which includes the image name
	outdir = '/home/fas/seto/bc643/project/test/ImageStack/' + presentdir.split('/')[8]
	#outdir = 'Z:/NASA_Himalaya_Project/Satellite_imagery/ImageStack/' + presentdir.split('/')[4]

	# make a new out directory
	os.mkdir(outdir)

	# create a bunch of directory paths and files to use later
	# creat this vrt file and put it in each image stack folder
	outvrt = outdir + "/" + presentdir.split('/')[8] + '.vrt'  #/vsimem is special in-memory virtual "directory"
	# create the outtif and put it in the image folder
	outtif = outdir + "/" + presentdir.split('/')[8] + '.tif'  # this creates the outtif
	# split the long file name at the last hypen and take the first part only
	outtif2 = outdir + '/' + presentdir.split('/')[8].split('-')[0] + '.tif'

	# take the list of files and call them tiffs
	tifs = files
	# use the list of files (which are sr bands) and "outvrt" in the vrt to build the vrts of all the bands
	#  and call the result outds
	outds = gdal.BuildVRT(outvrt, tifs, separate=True)
	# gdal_translate can be used to convert raster data between different formats, potentially performing some operations
	# like subsettings, resampling, or rescaling pixels
	# use the outtif from above from above to translate (this is set the equal extent?
	outds = gdal.Translate(outtif, outds)
	outds = None #close outds
	# get the first 7 bands and get rid of the out.tif band
	# translate using the band list
	outds1 = gdal.Translate(outtif2,outtif,bandList = [1,2,3,4,5,6,7])
	# close outds1
	outds1 = None

	# take the MTL band and add it to the directory for each image
	mtlfile = [ y for y in filesinpresentdir if "MTL" in y]
	mtlfile =[os.path.join(presentdir,z) for z in mtlfile]

	# copy the mtl file to the image folder
	shutil.copy2(mtlfile[0],str(outdir))
	#list the files in the image folder and call them "filestorem"
	# all these files are included: ['LE071460392015122101T1-SC20171003183427.tif',
	# 'LE071460392015122101T1-SC20171003183427.tif.aux.xml', 'LE071460392015122101T1-SC20171003183427.vrt',
	# 'LE071460392015122101T1.tif', 'LE07_L1TP_146039_20151221_20161016_01_T1_MTL.txt']
	filestorem = os.listdir(outdir)
	filestorem.sort()
	os.chdir(outdir)
	# applies this function over all the items in the directory or input list and removes the first 3 files
	# leaving the MTL and the image stack
	map(os.remove,filestorem[0:3])
	print x

