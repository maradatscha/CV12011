clear all;
close all;
imc1 = imread('a3a.png');
imc2 = imread('a3b.png');
im1 = double(rgb2gray(imc1));
im2 = double(rgb2gray(imc2));

% detect interest points for both images
[PT1 S1] = harris_detect(im1, 1.4, 1, 8 , 0);
[PT2 S2] = harris_detect(im2, 1.4, 1, 8 , 0);

% compute sift descriptor for both point sets
D1 = sift(PT1, S1', im1);
D2 = sift(PT2, S2', im2);

% compute feature matches
[m i] = findnn_chi2(D1, S1,  D2, S2);

% create output image
imout = [imc1 ; imc2];
imagesc(imout);
hold on;

% mark points and matches
for k = 1:size(PT1,1)
        pt1 = PT1(k,:);
        plot(pt1(2), pt1(1), 'yx');
end
    
for k = 1:size(PT2,1)
    pt2 = PT2(k,:);
    pt2(1) = pt2(1) + size(imc1,1);
    plot(pt2(2), pt2(1), 'rx');
end

for k = 1:size(m,1)
    if (i(k) > 0)
        pt1 = PT1(k,:);
        pt2 = PT2(i(k),:);
        pt2(1) = pt2(1) + size(imc1,1);
        plot([pt1(2) pt2(2)], [pt1(1) pt2(1)], 'b-');
    end
end
