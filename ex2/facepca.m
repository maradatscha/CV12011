% Solution for Problem 2 and 3

f = dir('mouths/*.pgm');

close all;
images = [];

for i=1:length(f)
    filename = strcat('mouths/', f(i).name);
    
    tmp = im2double(imread(filename));
    images = [images tmp];
end

X = reshape(images, 72*88, length(f) );

imageMean = mean(X,2);

XM = X - repmat(imageMean, 1, length(f));
 
[U,S,V] = svd(XM, 0);

l = zeros(length(f),1);
l(1)= S(1,1)*S(1,1)/length(f);

for i=2:length(f)
   l(i)= S(i,i)*S(i,i)/length(f);
   l(i)=l(i)+l(i-1);
end

plot([1:length(f)],l);
pause;

l = l./l(length(f));


% number of accumulated value < 0.95
sum(l<0.95)
% number of accumulated value < 0.8
sum(l<0.8)
close all;
% display mean mouth:
 figure ;
 subplot(3,3,2);
 imagesc(reshape(imageMean,72,88)); colormap gray; axis off;

% 
% % prepare for display
 subplot(3,3,4); imagesc(reshape(U(:,1)+0.5, 72,88)); colormap gray; axis off;
 subplot(3,3,5); imagesc(reshape(U(:,2)+0.5, 72,88)); colormap gray; axis off;
 subplot(3,3,6); imagesc(reshape(U(:,3)+0.5, 72,88)); colormap gray; axis off;
 subplot(3,3,7); imagesc(reshape(U(:,4)+0.5, 72,88)); colormap gray; axis off;
 subplot(3,3,8); imagesc(reshape(U(:,5)+0.5, 72,88)); colormap gray; axis off;
 subplot(3,3,9); imagesc(reshape(U(:,6)+0.5, 72,88)); colormap gray; axis off;
 pause;

pics = [98 ,128, 137];
D = diag(S);

Lambda = D.*D/length(f);

N = 72*88;


 for i=1:3
     % project (image-mean image) onto 6 eigenvectors
     y = XM(:,pics(i))'*U(:,1:6);
     projim6 = U(:,1:6)*y';
     
     yall = XM(:,pics(i))'*U(:,1:end);

    % log likelihood for real image
     d = sum((yall.*yall)./Lambda(1:end)');
     loglikelihood1 = d;
    
     yall = projim6'*U(:,1:end);
     % log likelihood for projected image
     d = sum((yall.*yall)./Lambda(1:end)');
     
     loglikelihood2 = d;

     name1 = sprintf('loglikelihood is %f', loglikelihood1);

     subplot(3,2,(i-1)*2+1);
     % display image
     imagesc(reshape(X(:,pics(i)), 72,88)); colormap gray; axis off;
     title(name1);


     name2 = sprintf('loglikelihood is %f', loglikelihood2);


     % display image projected onto 6 eigenvektors
     subplot(3,2,(i-1)*2+2);

     imagesc(reshape(projim6+imageMean, 72,88)); colormap gray; axis off;
     title(name2);
 end
pause;

 for i=1:3
     y = randn(1,6);
     projim = U(:,1:6)*y';
     % display image projected onto 6 eigenvektors
     subplot(1,3,i);
     imagesc(reshape(projim+imageMean, 72,88)); colormap gray; axis off;
 end
 
 % These random mouths look a lot like mouths because we add the mean mouth
 % to them. If we didn't do it they would not look like mouths at all.