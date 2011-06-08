clear all;
close all;
imc = imread('a3a.png');
im = double(rgb2gray(imc));


pt = [ 50, 45; 70, 80];
s = [ 1.4; 1.4^2];

d = sift(pt, s, im)

size(d)

