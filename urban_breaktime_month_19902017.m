clear;clc;

array=load('/home/fas/seto/xl533/scratch60/grace6/out_HPC.txt');
%array=load('F:\Semester1\Himalaya\CCDC\Codes\matrix_mine\out01.txt');
[r,c]=size(array);
pixelXmax=max(array(:,1));
pixelYmax=max(array(:,2));
minn=min(array(:,3));    %date min and max
maxx=max(array(:,4));
cut_start=726467; %1990-01-01
cut_end=736693; %2017-12-31
desired_len=round((cut_end-cut_start)/30.436875);
fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj_urban_breaktime_month_19902017.txt','w');

urban_index=nan(1,2);
for k=1:r                  %go through all items in matrix.txt
    pixelX=array(k,1);
    pixelY=array(k,2);
    startDate=array(k,3);
    endDate=array(k,4);
    whetherBreak=array(k,5);
    classType=array(k,6);
    
    if classType==5
        urban_index=[urban_index;pixelX,pixelY]; %select urban only trajectoroes
    end
end
urban_index=unique(urban_index,'rows');
[r_u,c_u]=size(urban_index);
urban_index(r_u,:)=[]; %delete nan rows

array=[array;zeros(6,6)];
%traj=zeros(r_u,vector_len+2);
traj_day=zeros(1,cut_end-cut_start+2);
traj_month=zeros(r_u-1,desired_len+2);


for i=1:r_u-1
    n0=0; startYet=0;
    for k=1:r
        traj_day(i,1)=urban_index(i,1);
        traj_day(i,2)=urban_index(i,2); %write in pixelX + pixelY
        
        if k-n0<6 || n0==0             %reduce the time of loop
            if array(k,1)==traj_day(i,1) && array(k,2)==traj_day(i,2)
                if n0==0 n0=k; end
                pixelX=array(k,1);
                pixelY=array(k,2);
                startDate=array(k,3);
                endDate=array(k,4);
                whetherBreak=array(k,5);
                classType=array(k,6);
                
                if whetherBreak>0 && startYet==0                    %fill in: from start to breaktime
                    for j=3:whetherBreak-cut_start+2
                        traj_day(i,j)=classType;
                    end
                    startYet=whetherBreak;
                end
                
                if whetherBreak>0 &&startYet>0                      %fill in: from last breaktime to this breaktime
                    for j=startYet-cut_start+2:whetherBreak-cut_start+2
                        traj_day(i,j)=classType;
                    end
                    startYet=whetherBreak;
                end
                
                if whetherBreak==0 &&startYet>0                     %fill in: from breaktime to the end
                    for j=startYet-cut_start+2:cut_end-cut_start+2
                        traj_day(i,j)=classType;
                    end
                end
                
                if whetherBreak==0 &&startYet==0                    %fill in: from the start to the end (no break at all)
                    for j=3:cut_end-cut_start+2
                        traj_day(i,j)=classType;
                    end
                end
                
            end
        else break
        end
    end
end

for k=1:r_u-1
    traj_month(k,1)=traj_day(k,1)+1;
    traj_month(k,2)=traj_day(k,2)+1;
    for m=3:338
        traj_month(k,m)=traj_day(k,ceil((m-2)*30.436875));  %convert day-level into month-level
    end

    fprintf(fid,'%d ',traj_month(k,:));  %write out trajectories
    fprintf(fid,'\n ');
end

for k=1:r_u-1
    index=0;
    for m=3:338
        if traj_month(k,m)==0 
            index=m; 
            for j=index:338
                traj_month(k,j)=traj_month(k,index-1);  %fix the issue of trajs end in 0 (model ends earlier than 2017-12-31)
            end
        end
    end
end

fclose(fid);
 
