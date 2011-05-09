function m = cart2hom( v )
%CART2HOM Summary of this function goes here
%   Detailed explanation goes here

assert(size(v,1)==2 || size(v,1)==3, 'Please input a n x 2 or n x 3 matrix' );

m = [v ; ones(1,size(v,2))];


end

