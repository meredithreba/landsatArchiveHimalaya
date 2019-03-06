import os
import numpy as np
os.chdir('/home/fas/seto/xl533/scripts')
###############npz directory
directory=r"/home/fas/seto/xl533/scratch60/grace6/yatsm_out_class/142040clip_1023"
os.chdir(directory)
files=os.listdir(directory)
###############outtxt
f= open(r"/home/fas/seto/xl533/scratch60/grace6/out.txt","w")
for i in range(0,len(files)):
    presentdir=os.path.join(directory,files[i])
    npz=np.load(presentdir)
    record=(npz['record.npy'])
    for j in range(0,len(record)):
        b=record[j]
        print>>f,b[6],b[7],b[0],b[1],b[2],b[10] #Pixel X, Pixel Y, model_StartDate, model_EndDate, model_breakDate(0=no change), class
f.close()
