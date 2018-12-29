clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace1/out_within.txt');

[r,c]=size(array);

breaktime_urban_from=zeros(5,28); %5 categories, 28 years
breaktime_urban_to=zeros(5,28);
for k=1:r                  %go through all items in out_within.txt
    pixelX=array(k,1);
    pixelY=array(k,2);
    startDate=array(k,3);
    endDate=array(k,4);
    whetherBreak=array(k,5);
    classType=array(k,6);
    
    if whetherBreak~=0 && classType==5      %find the pixels that change from urban
        if endDate>726467 && endDate<736693  %change date should between 1990-01-01 and 2017-12-31
        if array(k+1,6)==1 endDate_year=round(endDate/365); breaktime_urban_from(1,endDate_year-1990)=breaktime_urban_from(1,endDate_year-1990)+1; end
        if array(k+1,6)==2 endDate_year=round(endDate/365); breaktime_urban_from(2,endDate_year-1990)=breaktime_urban_from(2,endDate_year-1990)+1; end
        if array(k+1,6)==3 endDate_year=round(endDate/365); breaktime_urban_from(3,endDate_year-1990)=breaktime_urban_from(3,endDate_year-1990)+1; end
        if array(k+1,6)==4 endDate_year=round(endDate/365); breaktime_urban_from(4,endDate_year-1990)=breaktime_urban_from(4,endDate_year-1990)+1; end
        if array(k+1,6)==5 endDate_year=round(endDate/365); breaktime_urban_from(5,endDate_year-1990)=breaktime_urban_from(5,endDate_year-1990)+1; end
        end
    end
    
    
    if k~=1 && classType==5 && pixelX==array(k-1,1) && pixelY==array(k-1,2)  %find the pixels that change into urban
        last_time=array(k-1,4);
        if last_time>726467 && last_time<736693 
            if array(k-1,6)==1 last_time_year=round(last_time/365); breaktime_urban_to(1,last_time_year-1990)=breaktime_urban_to(1,last_time_year-1990)+1; end %count in
            if array(k-1,6)==2 last_time_year=round(last_time/365); breaktime_urban_to(2,last_time_year-1990)=breaktime_urban_to(2,last_time_year-1990)+1; end
            if array(k-1,6)==3 last_time_year=round(last_time/365); breaktime_urban_to(3,last_time_year-1990)=breaktime_urban_to(3,last_time_year-1990)+1; end
            if array(k-1,6)==4 last_time_year=round(last_time/365); breaktime_urban_to(4,last_time_year-1990)=breaktime_urban_to(4,last_time_year-1990)+1; end
            if array(k-1,6)==5 last_time_year=round(last_time/365); breaktime_urban_to(5,last_time_year-1990)=breaktime_urban_to(5,last_time_year-1990)+1; end
        end
    end
end

fid=fopen('/home/fas/seto/xl533/scratch60/grace1/within_from_to_time_144040.txt','w'); %write outputs
%fid=fopen('F:\Semester1\Himalaya\CCDC\Codes\matrix_mine\old codes\from_to_time_1xx0xx.txt','w');
fprintf(fid,'%s','breaktime_urban_from:');
fprintf(fid,'\n ');
for i=1:5
   fprintf(fid,'%d ',breaktime_urban_from(i,:));
   fprintf(fid,'\n ');
end

fprintf(fid,'\n ');
fprintf(fid,'%s','breaktime_urban_to:');
fprintf(fid,'\n ');
for i=1:5
   fprintf(fid,'%d ',breaktime_urban_to(i,:));
   fprintf(fid,'\n ');
end

fclose(fid);


