close all;

im = im2double(imread('a2p1.png'));



dr = [-1 0 1];
g = make_gauss_filter([3 1], 0.8);
% combine to create x and y filters
fx = g'*dr
fy = dr'*g


imfx = imfilter(im,fx,'replicate','same');
imfy = imfilter(im,fy,'replicate','same');

figure(1); imshow(imfx);
figure(2); imshow(imfy);
pause;

gradmag = sqrt(imfx.*imfx+imfy.*imfy);

figure(1); imshow(gradmag);

m = max(gradmag(:));

rem = gradmag;
rem(gradmag > 0.15*m) = 0.0;

u = gradmag - rem; % threshold it!

edges = zeros(size(gradmag));
edges(u > 0) = 1;


figure(2); imshow(edges);
pause;

% add edges to final edgemap according to non maximum suppression

final = zeros(size(edges));
for i=3:size(edges,1)-2
    for j=3:size(edges,2)-2
       if (edges(i,j) == 1)
           if (abs(imfx(i,j)) > abs(imfy(i,j)))
            if (imfx(i,j) < 0 && gradmag(i,j)> gradmag(i,j-1) && gradmag(i,j) > gradmag(i,j-2) )
                final(i,j) = 1;
            elseif (imfx(i,j) > 0 && gradmag(i,j)> gradmag(i,j+1) && gradmag(i,j) > gradmag(i,j+2) )
                final(i,j) = 1; 
            end
           else
            if (imfy(i,j) < 0 && gradmag(i,j)> gradmag(i-1,j) && gradmag(i,j) > gradmag(i-2,j) )
                final(i,j) = 1;
            elseif (imfy(i,j) > 0 && gradmag(i,j)> gradmag(i+1,j) && gradmag(i,j) > gradmag(i+2,j) )
                final(i,j) = 1; 
            end
            
           end
       end
    end
end

% our threshold was found by trial and error
% it shows the important image edges, while removing most of the noise
% background edges

figure(3); imshow(final);
