clear all;
close all;
imc = imread('a3a.png');
im = double(rgb2gray(imc));

% apply simple harris detector
[PT S] = harris_detect(im, 1.4, 1, 2 , 1);
figure(1);
imagesc(imc);
hold on;
for i=1:size(PT,1)
    pt = PT(i,:);
    s = S(i);
    plot(pt(2),pt(1),'yx');
end
hold off;
pause;

% apply harris - laplace detector
[PT S] = harris_detect(im, 1.4, 1, 6 , 0);

figure(2);
imagesc(imc);
hold on;

for i=1:size(PT,1)
    pt = PT(i,:);
    s = S(i);
    plot(pt(2),pt(1), 'yo', 'markersize', 10*s);
    plot(pt(2),pt(1),'yx');
end











