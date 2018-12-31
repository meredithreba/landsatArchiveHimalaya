clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace1/out.txt');
[r,c]=size(array);
pixelXmax=max(array(:,1));
pixelYmax=max(array(:,2));
minn=min(array(:,3));    %date min and max
maxx=max(array(:,4));
vector_len=maxx-minn;
%minn=725741;maxx=736901; vector_len=11160;
cut_start=726467; %1990-01-01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cut_end=736693; %2017-12-31
desired_len=round((cut_end-cut_start)/30.4375);

urban_index=nan(1,2);
for k=1:r                  %go through all items in matrix.txt
    pixelX=array(k,1);
    pixelY=array(k,2);
    startDate=array(k,3);
    endDate=array(k,4);
    whetherBreak=array(k,5);
    classType=array(k,6);
    
    i=startDate-minn;
    j=endDate-startDate;
    if classType==5
        urban_index=[urban_index;pixelX,pixelY]; %select urban only trajectoroes
    end
end
urban_index=unique(urban_index,'rows');
[r_u,c_u]=size(urban_index);
urban_index(r_u,:)=[]; %delete nan rows
fid=fopen('/home/fas/seto/xl533/scratch60/grace1/urban_index_new.txt','w');
for i=1:r_u-1
    fprintf(fid,'%d ',urban_index(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

traj=zeros(r_u,vector_len+2);
traj_month=zeros(r_u-1,desired_len+2);
traj_day=zeros(1,cut_end-cut_start);
fid=fopen('/home/fas/seto/xl533/scratch60/grace1/traj_urban_medium_front_end_month_1990.txt','w');
fprintf(fid,'%d ',minn,maxx);
fprintf(fid,'\n ');

for i=1:r_u-1
    n0=0;                           %update, 2018-12-31
    for k=1:r
        traj(i,1)=urban_index(i,1); %update 2018-12-26
        traj(i,2)=urban_index(i,2); %write in pixelX + pixelY
        if k-n0<6 || n0==0          %update, 2018-12-31, reduced iteration
            if array(k,1)==traj(i,1) && array(k,2)==traj(i,2)
                if n0==0 n0=k; end
                pixelX=array(k,1);
                pixelY=array(k,2);
                startDate=array(k,3);
                endDate=array(k,4);
                whetherBreak=array(k,5);
                classType=array(k,6);
                
                ii=startDate-minn;
                jj=endDate-startDate;
                for m=ii+1:ii+jj  %write in trajectory
                    traj(i,m)=classType;
                end
            end
        end
    end
end

traj(r_u,:)=[]; %delete nan row

for k=1:r_u-1
    breakx11=0;breaky11=0;breakx12=0;breaky12=0;breakx0=0;breakxmax=0;
    for i=3:vector_len+1
        if traj(k,i)==0 && traj(k,i+1)~=0           %find the very first training date, from 0 to 1/2/3/4/5
            breakx0=i;
            break
        end
    end
    if traj(k,3)~=0        %update:12/26/2018
        breakx0=3;
    end
    
    for i=3:vector_len+1
        if traj(k,i)~=0 && traj(k,i+1)==0          %find the very last ending date, from 1/2/3/4/5 to 0
            breakxmax=i;
        end
    end
    
    if traj(k,vector_len+2)~=0   %update:12/26/2018
        breakxmax=vector_len+2;
    end
        
        
    for i=4:breakxmax-1       %this part is to write in data between models' break. e.g:330055->333555
        if traj(k,i)~=0 && traj(k,i+1)==0  %find the date before the change
            breakx11=i;breaky11=traj(k,i);
            for j=i+2:vector_len+1
                if traj(k,j)==0 && traj(k,j+1)~=0
                    breakx12=j+1;breaky12=traj(k,j+1);  %find the startDate of the next model (if break)
                    medium=(breakx11+breakx12)/2;
                    for m=breakx11:round(medium)
                        traj(k,m)=traj(k,breakx11-1);
                    end
                    for m=round(medium):breakx12-1
                        traj(k,m)=traj(k,breakx12);
                    end
                    break
                end
            end
        end
    end
    for m=3:breakx0          %fill the trajectory's beginning with the first 1/2/3/4/5 value
        traj(k,m)=traj(k,breakx0+1);
    end
    for m=breakxmax:vector_len+2     %fill the trajectory's ending with the last 1/2/3/4/5 value
        traj(k,m)=traj(k,breakxmax);
    end
    for m=1:cut_end-cut_start
        traj_day(1,m)=traj(k,m+cut_start-minn);
    end
    for m=1:desired_len
        traj_month(k,m+2)=traj_day(1,round(m*30.4375)-1); %average day: 365.25/12=30.4375
    end
    traj_month(k,1)=traj(k,1); 
    traj_month(k,2)=traj(k,2);
	
    fprintf(fid,'%d ',traj_month(k,:));  %write out trajectories
    fprintf(fid,'\n ');
    display('done1');
end

fclose(fid);
[r_m,c_m]=size(traj_month);
c_m-2
