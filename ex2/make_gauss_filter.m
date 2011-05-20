function g = make_gauss_filter(sz, sigma)

d = (sz-1)./2.0;

% create samples
x = linspace(-d(1),d(1),sz(1));
y = linspace(-d(2),d(2),sz(2));

% sample gaussian
x = gaussmf(x, [sigma 0]);
y = gaussmf(y, [sigma 0]);

g = y'*x; % create matrix
g = g./sum(sum(g)); % devide by sum to normalize

end




