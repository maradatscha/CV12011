function d = chi2_dist(d1, d2)
%  [d1 d2]
  d = sum( (d1-d2).^2 ./ (d1+d2) ) / 2.0;
end
