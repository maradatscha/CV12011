function R = rotmatrix( x, y, z )

x = deg2rad(x);
y = deg2rad(y);
z = deg2rad(z);

sx = sin(x); cx = cos(x); 
sy = sin(y); cy = cos(y); 
sz = sin(z); cz = cos(z); 

rz = [  cz,  -sz,  0; ... 
       sz,  cz,  0; ... 
         0,   0,  1]; 
ry = [  cy,  0,  sy; ... 
         0,  1,  0; ... 
       -sy,  0,  cy]; 
rx = [  1,   0,   0; ... 
        0,   cx, -sx;... 
        0,  sx, cx]; 
    
R = eye(4,4);
R(1:3,1:3) = rx*ry*rz;  


end

