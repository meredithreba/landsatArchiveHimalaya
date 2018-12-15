clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace6/out_HPC.txt');
%array=load('F:\Semester1\Himalaya\CCDC\Codes\matrix_mine\out01.txt');
[r,c]=size(array);
pixelXmax=max(array(:,1));
pixelYmax=max(array(:,2));
minn=min(array(:,3));    %date min and max
maxx=max(array(:,4));
vector_len=maxx-minn;
%minn=725741;maxx=736901; vector_len=11160;
fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj_0_medium.txt','w');
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
        
        reTraj_medium=reTraj;
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
                        medium=(breakx11+breakx12)/2;
                        for k=breakx11:round(medium)
                            reTraj_medium(1,k)=reTraj_medium(1,breakx11-1);
                        end
                        for k=round(medium):breakx12-1
                            reTraj_medium(1,k)=reTraj_medium(1,breakx12);
                        end
                        break
                    end
                end
            end
        end
       
        breakx0=0;
        for m=1:breakxmax
            if reTraj_medium(1,m)==0 && reTraj_medium(1,m+1)~=0   %find the very first breakx11, set the data before first date from 0 to 1/2/3/4/5
                breakx0=m;
                break
            end
        end
        for m=1:breakx0
            reTraj_medium(1,m)=reTraj_medium(1,breakx0+1);
        end
        
        for i=1:vector_len-1
            if reTraj_medium(1,i)~=0 && reTraj_medium(1,i+1)==0
                breakxmax=i;                                      %find the very last breakx12, set the data after last date from 0 to 1/2/3/4/5
                for m=breakxmax+1:vector_len
                    reTraj_medium(1,m)=reTraj_medium(1,breakxmax);
                end
            end
        end
        plot(reTraj_medium)
        
        fprintf(fid,'%d ',ii,jj);
        fprintf(fid,'%d ',reTraj_medium);
        fprintf(fid,'\n ');
    end
end


fclose(fid);
