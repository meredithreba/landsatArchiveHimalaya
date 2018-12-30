clear;clc;
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace2/traj_urban_medium_front_end_month_1990.txt');   %read in trajectory data, month_level, since 1990-01-01
pixel_ran=dlmread('/home/fas/seto/xl533/scratch60/grace2/142040_urbtraj_WithinShpnoOverlay_1pct_rand.txt'); %read in random urban only pixelX & pixelY
[r_t,c_t]=size(traj_matrix);
fid=fopen('/home/fas/seto/xl533/scratch60/grace2/rand_traj.txt','w');


for i=1:r_t
        index=[traj_matrix(i,1),traj_matrix(i,2)];
        if ismember(index,pixel_ran,'rows')==1
            fprintf(fid,'%d ',traj_matrix(i,:)); %write out random traj
            fprintf(fid,'\n ');
        end
end

fclose(fid);
