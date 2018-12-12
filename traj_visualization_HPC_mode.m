clear;clc;
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace6/urban_only_traj.txt');   %read in trajectory data, with NaN
kmodes_1=dlmread('/home/fas/seto/xl533/scratch60/grace6/kmodes.txt'); %read in kmodes output
kmeans_dir=kmodes_1';
[r,c]=size(traj_matrix); 
[r_k,c_k]=size(kmeans_dir);
startDate=traj_matrix(1,1);
endDate=traj_matrix(1,2);
traj_only=traj_matrix(2:r,:);

flag=zeros(1,10);   
traj10_mode=zeros(10,c-2);   


for k=1:10
    A=nan(1,c-2);
    for i=2:r
        if kmeans_dir(1,i-1)==k
            A=[A;traj_matrix(i,3:c)];
            count=i;
        end
    end
    traj10_mode(k,:)=mode(A);
end

for i=1:10
    for j=1:c-2
        if traj10_mode(i,j)==0
            traj10_mode(i,j)=NaN;
        end
    end
end

fid=fopen('/home/fas/seto/xl533/scratch60/grace6/traj10_mode.txt','w');   %write 10 trajectories into txt
fprintf(fid,'%d ',startDate,endDate);
fprintf(fid,'\n ');
for i=1:10
    fprintf(fid,'%d ',traj10_mode(i,:));
    fprintf(fid,'\n ');
end
fclose(fid);

[n,y]=hist(kmeans_dir); 
y=1:1:10;
bar(y,n);           %plot a histogram
text(y-0.3,n+11,num2str(n'));
saveas(gcf,'/home/fas/seto/xl533/scratch60/grace6/histogram.png');
hold off;

flag=zeros(1,10);
kmeans_dir=[1,2,3,4,5,6,7,8,9,10];
traj=dlmread('/home/fas/seto/xl533/scratch60/grace6/traj10_mode.txt');
[r,c]=size(traj);
[b,sort_index]=sort(n);  %get the frequence of each cluster
for i=1:10
mycolor(i,:)=[0 0.4 0.4]+0.06*[0 1 1]*i;
end %the darker the color, the higher the frequence

startDate=traj(1,1);
endDate=traj(1,2);
traj_1=nan(10,2018);

for i=1:10
    null_m=nan(1,startDate);
    matrix=[null_m traj(i+1,:)];
        for j=1:2018
        traj_1(i,j)=matrix(1,j*365);  %convert day 1-11160 into year 1-2018
        end
end

for i=1:10
    for j=1:2018
        if isnan(traj_1(i,j))==0
        if traj_1(i,j)~=round(traj_1(i,j))  %convert not round numbers into round numbers
            traj_1(i,j)=traj_1(i,j+1);
        end
        end
    end
end

for i=1:10
    if mod(i,2)==0   %avoid overlay on y axis
        plot(traj_1(i,:)+0.02*i,'color',mycolor(11-sort_index(1,i),:),'LineWidth',1.5);
        hold on;
    else
        plot(traj_1(i,:)-0.02*i,'color',mycolor(11-sort_index(1,i),:),'LineWidth',1.5);
        hold on;
    end
end
set(gca, 'YTickLabel', {' ','Barren','Cropland','Vegetation','Water','Urban'});
axis([1987,2018,0,6]);
saveas(gcf,'/home/fas/seto/xl533/scratch60/grace6/graph1206.png');
hold off;




