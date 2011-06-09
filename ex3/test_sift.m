clear all;
close all;
imc = imread('a3a.png');
im = double(rgb2gray(imc));


pt = [ 50, 45; 52, 45];
s = [ 1.4; 1.4];

d = sift(pt, s, im)

  chi2_dist(d(:,1), d(:,2))
size(d)

