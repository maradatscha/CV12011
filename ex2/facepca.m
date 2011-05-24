close all;
clear all;
images = [];
dirs = dir('yale_faces/yale*');
image_dim = [96 84];
num_files = 0;

% load all face images from all directories
for i=1:length(dirs)
    dirname = strcat('yale_faces/', dirs(i).name);
	
	searchfor = strcat(dirname, '/*.pgm');
	files = dir(searchfor);
	num_files = num_files + length(files);
	for f=1:length(files)
		filename = strcat(dirname,'/', files(f).name);
    	tmp = im2double(imread(filename));
	    images = [images tmp];
	end
end


% reshape matrix to correct dimensions
X = reshape(images, image_dim(1)*image_dim(2), num_files);
size(X)

% substract the mean from the data
X_mean = mean(X,2);
X_0 = X - repmat(X_mean, 1, num_files);
 
% compute SVD 
[U,S,V] = svd(X_0, 0);

% compute cumulative variances
l = zeros(num_files,1);
l(1)= S(1,1)*S(1,1)/num_files;
for i=2:num_files
   l(i)= S(i,i)*S(i,i)/num_files;
   l(i)=l(i)+l(i-1);
end

% normalize cumulative variances
l = l./l(num_files);


% display cumulative variances
plot([1:num_files],l);

% number of accumulated value < 0.95
disp('Number of bases for 95 percent of the variance');
disp(sum(l<=0.95));
% number of accumulated value < 0.8
disp('Number of bases for 80 percent of the variance');
disp(sum(l<=0.8));

pause;
close all;

% display mean face:
figure;
subplot(3,5,3);
imagesc(reshape(X_mean,96,84)); colormap gray; axis off;
pause
 
% display first 10 eigenfaces
for i=1:10
	subplot(3,5,i+5) ;
	imagesc(reshape(U(:,i )+0.5, image_dim(1),image_dim(2)));
	colormap gray; axis off;
end
pause;

close all;

% take first image and project it into the subspace
image = X_0(:,1);
subspace_coefficients = U(:,1:20)' * image

% display image and reconstructed image
figure;
subplot(1,2,1);
imagesc(reshape(X(:,1), image_dim(1), image_dim(2))); colormap gray; axis off;

reconstructed = U(:,1:20) * subspace_coefficients + X_mean;
subplot(1,2,2);
imagesc(reshape(reconstructed, image_dim(1), image_dim(2))); colormap gray; axis off;

pause;
close all;

image_ids = [ 33 66 99 ]
figure;

for i=1:3
	% project image into subspace
	image = X_0(:,image_ids(i));
	subspace_coefficients = U(:,1:20)' * image;
	
	% display image and reconstructed image together with the likelihood
	subplot(3,2,i*2-1);
	imagesc(reshape(X(:,image_ids(i)), image_dim(1), image_dim(2))); colormap gray; 
	xlabel(num2str(approx_image_like(image, U(:,1:20), S(1:20,1:20))));
	
	reconstructed_0 = U(:,1:20) * subspace_coefficients;
	reconstructed = reconstructed_0 + X_mean;
	subplot(3,2,i*2);
	imagesc(reshape(reconstructed, image_dim(1), image_dim(2))); colormap gray; 
	xlabel(num2str(approx_image_like(reconstructed_0, U(:,1:20), S(1:20,1:20))));
end

pause;
close all;
figure

% sample 6 random faces and show them together with their likelihood
for i=1:6
	subplot(3,2,i);
	test = (randn(1,20)*S(1:20,1:20))';
	imagesc(reshape((U(:,1:20)*test+X_mean), image_dim(1), image_dim(2))); colormap gray;
	xlabel(num2str(approx_image_like(U(:,1:20)*test, U(:,1:20), S(1:20,1:20))));
end
