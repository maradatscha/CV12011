% HARRIS - Compute the Harris interest points of a grayscale image
% 
% Usage:   [mask, harris] = harris(img, sigma, fsize, th)
%
% Argument:
%   img    - 2D grayscale image
%   sigma  - kernel width of the Gaussian smoother
%   fsize  - filter size
%   th     - threshold for Harris function values
%
% Returns:
%   mask   - 2D mask with "1" denoting the interest points
%   harris - Harris function values at all pixels
%
% Author: Qi Gao <qi.gao@gris.tu-darmstadt.de>
% Department of Computer Science, TU Darmstadt
% June 2011

function [mask, harris] = harris(img, sigma, fsize, th)

  Gau_filter    = fspecial('gaussian', fsize, sigma);
  Gau_filter_st = fspecial('gaussian', fsize, 1.6*sigma);
  deriv_filter  = [-.5 0 .5];
  
  img_s = imfilter(img, Gau_filter,'replicate');
  dx = imfilter(img_s, deriv_filter, 'replicate');
  dy = imfilter(img_s, deriv_filter','replicate');
  
  dxdx = imfilter(dx.^2,  Gau_filter_st,'replicate');
  dxdy = imfilter(dx.*dy, Gau_filter_st,'replicate');
  dydy = imfilter(dy.^2,  Gau_filter_st,'replicate');
  
  lprod = dxdx.*dydy - dxdy.^2;
  lsum = dxdx + dydy;
  harris = sigma^4 * lprod - 0.06 * sigma^4 * lsum.^2;
  
  % non-maximum suppression
  blocks = im2col(harris, [3,3]);
  idx = zeros(size(img));

  idx(2:end-1, 2:end-1) = reshape((blocks(5,:)==max(blocks)), size(img)-2);

  mask = (harris .* idx) > th;
end