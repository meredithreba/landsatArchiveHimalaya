clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace6/out_HPC.txt');
[r,c]=size(array);
pixelXmax=max(array(:,1));
pixelYmax=max(array(:,2));
minn=min(array(:,3));    %date min and max
maxx=max(array(:,4));
vector_len=maxx-minn;
%min=725741,max=736901, len=11160
fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj_0_slice.txt','w');
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

for ii=1:pixelXmax+1
    for jj=1:pixelYmax+1
        currentTraj=traj(ii,jj,:);  %go through all trajectories
        reTraj=reshape(currentTraj,1,vector_len);   %reshape trajectory from len*1 into 1*len
        
        reTraj_slice=reTraj;
        breakx11=0;breaky11=0;breakx12=0;breaky12=0;slice1=0;breakxmax=0;
        for i=1:vector_len-1    %find the last date of 1/2/3/4/5->0
            if reTraj(1,i)~=0 && reTraj(1,i+1)==0
                breakxmax=i;
            end
        end
        
        for i=1:breakxmax-1
            if reTraj(1,i)~=0 && reTraj(1,i+1)==0  %find the date before the change
                breakx11=i;breaky11=reTraj(1,i);
                for j=i+2:vector_len-1
                    if reTraj(1,j)==0 && reTraj(1,j+1)~=0
                        breakx12=j+1;breaky12=reTraj(1,j+1);  %find the startDate of the next model (if break) 
                        for k=breakx11:breakx12-1
                            slice1=(breaky12-breaky11)/(breakx12-breakx11);  %linear interpolation between breaks (3 3 0 0 0 0 4 4->3 3 3.25 3.5 3.75 4 4)
                            reTraj_slice(1,k+1)=slice1*(k-breakx11+1)+breaky11;
                        end
                        break
                    end
                end
            end
        end
        fprintf(fid,'%d ',ii,jj);
        fprintf(fid,'%d ',reTraj_slice);
        fprintf(fid,'\n ');
    end
end


fclose(fid);
