clear;clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=load('/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbOnlyTraj_WithinShpNoOverlay_breaktime/urbOnlyTraj_WithinShpNoOverlay_breaktime_month_139041.txt');
water=load('/home/fas/seto/bc643/scratch60/grace1/watercourses_txt/139041_watercourses_pixList_NoExtraSpace_sorted.txt');

[rw,cw]=size(water);
[ro,co]=size(out);
out_new=out;

pixelXout_min=min(out(:,1))
pixelXout_max=max(out(:,1))
rw_start=1;
rw_end=1;

for j=1:rw
	if water(j,1)>=pixelXout_min
		rw_start=j;
		break
	end
end	
for j=rw:-1:1
	if water(j,1)<=pixelXout_max
		rw_end=j;
		break
	end
end	

rw_start
rw_end

for i=1:ro
	i
	for j=rw_start:rw_end
		% j
		% water(j,1)<=out(i,1)
		% water(j,2)<=out(i,2)
		% disp('water(j,1)=');
		% water(j,1)
		% disp('water(j,2)=');
		% water(j,2)
		% disp('out(i,1)=');
		% out(i,1)
		% disp('out(i,2)=');
		% out(i,2)
		if water(j,1)<=out(i,1)
			if water(j,2)<=out(i,2)
				if isequal(ismember(water(j,:),out(i,:)),[1 1])
					out(i,:)=0;
					disp('deleted: water(j,1), water(j,2)=');
					water(j,1)
					water(j,2)
					break
				end
			else
				continue
			end
		else
			break
		end
	end
end

out_new=out(any(out,2),:);
[ro_new,co_new]=size(out_new);

fid=fopen('/home/fas/seto/bc643/scratch60/grace1/urbOnlyTraj_WithinShpNoOverlay/urbOnlyTraj_WithinShpNoOverlay_breaktime/urbOnlyTraj_WithinShpNoOverlay_breaktime_month_maskwater_139041.txt','w');
for k=1:ro_new
    fprintf(fid,'%d ',out_new(k,:));  %write out trajectories
    fprintf(fid,'\n ');
end

fclose(fid);
