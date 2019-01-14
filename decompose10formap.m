clear;clc;
traj=dlmread('/home/fas/seto/xl533/scratch60/grace9/traj_10scenes_all_new.txt');
kmodes=dlmread('/home/fas/seto/xl533/scratch60/grace9/kmodes/kmodes_14.txt');   %%%%%%%

[r,c]=size(traj);

index1=[traj(1:4911,1:2),kmodes(1:4911,1)]; %4911
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/139041.txt','w');
for i=1:4911
    fprintf(fid,'%d ',index1(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index2=[traj(4912:550890,1:2),kmodes(4912:550890,1)];   %545979
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/140041.txt','w');
for i=1:545979
    fprintf(fid,'%d ',index2(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index3=[traj(550891:953318,1:2),kmodes(550891:953318,1)];   %402428
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/141041.txt','w');
for i=1:402428
    fprintf(fid,'%d ',index3(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index4=[traj(953319:1272202,1:2),kmodes(953319:1272202,1)];   %318884
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/142041.txt','w');
for i=1:318884
    fprintf(fid,'%d ',index4(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index5=[traj(1272203:1490646,1:2),kmodes(1272203:1490646,1)];   %218444
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/143041.txt','w');
for i=1:218444
    fprintf(fid,'%d ',index5(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index6=[traj(1490647:1569388,1:2),kmodes(1490647:1569388,1)];   %78742
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/144040.txt','w');
for i=1:78742
    fprintf(fid,'%d ',index6(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index7=[traj(1569389:1615261,1:2),kmodes(1569389:1615261,1)];   %45872
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/142040.txt','w');
for i=1:45872
    fprintf(fid,'%d ',index7(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index8=[traj(1615262:1626670,1:2),kmodes(1615262:1626670,1)];   %11409
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/143040.txt','w');
for i=1:11409
    fprintf(fid,'%d ',index8(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index9=[traj(1626671:1665713,1:2),kmodes(1626671:1665713,1)];   %39043
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/139042.txt','w');
for i=1:39043
    fprintf(fid,'%d ',index9(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

index10=[traj(1665714:1960728,1:2),kmodes(1665714:1960728,1)];   %295015
fid=fopen('/home/fas/seto/xl533/scratch60/grace9/decompose10/140042.txt','w');
for i=1:295015
    fprintf(fid,'%d ',index10(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);


