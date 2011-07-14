function d = squared_dist(F, x1, x2)
%
%

el1 = F*x1;
el2 = F'*x2;

d = 1/(el1(1)^2+el1(2)^2) + 1/(el2(1)^2+el2(2)^2);
d = d * (x2'*F*x1)^2;
