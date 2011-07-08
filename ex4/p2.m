close all;
clear all;


f0 = double(imread('frame07.png'));
f1 = double(imread('frame08.png'));

sigma = 1.4;
fsize = 25;
th = 500;

[m h] = harris(f0, sigma,fsize,th);

%px = [];
%py = [];
%for y=5:size(m,1)-5
%  for x =5:size(m,2)-5
%   if (m(y,x) ~= 0)
%      py = [py;y];
%      px = [px;x];
%    end
%  end
%end


g = fspecial('gaussian', [fsize fsize], sigma);
f0s = imfilter(f0, g);    
f1s = imfilter(f1, g);
 
df = [-.5 0 .5];

% get derivatives 
imxDer = imfilter(f0s, df);
imyDer = imfilter(f0s, df');

imtDer = f1s-f0s;

gw = fspecial('gaussian', [11 11], 1.5);

imxDerSQ = imfilter(imxDer.*imxDer, gw);
imyDerSQ = imfilter(imyDer.*imyDer, gw);

imxyDer = imfilter(imxDer.*imyDer, gw);

imtxDer = imfilter(imtDer.*imxDer, -gw);
imtyDer = imfilter(imtDer.*imyDer, -gw);

fl = [];

% estimate flow for all harris points
for y=1:size(m,1)
  for x=1:size(m,2)
    if (m(y,x))
      a = imxDerSQ(y,x);
      b = imxyDer(y,x);
      c = imyDerSQ(y,x);
      t1 = imtxDer(y,x);
      t2 = imtyDer(y,x);
      
      flow = pinv([ a b; b c]) * [t1 t2]';
      fl = [fl [x ;y ;flow(1) ;flow(2)]];
      
    end
  end
end


quiver(fl(1,:), size(m,1)-fl(2,:), fl(3,:), -fl(4,:));
axis image;