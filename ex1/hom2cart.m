function m = hom2cart( v )
%HOM2CART Summary of this function goes here
%   Detailed explanation goes here

assert(size(v,1)==3 || size(v,1)==4, 'Please input a n x 3 or n x 4 matrix' );

d = repmat(v(end,:), size(v,1)-1, 1);


m = v(1:end-1,:)./d;

end

