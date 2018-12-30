clear;clc;
out_ori=dlmread('/home/fas/seto/xl533/scratch60/grace1/out.txt');   %read in outputs from npz
pixel_within=dlmread('/home/fas/seto/xl533/scratch60/grace1/144040_urbtraj_WithinShpnoOverlay_matlab.txt'); %read in urban only pixels (not overlapped)
[r_o,c_o]=size(out_ori);
fid=fopen('/home/fas/seto/xl533/scratch60/grace1/out_within.txt','w');  %output.txt


for i=1:r_o
        index=[out_ori(i,1),out_ori(i,2)];
        if ismember(index,pixel_within,'rows')==1 %ismember
            fprintf(fid,'%d ',out_ori(i,:)); %write results
            fprintf(fid,'\n ');
        end
end

fclose(fid);
