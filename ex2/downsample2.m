function Iout = downsample2( I )
%DOWNSAMPLE2 downsample an image by factor 2

Iout = I(1:2:end, 1:2:end)+ ...
       I(2:2:end, 1:2:end)+ ...
       I(1:2:end, 2:2:end)+ ...
       I(2:2:end, 2:2:end);
       
Iout = Iout.*0.25;


end

