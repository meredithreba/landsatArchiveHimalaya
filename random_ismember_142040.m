clear;clc;
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace2/traj_urban_medium_front_end_month_1990.txt');   %read in trajectory data, month_level, since 1990-01-01
pixel_ran=dlmread('/home/fas/seto/xl533/scratch60/grace2/142040_urbtraj_WithinShpnoOverlay_1pct_rand.txt'); %read in random urban only pixelX & pixelY
[r_t,c_t]=size(traj_matrix);
[r_r,c_r]=size(pixel_ran);
pixel_index=traj_matrix(2:r_t,1:2); %create a matrix of all urban pixels' X&Y 
fid=fopen('/home/fas/seto/xl533/scratch60/grace2/rand_traj.txt','w');


for i=1:r_r
    for j=2:r_t
        if pixel_ran(i,1)==traj_matrix(j,1) && pixel_ran(i,2)==traj_matrix(j,2)  %ismember
            fprintf(fid,'%d ',traj_matrix(j,:)); %write out random traj
            fprintf(fid,'\n ');
        end
    end
end

fclose(fid);