clear;clc;
traj_matrix=dlmread('/home/fas/seto/xl533/scratch60/grace6/traj_0_medium.txt');
[r,c]=size(traj_matrix);
startDate=traj_matrix(1,1);
endDate=traj_matrix(1,2);
traj_only=traj_matrix(2:r,:);

ifurban=zeros(1,r-1);   %flag matrix to tell if a trajectory contains urban
counturban=0;
for i=1:r-1
    for j=3:c
        if traj_only(i,j)==5
            ifurban(1,i)=1;
            counturban=counturban+1;
            break
        end
    end
end

urbanTraj=nan(r-1,c);   %get a urban only trajectory matrix
for i=1:r-1
    if ifurban(1,i)==1
        urbanTraj(i,:)=traj_only(i,:);
    end
end
urbanTraj(all(arrayfun(@isnan,urbanTraj),2),:) = [];  %delete NaN rows

fid=fopen('/home/fas/seto/xl533/scratch60/grace6/urban_only_traj.txt','w');
fprintf(fid,'%d ',startDate,endDate);
fprintf(fid,'\n ');
for i=1:counturban
    fprintf(fid,'%d ',urbanTraj(i,:)); %pring trajectories with urban changes into txt
    fprintf(fid,'\n ');
end
fclose(fid);
