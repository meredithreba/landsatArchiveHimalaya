clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace6/out_HPC.txt');
[r,c]=size(array);
pixelXmax=max(array(:,1));
pixelYmax=max(array(:,2));
minn=min(array(:,3));    %date min and max
maxx=max(array(:,4));
vector_len=maxx-minn;
%min=725741,max=736901, len=11160
fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj.txt','w');
fprintf(fid,'%d ',minn,maxx);
fprintf(fid,'\n ');

traj=zeros(pixelXmax+1,pixelYmax+1,vector_len); %trajectory matrix
for k=1:r                  %go through all items in matrix.txt
    pixelX=array(k,1);
    pixelY=array(k,2);
    startDate=array(k,3);
    endDate=array(k,4);
    whetherBreak=array(k,5);
    classType=array(k,6);

    i=startDate-minn;
    j=endDate-startDate;
    for m=i+1:i+j  %write in trajectory
        traj(pixelX+1,pixelY+1,m)=classType;
    end
end

for i=1:pixelXmax+1
    for j=1:pixelYmax+1
    currentTraj=traj(i,j,:);  %go through all trajectories
    reTraj=reshape(currentTraj,1,vector_len);   %reshape trajectory from len*1 into 1*len
    fprintf(fid,'%d ',i,j);
    fprintf(fid,'%d ',reTraj);
    fprintf(fid,'\n ');
    end
end

fclose(fid);
    
    
    
    