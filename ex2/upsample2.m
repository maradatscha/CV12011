function Iout = upsample2( I )
%UPSAMPLE2 upsample an image by factor 2

Iout = zeros(size(I).*2);
Iout(1:2:end, 1:2:end) = I;

f = [1 4 6 4 1];
f = f'*f;
f = f./sum(f(:));

Iout = imfilter( Iout, f);

Iout = Iout.*4;

end

