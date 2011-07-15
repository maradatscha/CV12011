clear all;
close all;

% read images
img1 = double(imread('image1.png'));
img2 = double(imread('image2.png'));

imgf = [uint8(img1) uint8(img2)];

sigma = 1.4;
fsize = 25;
th = 1500;

% get harris feature points
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
  
% compute sift descriptors  
d1 = sift(px1 , py1, sigma, img1);
d2 = sift(px2 , py2, sigma, img2);

% find sift matches
pairs = findnn_chi2(d1, d2);

pt1 = [px1(pairs(:,1)) py1(pairs(:,1))];
pt2 = [px2(pairs(:,2)) py2(pairs(:,2))];


% initialize RANSAC
max_inliers = 0;
max_inliers_samples = [];
max_inliers_F = [];

% choose threshold
threshold = 0.3;

% estimate number of iterations needed for ransac
% 40 per cent outliers, 8 unknowns, look at slide 45 in l9

% RANSAC
for k=1:3000
	
	% sample 8 points
    I =  randsample(size(pt1,1),8);
	% compute fundamental matrix
    F = eightpoint(pt1(I,:),pt2(I,:));

	% compute distances for all points
	dists = [];
    for i = 1:size(pt1,1)
		dists(i) = squared_dist(F, [pt1(i,:) 1]' , [pt2(i,:) 1]');
    end
	
	% find and count inliers
	threshed = (dists<threshold);
	num_inliers = sum(threshed);
	
	% save max inliers
	if(num_inliers > max_inliers)
		max_inliers = num_inliers;
		max_inliers_samples = find(threshed);
		max_inliers_F = F;
	end
end

% print fundamental matrix and number of inliers
F
max_inliers

% show images and inlier correspondences
pt1_inliers = pt1(max_inliers_samples, :);
pt2_inliers = pt2(max_inliers_samples, :);

imshow(imgf);
hold on;
dim1 = size(img1,2);

plot(pt1_inliers(:,1),pt1_inliers(:,2), 'rs');
plot(pt2_inliers(:,1)+dim1,pt2_inliers(:,2), 'bs');
for i = 1:size(pt1_inliers,1)
	plot([pt1_inliers(i,1) pt2_inliers(i,1)+dim1], [pt1_inliers(i,2) pt2_inliers(i,2)], 'y-');
end
