clear all;
I1 = im2double(imread('a2p1.png'));
g = make_gauss_filter([5 5], 1.0);

% create gaussian pyramid

I2 = downsample2(imfilter(I1,g, 0 ,'same'));
U1 = upsample2(I2);
I3 = downsample2(imfilter(I2,g, 0 ,'same'));
U2 = upsample2(I3);
I4 = downsample2(imfilter(I3,g, 0 ,'same'));
U3 = upsample2(I4);
I5 = downsample2(imfilter(I4,g, 0 ,'same'));
U4 = upsample2(I5);
I6 = downsample2(imfilter(I5,g, 0 ,'same'));
U5 = upsample2(I6);

s1 = size(I1);
s2 = size(I2);
s3 = size(I3);
s4 = size(I4);
s5 = size(I5);
s6 = size(I6);

sout = size(I1);
sout(2)= s1(2) + s2(2);


Iout = ones(sout);

Iout(1:s1(1), 1:s1(2)) = 0.5+(I1-U1)./2;
Iout(1:s2(1), (s1(2)+1):(s1(2)+s2(2))) = 0.5+(I2-U2)./2;
Iout(s2(1)+1:s2(1)+s3(1), (s1(2)+1):(s1(2)+s3(2))) = 0.5+(I3-U3)./2;
Iout(s2(1)+1:s2(1)+s4(1), (s1(2)+s3(2)+1):(s1(2)+s3(2)+s4(2))) = 0.5+(I4-U4)./2;
Iout(s2(1)+s4(1)+1:s2(1)+s4(1)+s5(1), (s1(2)+s3(2)+1):(s1(2)+s3(2)+s5(2))) = 0.5+(I5-U5)./2;
Iout(s2(1)+s4(1)+1:s2(1)+s4(1)+s6(1), (s1(2)+s3(2)+s5(2)+1):(s1(2)+s3(2)+s5(2)+s6(2))) = I6;

figure(1);
imshow(Iout);


R6 = I6;
R5 = (I5-U5)+upsample2(R6);
R4 = (I4-U4)+upsample2(R5);
R3 = (I3-U3)+upsample2(R4);
R2 = (I2-U2)+upsample2(R3);
R1 = (I1-U1)+upsample2(R2);

figure(2);
imshow(R1);
