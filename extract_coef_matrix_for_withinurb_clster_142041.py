import os
import numpy as np
os.chdir('/home/fas/seto/bc643/scripts')
###############npz directory
directory=r"/home/fas/seto/bc643/scratch60/grace1/yatsm_out/142041_topCor_SE_5bAndQA_Gaussian_withWater_noHimal_out_clsf"
os.chdir(directory)
files=os.listdir(directory)
###############withinshp file
pixel_withinshp=open("/home/fas/seto/bc643/scratch60/grace1/urbOnlyPix_WithinShpNoOverlay/142041_urbpix_WithinShpnoOverlay_maskwater.txt", "r")

pixel_withinshp_list=pixel_withinshp.readlines()
pixel_withinshp.close()
###############outtxt
f= open(r"/home/fas/seto/bc643/scratch60/grace1/withinUrban_clustering/142041_coef_matrix.txt","w")
for i in range(0,len(files)):
    presentdir=os.path.join(directory,files[i])
    npz=np.load(presentdir)
    record=(npz['record.npy'])
    for j in range(0,len(record)):
		b=record[j]
		#index=[b[6],b[7]]
		if str(b[6])+' '+str(b[7])+'\n'in pixel_withinshp_list:
			if b[10]==5:
				print>>f,b[6],b[7],b[0],b[1],b[3] #Pixel X, Pixel Y, model_StartDate, model_EndDate, coefficient matrix
f.close()