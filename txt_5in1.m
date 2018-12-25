clear;clc;
A=dlmread('/home/fas/seto/xl533/scratch60/grace1/rand_traj_144040.txt');
B=dlmread('/home/fas/seto/xl533/scratch60/grace2/rand_traj_142040.txt');
C=dlmread('/home/fas/seto/xl533/scratch60/grace4/rand_traj_143040.txt');
D=dlmread('/home/fas/seto/xl533/scratch60/grace7/rand_traj_139042.txt');
E=dlmread('/home/fas/seto/xl533/scratch60/grace8/rand_traj_140042.txt');

F=[A;B;C;D;E];
[r_f,c_f]=size(F);
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/rand_5in1.txt','w');
for i=1:r_f
    fprintf(fid,'%d ',F(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);