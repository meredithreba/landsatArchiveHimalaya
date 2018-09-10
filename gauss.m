clear;
    img = imread('F:/1st Semester/Himalaya/CCDC/Data/DEM9/dem9.tif');
	w = fspecial('gaussian',[3,3],1);
	%replicate:图像大小通过赋值外边界的值来扩展
	%symmetric 图像大小通过沿自身的边界进行镜像映射扩展
	I11 = imfilter(img,w,'replicate');
	figure(1);
	imshow(img);title('orginial');
	figure(2);
	imshow(I11);title('filtered');
    imwrite(I11,'F:/1st Semester/Himalaya/CCDC/Data/DEM9/dem9_guass.tif')
