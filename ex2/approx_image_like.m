function L = approx_image_like( I, U, Sigma)

y = U' * I;

Sigma = diag(Sigma,0);

Sigma = 1./Sigma;

d = (y.^2)' * Sigma;

% log likelihood
L = -d/2;
end
