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


%D = diag(S);

%Lambda = D.*D/num_files;


% project (image-mean image) onto 20 eigenvectors
%     y = XM(:,pics(i))'*U(:,1:6);
%     projim6 = U(:,1:6)*y';
%     
%     yall = XM(:,pics(i))'*U(:,1:end);
%
%    % log likelihood for real image
%     d = sum((yall.*yall)./Lambda(1:end)');
%     loglikelihood1 = d;
%    
%     yall = projim6'*U(:,1:end);
%     % log likelihood for projected image
%     d = sum((yall.*yall)./Lambda(1:end)');
%     
%     loglikelihood2 = d;
%
%     name1 = sprintf('loglikelihood is %f', loglikelihood1);
%
%     subplot(3,2,(i-1)*2+1);
%     % display image
%     imagesc(reshape(X(:,pics(i)), 72,88)); colormap gray; axis off;
%     title(name1);
%
%
%     name2 = sprintf('loglikelihood is %f', loglikelihood2);
%
%
%     % display image projected onto 6 eigenvektors
%     subplot(3,2,(i-1)*2+2);
%
%     imagesc(reshape(projim6+imageMean, 72,88)); colormap gray; axis off;
%     title(name2);
% end
%pause;
%
% for i=1:3
%     y = randn(1,6);
%     projim = U(:,1:6)*y';
%     % display image projected onto 6 eigenvektors
%     subplot(1,3,i);
%     imagesc(reshape(projim+imageMean, 72,88)); colormap gray; axis off;
% end
% 
% % These random mouths look a lot like mouths because we add the mean mouth
% % to them. If we didn't do it they would not look like mouths at all.
