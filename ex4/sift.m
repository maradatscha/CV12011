% SIFT - a simple SIFT descriptor for given points in a grayscale image
% 
% Usage:  d = sift(px, py, sig, img)
%
% Argument:
%   px  - 1xN vector of the x coordinates of all points
%   py  - 1xN vector of the y coordinates of all points
%   sig - 1xN vector of the corresponding scales; 
%         or scalar of the only scale that applies to all points
%   img - 2D grayscale image
%
% Returns:
%   d   - 128xN array of SIFT descriptors for all points
%
% Note: the distance of each point to the image boundary can NOT be smaller
% than 8 pixels.
%
% Author: Qi Gao <qi.gao@gris.tu-darmstadt.de>
% Department of Computer Science, TU Darmstadt
% June 2011

function d = sift(px, py, sig, img)
  
  if numel(sig) == 1, sig = sig * ones(size(px)); end
  nump = length(px);
  d = zeros(128, nump);
  
  deriv_filter = [-.5 0 .5];
  
  for i=1:nump
    Gau_filter = fspecial('gaussian', 25, sig(i));
    img_s = imfilter(img, Gau_filter);
    dx = imfilter(img_s, deriv_filter);
    dy = imfilter(img_s, deriv_filter');
    
    dxb = dx(py(i)-7:py(i)+8, px(i)-7:px(i)+8);
    dyb = dy(py(i)-7:py(i)+8, px(i)-7:px(i)+8);
    
    dxb = im2col(dxb, [4 4], 'distinct');
    dyb = im2col(dyb, [4 4], 'distinct');
    
    hist8 = zeros(8, 16);
    % 0
    hist8(1,:) = sum(dxb(dxb>0));
    % 90
    hist8(3,:) = sum(dyb(dyb>0));
    % 180
    hist8(5,:) = sum(-dxb(dxb<0));
    % 270
    hist8(7,:) = sum(-dyb(dyb<0));
    % 45
    idx = dyb > -dxb;
    hist8(2,:) = sum((dyb(idx)+dxb(idx))/sqrt(2));
    % 135
    idx = dyb > dxb;
    hist8(4,:) = sum((dyb(idx)-dxb(idx))/sqrt(2));
    % 225
    idx = dyb < -dxb;
    hist8(6,:) = sum((-dyb(idx)-dxb(idx))/sqrt(2));
    % 315
    idx = dyb < dxb;
    hist8(8,:) = sum((-dyb(idx)+dxb(idx))/sqrt(2));

    d(:,i) = hist8(:);
      
    % normalize
    d = bsxfun(@rdivide, d, sqrt(sum(d.^2)));
  end
end