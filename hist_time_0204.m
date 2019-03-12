clear;clc;
array_from=dlmread('F:\Semester1\Himalaya\CCDC\Codes\visualization\hist_time\hist_data\FROM0131.txt');
array_to=dlmread('F:\Semester1\Himalaya\CCDC\Codes\visualization\hist_time\hist_data\TO0131.txt');

% null_1989=zeros(5,1989*12);
% array_from=[null_1989, array_from];
% ====================into urban, by year
% array_to=[null_1989, array_to];
% bar([array_to'],'stacked')
% colormap(copper);
% axis([1989*12,2018*12,0,35000]);
% title('Changes into urban areas in months','FontSize',16);
% legend('barren->urban','cropland->urban','vegetation->urban','water->urban','urban->urban');
% hold on;
% ===========================into and from urban, by year
% % array_to=array_to(1:4,:);
% % bar([array_from',array_to'],'stacked');
% % axis([1989*12,2018*12,0,50000]);
% % title('Changes from and to urban areas in months','FontSize',16);
% % legend('urban->barren','urban->cropland','urban->vegetation','urban->water','urban->urban','barren->urban','cropland->urban','vegetation->urban','water->urban');
% 
% legend('Location','northeastoutside'); 
% set(gca,'XTick',1989:2:2018);

%=============12 months, in total==================
% array_total=array_from+array_to;
% array_total(5,:)=array_total(5,:)/2;
% array_total_1=sum(array_total);
% 
% array_jd=zeros(12,1);
% for i=1:336
%     j=mod(i,12);
%     if j>0
%     array_jd(j,1)= array_jd(j,1)+array_total_1(1,i);
%     else array_jd(12,1)= array_jd(12,1)+array_total_1(1,i);
%     end
% end
% 
% plot(array_jd);
% title('Urban land use changes by month','FontSize',16);
%==================aggregated each month==========
% array_to=array_to(1:4,:);
% array_all=[array_from',array_to']; %336*9
% %array_jan_dec=zeros(12,5,9);
% array_jan_dec=zeros(12,9);
% for i=1:336
%     j=mod(i,12);
%     if j>0
%     array_jan_dec(j,:)=array_jan_dec(j,:)+array_all(i,:);
%     else
%     array_jan_dec(12,:)=array_jan_dec(12,:)+array_all(i,:);
%     end
% end
% 
% bar([array_jan_dec],'stacked');
% title('Changes from and to urban areas in months','FontSize',16);
% set(gca,'xtick',1:12,'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
% legend('urban->barren','urban->cropland','urban->vegetation','urban->water','urban->urban','barren->urban','cropland->urban','vegetation->urban','water->urban');

%===========================12*28 months, 9 types
array_total=[array_from;array_to(1:4,:)];
bar([array_total'],'stacked')
legend('urban->barren','urban->cropland','urban->vegetation','urban->water','urban->urban','barren->urban','cropland->urban','vegetation->urban','water->urban');
title('Changes from and to urban areas in months, 1990-2017','FontSize',16);
xlabel('Number of Months since 1990');
ylabel('Number of Pixels');
startDate = datenum('01-01-1990');
endDate = datenum('12-31-2017');
% ------------------need to work on x-axis
% xData = linspace(startDate,endDate,28*12);
% datetick('x','yyyy-mmm','keeplimits');








