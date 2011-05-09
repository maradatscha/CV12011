clear all;

load('bayerdata.mat');

bay = double(zeros(size(bayerimg,1),size(bayerimg,2),3 ));

bay(1:2:end, 1:2:end,2) = bayerimg(1:2:end,1:2:end);
bay(2:2:end, 2:2:end,2) = bayerimg(2:2:end,2:2:end);

bay(1:2:end, 2:2:end,1) = bayerimg(1:2:end,2:2:end);
bay(2:2:end, 1:2:end,3) = bayerimg(2:2:end,1:2:end);

rgb = bay;

image(bay/255.0);
figure;

h1 = [0.25, 0, 0.25; 
      0, 0, 0; 
      0.25, 0, 0.25];
h2 = [0, 0.25, 0; 
    0.25, 0, 0.25; 
    0, 0.25, 0];

r =  imfilter(rgb(:,:,1), h1);
rgb(:,:,1) = rgb(:,:,1)+r;

r =  imfilter(rgb(:,:,1), h2);
rgb(:,:,1) = rgb(:,:,1)+r;


b =  imfilter(rgb(:,:,3), h1);
rgb(:,:,3) = rgb(:,:,3)+b;
b =  imfilter(rgb(:,:,3), h2);
rgb(:,:,3) = rgb(:,:,3)+b;

g =  imfilter(rgb(:,:,2), h2);

rgb(:,:,2) = rgb(:,:,2)+g;

image(rgb/255.0);



