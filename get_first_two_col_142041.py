import os

urbtraj_withinshp=open("/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbOnlyTraj_WithinShpNoOverlay_breaktime_month_maskwater_142041.txt", "r")
urbtraj_withinshp_list=urbtraj_withinshp.readlines()
urbtraj_withinshp.close()

f= open(r"/home/fas/seto/bc643/scratch60/grace1/urbOnlyPix_WithinShpNoOverlay/142041_urbpix_WithinShpnoOverlay_maskwater.txt","w")

for eachline in urbtraj_withinshp_list:
	print>>f,eachline.lstrip()[0:4],eachline.lstrip()[5:9]
f.close()