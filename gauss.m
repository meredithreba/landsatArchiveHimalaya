clear;
    img = imread('F:/1st Semester/Himalaya/CCDC/Data/DEM9/dem9.tif');
	w = fspecial('gaussian',[3,3],1);
	%replicate:ͼ���Сͨ����ֵ��߽��ֵ����չ
	%symmetric ͼ���Сͨ��������ı߽���о���ӳ����չ
	I11 = imfilter(img,w,'replicate');
	figure(1);
	imshow(img);title('orginial');
	figure(2);
	imshow(I11);title('filtered');
    imwrite(I11,'F:/1st Semester/Himalaya/CCDC/Data/DEM9/dem9_guass.tif')
