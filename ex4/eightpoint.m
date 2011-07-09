function F = eightpoint(pt1, pt2)

assert(size(pt1,1) == 8 );
assert(size(pt1,2) == 2 );

assert(size(pt2,1) == 8 );
assert(size(pt2,2) == 2 );


% compute normalization matrices
norms = sqrt(sum(abs(pt1).^2,2));
s = 0.5 * max(norms);
t = mean(pt1);

T1 = [ 1/s  0  -t(1)/s ;
        0  1/s -t(2)/s ;
	    0   0      1   ];

norms = sqrt(sum(abs(pt2).^2,2));
s = 0.5 * max(norms);
t = mean(pt2);

T2 = [ 1/s  0  -t(1)/s ;
        0  1/s -t(2)/s ;
	    0   0      1   ];

ut1 = T1 * [pt1 ones(size(pt1,1),1)]';
ut2 = T2 * [pt2 ones(size(pt2,1),1)]';

% build equation system 
A = zeros(8,9);
for i = 1:8
	A(i,1) = ut1(1,i)*ut2(1,i);
	A(i,2) = ut1(2,i)*ut2(1,i);
	A(i,3) =          ut2(1,i);
	A(i,4) = ut1(1,i)*ut2(2,i);
	A(i,5) = ut1(2,i)*ut2(2,i);
	A(i,6) =          ut2(2,i);
	A(i,7) = ut1(1,i);
	A(i,8) = ut1(2,i);
	A(i,9) = 1;
end

% solve for F~
[U S V] = svd(A,0);
Ft = [ V(1,9) V(2,9) V(3,9) ;
	   V(4,9) V(5,9) V(6,9) ;
	   V(7,9) V(8,9) V(9,9) ];

% enforce rank 2 for F_
[U S V] = svd(Ft,0);
S(3,3) = 0;
Fb = U*S*V';

% transform F
F = T2' * Fb * T1;
