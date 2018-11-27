clear;clc;
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace6/urban_only_traj.txt');   %read in trajectory data, with NaN
kmeans_dir=dlmread('/home/fas/seto/xl533/scratch60/grace6/kmeans_out.txt');  %read in kmeans outputs, 1*n
[r,c]=size(traj_matrix); 
[r_k,c_k]=size(kmeans_dir);
startDate=traj_matrix(1,1);
endDate=traj_matrix(1,2);
traj_only=traj_matrix(2:r,:);

flag=zeros(1,10);   
traj10=nan(10,c);   %pick only the first trajectory in 10 classes
for i=1:c_k
    if flag(1,kmeans_dir(1,i))==0
        traj10(kmeans_dir(1,i),:)=traj_matrix(i+1,:);
        flag(1,kmeans_dir(1,i))=1;
    end
end

for i=1:10
    for j=1:c
        if traj10(i,j)==0
            traj10(i,j)=NaN;
        end
    end
end

fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj10_1126.txt','w');   %write 10 trajectories into txt
fprintf(fid,'%d ',startDate,endDate);
fprintf(fid,'\n ');
for i=1:10
    fprintf(fid,'%d ',traj10(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);


flag=zeros(1,10);
kmeans_dir=[1,2,3,4,5,6,7,8,9,10];
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace6/traj10_1126.txt');
for i=1:10  
    if flag(1,kmeans_dir(1,i))==0   %if never print before
        currentTraj=traj_matrix(i+1,:);
        currentTraj_3n=currentTraj(1,3:c);
        if mod(i,2)==0   %avoid overlay on y axis
            plot(currentTraj_3n+0.02*i,'Color',[abs(sin(i*10)),abs(sin(i*100)),abs(cos(i*10))],'LineWidth',1.5);   %print basic trajectory with random color, without slope
        else
            plot(currentTraj_3n-0.02*i,'Color',[abs(sin(i*10)),abs(sin(i*100)),abs(cos(i*10))],'LineWidth',1.5);
        end
        flag(1,kmeans_dir(1,i))=1;
        hold on;
        axis([0,11166,0,6]);
    end
    
    breakx11=0;breaky11=0;breakx12=0;breaky12=0;
    for j=3:c-2
        if (isnan(currentTraj_3n(1,j))==1) && (isnan(currentTraj_3n(1,j-1))==0)     %find the first break point
            breakx11=j-1;breaky11=currentTraj_3n(1,j-1);
            for k=j+1:c-2
                if (isnan(currentTraj_3n(1,k-1))==1) && (isnan(currentTraj_3n(1,k))==0)  %find the second break point
                    breakx12=k;breaky12=currentTraj_3n(1,k);
                    if mod(i,2)==0     %avoid overlay on y axis
                        plot([breakx11,breakx12],[breaky11+0.02*i,breaky12+0.02*i],'Color',[abs(sin(i*10)),abs(sin(i*100)),abs(cos(i*10))],'LineWidth',1.5);   %print slopes, with same color
                    else
                        plot([breakx11,breakx12],[breaky11-0.02*i,breaky12-0.02*i],'Color',[abs(sin(i*10)),abs(sin(i*100)),abs(cos(i*10))],'LineWidth',1.5);
                    end
                    break
                end
            end
        end
    end
end


saveas(gcf,'/home/fas/seto/xl533/scratch60/grace6/graph1126.png')