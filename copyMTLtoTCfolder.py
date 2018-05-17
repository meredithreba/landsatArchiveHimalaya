import os
import re
os.chdir('/home/fas/seto/bc643/scripts')
import shutil # module for file manipulation (copying, moving, deleting, etc)
import subprocess

# set the directory
#####################################################################################
directory = r"/home/fas/seto/bc643/scratch60/grace1/145039_Imagestack"

# change the directory to the given path
os.chdir(directory)
# list the files in the directory and save them as a variable (the Landsat tar files)
files_ori = os.listdir(directory)

#####################################################################################
outdirbase = r'/home/fas/seto/bc643/scratch60/grace1/145039_topCor_SE'
files = os.listdir(outdirbase)

# copy the MTL metadata file to clipped file folder
for x in range(0,len(files)):
	presentdir = os.path.join(outdirbase,files[x])
	#############################################################################
	image_name = presentdir.split('/')[8].split('_')[0]
	MTL_folder = [ z for z in files_ori if image_name in z] 
	MTL_folder = directory + '/' + MTL_folder[0]
	print(MTL_folder)
	#MTL_folder = directory + '/' + image_name + '_clipped'
	y= range(0,len(os.listdir(MTL_folder)))
	for i in range(0,len(os.listdir(MTL_folder))):
		y[i] = 'MTL' in os.listdir(MTL_folder)[i]
	fileindx = y.index(True)
	MTLname = os.listdir(MTL_folder)[fileindx]
	MTL_path = MTL_folder + '/' + MTLname 
	shutil.copy(MTL_path, presentdir)