clear all;
close all;

pt1 = [
    45   210
   253   211
   154   188
    27    37
   209   164
    33    77
    93    58
    66    75  
];

pt2 = [
    87   216
   285   216
   188   194
    51    49
   234   171
    56    88
   114    69
    87    86
];

img1 = imread('image1.png');
img2 = imread('image2.png');

imgf = [img1 img2];

% show images and check correspondences
imshow(imgf);
hold on;
dim1 = size(img1,2);
plot(pt1(:,1),pt1(:,2), 'rs');
plot(pt2(:,1)+dim1,pt2(:,2), 'bs');
for i = 1:size(pt1,1)
	plot([pt1(i,1) pt2(i,1)+dim1], [pt1(i,2) pt2(i,2)], 'y-');
end

F = eightpoint(pt1,pt2)

% errors for all 8 points
for i = 1:8
	[pt1(i,:) 1] * F * [pt2(i,:) 1]'
end


% show epipolar lines
%for kk = 1:8
%	el = F*[pt1(kk,:) 1]'
%	x = 1:size(img2,2);
%
%	y = []
%	for i = 1:size(img2,2)
%		y(i) = -el(1)/el(2) * x(i) - el(3)/el(2);
%		x(i) = x(i) + dim1;
%	end
%
%	plot(x,y,'g')
%end

