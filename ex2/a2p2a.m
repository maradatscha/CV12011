

g = make_gauss_filter([9 9], 1.5);

figure(1);
surf(g);
im = im2double(imread('a2p1.png'));
imf = conv2(im, g);

figure(2);

imshow(imf);