clear;clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=dlmread('/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbOnlyTraj_WithinShpNoOverlay_breaktime/urbOnlyTraj_WithinShpNoOverlay_breaktime_month_139041.txt');
water=dlmread('/home/fas/seto/bc643/scratch60/grace1/watercourses_txt/139041_watercourses_pixList_NoExtraSpace_sorted.txt');

[ro,co]=size(out);
out_new=out;

for i=1:ro
	i
	index=[out(i,1),out(i,2)];
	if ismember(index,water,'rows')==1
		out(i,:)=0; % mark rows that should be deleted as zeros
		disp('deleted: ');
		index
	end
end

out_new=out(any(out,2),:); % delete rows that are zeros
[ro_new,co_new]=size(out_new);

fid=fopen('/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbOnlyTraj_WithinShpNoOverlay_breaktime/urbOnlyTraj_WithinShpNoOverlay_breaktime_month_maskwater_139041.txt','w');
for k=1:ro_new
    fprintf(fid,'%d ',out_new(k,:));  %write out trajectories
    fprintf(fid,'\n ');
end

fclose(fid);
