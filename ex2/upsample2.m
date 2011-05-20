function Iout = upsample2( I )
%UPSAMPLE2 upsample an image by factor 2

Iout = zeros(size(I).*2);
Iout(1:2:end, 1:2:end) = I;
Iout(1:2:end, 2:2:end) = I;
Iout(2:2:end, 1:2:end) = I;
Iout(2:2:end, 2:2:end) = I;


end

