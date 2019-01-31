clear;clc;
array=load('/home/fas/seto/xl533/scratch60/grace8/out_within.txt');

[r,c]=size(array);

breaktime_urban_from=zeros(5,28*12);
breaktime_urban_to=zeros(5,28*12);
for k=1:r                  %go through all items in matrix.txt
    pixelX=array(k,1);
    pixelY=array(k,2);
    startDate=array(k,3);
    endDate=array(k,4);
    whetherBreak=array(k,5);
    classType=array(k,6);
    
    if whetherBreak~=0 && classType==5      %find the pixels that change from urban
        if endDate>726467 && endDate<736693 
        if array(k+1,6)==1 endDate_month=round((endDate-365.25*1989)*12/365); breaktime_urban_from(1,endDate_month)=breaktime_urban_from(1,endDate_month)+1; end
        if array(k+1,6)==2 endDate_month=round((endDate-365.25*1989)*12/365); breaktime_urban_from(2,endDate_month)=breaktime_urban_from(2,endDate_month)+1; end
        if array(k+1,6)==3 endDate_month=round((endDate-365.25*1989)*12/365); breaktime_urban_from(3,endDate_month)=breaktime_urban_from(3,endDate_month)+1; end
        if array(k+1,6)==4 endDate_month=round((endDate-365.25*1989)*12/365); breaktime_urban_from(4,endDate_month)=breaktime_urban_from(4,endDate_month)+1; end
        if array(k+1,6)==5 endDate_month=round((endDate-365.25*1989)*12/365); breaktime_urban_from(5,endDate_month)=breaktime_urban_from(5,endDate_month)+1; end
        end
    end
    
    
    if k~=1 && classType==5 && pixelX==array(k-1,1) && pixelY==array(k-1,2)  %find the pixels that change into urban
        last_time=array(k-1,4);
        if last_time>726467 && last_time<736693 
            if array(k-1,6)==1 last_time_month=round((last_time-365.25*1989)*12/365); breaktime_urban_to(1,last_time_month)=breaktime_urban_to(1,last_time_month)+1; end
            if array(k-1,6)==2 last_time_month=round((last_time-365.25*1989)*12/365); breaktime_urban_to(2,last_time_month)=breaktime_urban_to(2,last_time_month)+1; end
            if array(k-1,6)==3 last_time_month=round((last_time-365.25*1989)*12/365); breaktime_urban_to(3,last_time_month)=breaktime_urban_to(3,last_time_month)+1; end
            if array(k-1,6)==4 last_time_month=round((last_time-365.25*1989)*12/365); breaktime_urban_to(4,last_time_month)=breaktime_urban_to(4,last_time_month)+1; end
            if array(k-1,6)==5 last_time_month=round((last_time-365.25*1989)*12/365); breaktime_urban_to(5,last_time_month)=breaktime_urban_to(5,last_time_month)+1; end
        end
    end
end

fid=fopen('/home/fas/seto/xl533/scratch60/grace8/FROM_urban_month_140042.txt','w');
fprintf(fid,'\n ');
for i=1:5
   fprintf(fid,'%d ',breaktime_urban_from(i,:));
   fprintf(fid,'\n ');
end
fclose(fid);

fid=fopen('/home/fas/seto/xl533/scratch60/grace8/TO_urban_month_140042.txt','w');
fprintf(fid,'\n ');
for i=1:5
   fprintf(fid,'%d ',breaktime_urban_to(i,:));
   fprintf(fid,'\n ');
end
fclose(fid);


