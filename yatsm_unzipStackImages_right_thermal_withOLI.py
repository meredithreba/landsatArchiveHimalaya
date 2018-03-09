import os
os.chdir('/home/fas/seto/bc643/scripts')
import unziplandsat
from osgeo import gdal
import shutil
###################################################################################################################################
directory = r"/home/fas/seto/bc643/scratch60/grace1/141041zipped"
os.chdir(directory)
files = os.listdir(directory)
###################################################################################################################################
outdirbase= r'/home/fas/seto/bc643/scratch60/grace1/141041junk'
if(os.path.exists(outdirbase) == False):
    os.mkdir(outdirbase)

#if (len(os.listdir(outdirbase))==0):
for i in range(0,len(files)):
    name = files[i]
    folname = files[i].split('.')[0]
    outdirname = outdirbase + '/' + folname
    if(os.path.exists(outdirname)):
        continue
    else: 
        os.makedirs(outdirname)
        unziplandsat.unziplandsat(name,outdirname)
        print name
print "Unzip Done"

#else:
    #print "Unzip Done"

alldirs = os.listdir(outdirbase)
allfilesband1 = []
for x in range(0,len(alldirs)):
	presentdir = os.path.join(outdirbase,alldirs[x])
	x= range(0,len(os.listdir(presentdir)))
	for i in range(0,len(os.listdir(presentdir))):
		x[i] = 'band1' in os.listdir(presentdir)[i]
	fileindx = x.index(True)
	filenam = os.listdir(presentdir)[fileindx]
	allfilesband1.append(os.path.join(presentdir,filenam))

##################################################################################################################################
thefile = open('/home/fas/seto/bc643/scratch60/grace1/'+ 'test.txt', 'w')

for item in allfilesband1:
	thefile.write("%s\n" % item)
thefile.close()
os.chdir(directory)

##################################################################################################################################
os.system('gdalbuildvrt -separate -input_file_list /home/fas/seto/bc643/scratch60/grace1/test.txt /home/fas/seto/bc643/scratch60/grace1/out.vrt')
###########################################################################################################################
os.system('gdal_translate /home/fas/seto/bc643/scratch60/grace1/out.vrt -b 1 -of GTiff /home/fas/seto/bc643/scratch60/grace1/out.tif')

print "All Done"

##################################################################################################################################
outdir = '/home/fas/seto/bc643/scratch60/grace1/141041Imagestack'
if (os.path.exists(outdir) == False):
	os.mkdir(outdir)
for x in range(0,len(alldirs)):	
	presentdir = os.path.join(outdirbase,alldirs[x])
	filesinpresentdir = os.listdir(presentdir)
	if "LC" in presentdir:
		files = [ y for y in filesinpresentdir if "sr_band2" in y or "sr_band3" in y or "sr_band4" in y or "sr_band5" in y or "sr_band6" in y or "sr_band7" in y]
		files = [os.path.join(presentdir,z) for z in files]
		files.sort()
		##########
		filestherm = [ y for y in filesinpresentdir if "bt_band10" in y]
		filestherm = [os.path.join(presentdir,z) for z in filestherm]
		filestherm = filestherm[0]
		files.append(filestherm)
		filesqa = [ y for y in filesinpresentdir if "pixel_qa" in y]
		filesqa = [os.path.join(presentdir,z) for z in filesqa]
		filesqa = filesqa[0] 
		files.append(filesqa)
		###########################################################################################################################
		files.append(r"/home/fas/seto/bc643/scratch60/grace1/out.tif")
		###########################################################################################################################
		outdir = '/home/fas/seto/bc643/scratch60/grace1/141041Imagestack/' + presentdir.split('/')[8]
		if (os.path.exists(outdir)):
			continue
		else:
			print str(x) + "start"
			os.mkdir(outdir)
			outvrt = outdir + "/" + presentdir.split('/')[8] + '.vrt' 
			outtif = outdir + "/" + presentdir.split('/')[8] + '.tif'
			outtif2 = outdir + '/' + presentdir.split('/')[8].split('-')[0] + '.tif'
			tifs = files
			outds = gdal.BuildVRT(outvrt, tifs, separate=True)
			outds = gdal.Translate(outtif, outds)
			outds = None
			#############
			outds1 = gdal.Translate(outtif2,outtif,bandList = [1,2,3,4,5,6,7,8])
			outds1 = None
			mtlfile = [ y for y in filesinpresentdir if "MTL" in y]
			mtlfile =[os.path.join(presentdir,z) for z in mtlfile]
			shutil.copy2(mtlfile[0],str(outdir))
			filestorem = os.listdir(outdir)
			filestorem.sort()
			os.chdir(outdir)
			map(os.remove,filestorem[0:3])
			print x
	else:
		files = [ y for y in filesinpresentdir if "sr_band" in y]
		files = [os.path.join(presentdir,z) for z in files]
		files.sort()
		##########
		filestherm = [ y for y in filesinpresentdir if "bt" in y]
		filestherm = [os.path.join(presentdir,z) for z in filestherm]
		filestherm = filestherm[0]
		files.append(filestherm)
		filesqa = [ y for y in filesinpresentdir if "pixel_qa" in y]
		filesqa = [os.path.join(presentdir,z) for z in filesqa]
		filesqa = filesqa[0] 
		files.append(filesqa)
		###########################################################################################################################
		files.append(r"/home/fas/seto/bc643/scratch60/grace1/out.tif")
		###########################################################################################################################
		outdir = '/home/fas/seto/bc643/scratch60/grace1/141041Imagestack/' + presentdir.split('/')[8]
		if (os.path.exists(outdir)):
			continue
		else:
			print str(x) + "start"
			os.mkdir(outdir)
			outvrt = outdir + "/" + presentdir.split('/')[8] + '.vrt' 
			outtif = outdir + "/" + presentdir.split('/')[8] + '.tif'
			outtif2 = outdir + '/' + presentdir.split('/')[8].split('-')[0] + '.tif'
			tifs = files
			outds = gdal.BuildVRT(outvrt, tifs, separate=True)
			outds = gdal.Translate(outtif, outds)
			outds = None
			#############
			outds1 = gdal.Translate(outtif2,outtif,bandList = [1,2,3,4,5,6,7,8])
			outds1 = None
			mtlfile = [ y for y in filesinpresentdir if "MTL" in y]
			mtlfile =[os.path.join(presentdir,z) for z in mtlfile]
			shutil.copy2(mtlfile[0],str(outdir))
			filestorem = os.listdir(outdir)
			filestorem.sort()
			os.chdir(outdir)
			map(os.remove,filestorem[0:3])
			print x