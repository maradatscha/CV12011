% FINDNN_CHI2 - find the one-to-one matches from two groups of descriptors 
% using the chi^2 distance
% 
% Usage:  pairs = findnn_chi2(d1, d2)
% 
% Argument:
%   d1 - DxN array of N descriptors
%   d2 - DxM array of M descriptors
%
% Returns:
%   pairs - Px2 array of descriptor indices of P matches
%
% Author: Qi Gao <qi.gao@gris.tu-darmstadt.de>
% Department of Computer Science, TU Darmstadt
% June 2011

function pairs = findnn_chi2(d1, d2)
  
  nd1 = size(d1,2); nd2 = size(d2,2);
  mdistance = zeros(nd1, nd2);
  
  for i=1:nd1
    for j=1:nd2
      v1 = d1(:,i); v2 = d2(:,j);
      mdistance(i,j) = sum((v1-v2).^2./(v1+v2));
    end
  end
  [~,I1] = sort(mdistance, 2, 'ascend');
  [~,I2] = sort(mdistance, 1, 'ascend');
  nearest1 = I1(:,1); nearest2 = I2(1,:);
  
  % find the one-to-one matches
  pairs = [];
  for i=1:length(nearest1)
    if i == nearest2(nearest1(i)), pairs = [pairs; i, nearest1(i)]; end
  end
end