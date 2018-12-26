clear;clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shp=load('/home/fas/seto/bc643/scratch60/grace1/HKH_pixelsWithinScene_noOverlay/143040_pixelsWithinShpnoOverlay_sorted.txt');
urbtraj=load('/home/fas/seto/bc643/scripts/urbtraj_ori_143040_noExtraSpace.txt');

fid=fopen('/home/fas/seto/bc643/scratch60/grace1/143040_urbtraj_WithinShpnoOverlay_matlab.txt','w');

fprintf(fid,' %d %d\n', intersect(shp,urbtraj,'rows').');

fclose(fid);