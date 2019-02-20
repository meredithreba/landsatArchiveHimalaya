clear;clc;

traj=load('/home/fas/seto/xl533/scratch60/grace6/traj_urban_breaktime_month_19902017.txt');
%traj=load('F:\Semester1\Himalaya\CCDC\Codes\matrix_mine\traj_sample.txt');
fid=fopen('/home/fas/seto/xl533/scratch60/grace6/count_twists.txt','w');
%fid=fopen('F:\Semester1\Himalaya\CCDC\Codes\matrix_mine\traj_twists.txt','w');

[r,c]=size(traj);
count=zeros(r,1); former=0;

for i=1:r
    former=traj(i,3);
    for j=4:c
        if traj(i,j)~= former
            count(i,1)=count(i,1)+1;
            former=traj(i,j);
        end
    end
end

fprintf(fid,'%d ',count(1:r,1));

fclose(fid);