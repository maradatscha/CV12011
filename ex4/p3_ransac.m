clear all;
close all;

img1 = double(imread('image1.png'));
img2 = double(imread('image2.png'));


sigma = 1.4;
fsize = 25;
th = 1500;

[m1 h1] = harris(img1, sigma,fsize,th);

[m2 h2] = harris(img2, sigma,fsize,th );

  px1 = [];
  py1 = [];
  px2 = [];
  py2 = [];

  for y=8:size(m1,1)-8
    for x =8:size(m1,2)-8
    if (m1(y,x) ~= 0)
	    py1 = [py1;y];
	    px1 = [px1;x];
    end
    if (m2(y,x) ~= 0)
  	    py2 = [py2;y];
  	    px2 = [px2;x];
    end
    end
  end
  
  d1 = sift(px1 , py1, sigma, img1);
d2 = sift(px2 , py2, sigma, img2);

pairs = findnn_chi2(d1, d2);

pt1 =     [px1(pairs(:,1)) py1(pairs(:,1))];
pt2 =     [px2(pairs(:,2)) py2(pairs(:,2))];


imgf = [uint8(img1) uint8(img2)];
%imshow(imgf);
%hold on;
%dim1 = size(img1,2);

%plot(pt1(:,1),pt1(:,2), 'rs');
%plot(pt2(:,1)+dim1,pt2(:,2), 'bs');
%for i = 1:10:size(pt1,1)
%	plot([pt1(i,1) pt2(i,1)+dim1], [pt1(i,2) pt2(i,2)], 'y-');
%end


%    pause;

% estimate number of iterations needed for ransac
% 40 per cent outliers, 8 unknowns, look at slide 45 in l9
errA = inf;
IA = zeros(1,8);

for k=1:3000
    I =  randsample(size(pt1,1),8);
    F = eightpoint(pt1(I,:),pt2(I,:));

    % errors for all points
        err = 0.0;
        for i = 1:size(pt1,1)
	        err = err + dist(F,[pt1(i,:) 1]',[pt2(i,:) 1]');
            %err = err + abs([pt1(i,:) 1]*F*[pt2(i,:) 1]');
        end
        if(err < errA)
         IA = I;
         errA = err;
         FA = F;
        end
end

FA
errA

% show images and inlier correspondences
imshow(imgf);
hold on;
dim1 = size(img1,2);

ptd1 = pt1(IA,:);
ptd2 = pt2(IA,:);

plot(ptd1(:,1),ptd1(:,2), 'rs');
plot(ptd2(:,1)+dim1,ptd2(:,2), 'bs');
for i = 1:size(ptd1,1)
	plot([ptd1(i,1) ptd2(i,1)+dim1], [ptd1(i,2) ptd2(i,2)], 'y-');
end