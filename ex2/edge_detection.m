IR = imread('a1p4.png');
IG = rgb2gray(IR);
I1 = im2double(IG);

% compute gaussian pyramid

g = make_gauss_filter([3 3], 0.8);

I2 = downsample2(imfilter(I1,g, 0 ,'same'));
I3 = downsample2(imfilter(I2,g, 0 ,'same'));
I4 = downsample2(imfilter(I3,g, 0 ,'same'));
I5 = downsample2(imfilter(I4,g, 0 ,'same'));
I6 = downsample2(imfilter(I5,g, 0 ,'same'));

dr = [-1 0 1];
g = make_gauss_filter([3 1], 0.8);
% combine to x and y
fx = g'*dr;
fy = dr'*g;

I1fx = imfilter(I1,fx,'replicate','same');
I1fy = imfilter(I1,fy,'replicate','same');
I1Grad = sqrt(I1fx .* I1fx + I1fy.*I1fy);

I2fx = imfilter(I2,fx,'replicate','same');
I2fy = imfilter(I2,fy,'replicate','same');
I2Grad = sqrt(I2fx .* I2fx + I2fy.*I2fy);

I3fx = imfilter(I3,fx,'replicate','same');
I3fy = imfilter(I3,fy,'replicate','same');
I3Grad = sqrt(I3fx .* I3fx + I3fy.*I3fy);

I4fx = imfilter(I4,fx,'replicate','same');
I4fy = imfilter(I4,fy,'replicate','same');
I4Grad = sqrt(I4fx .* I4fx + I4fy.*I4fy);

I5fx = imfilter(I5,fx,'replicate','same');
I5fy = imfilter(I5,fy,'replicate','same');
I5Grad = sqrt(I5fx .* I5fx + I5fy.*I5fy);

I6fx = imfilter(I6,fx,'replicate','same');
I6fy = imfilter(I6,fy,'replicate','same');
I6Grad = sqrt(I6fx .* I6fx + I6fy.*I6fy);


% threshold edges, I do not want the edges 

I1B = im2bw(I1Grad, 0.3 );
I2B = im2bw(I2Grad, 0.25 );
I3B = im2bw(I3Grad, 0.1 );
I4B = im2bw(I4Grad, 0.1 );
I5B = im2bw(I5Grad, 0.3 );
I6B = im2bw(I6Grad, 0.4 );

% apply weights to enhance edges
w = zeros(6,1);
w(1) = 0.6;
w(2) = 0.8;
w(3) = 1;
w(4) = 0.4;
w(5) = 0.2;
w(6) = 0.1;

disp('trying to detect most edges from the zebras and no edges from anywhere else ');



U6W = upsample2(I6B*w(6));
U5W = upsample2(U6W+I5B*w(5));
U4W = upsample2(U5W+I4B*w(4));
U3W = upsample2(U4W+I3B*w(3));
U2W = upsample2(U3W+I2B*w(2));
U1W = U2W+I1B*w(1);


UN = U1W/sum(w);

% threshold final edge image
imshow(im2bw(UN, 0.5 ));


pause

