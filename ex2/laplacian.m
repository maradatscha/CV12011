
IR = imread('a1p5.png');
IG = rgb2gray(IR);
G1 = im2double(IG);

g = make_gauss_filter([3 3], 0.8);


% create laplacian pyramid

G2 = downsample2(imfilter(G1,g, 0 ,'same'));
G3 = downsample2(imfilter(G2,g, 0 ,'same'));
G4 = downsample2(imfilter(G3,g, 0 ,'same'));
G5 = downsample2(imfilter(G4,g, 0 ,'same'));
G6 = downsample2(imfilter(G5,g, 0 ,'same'));

L6 = G6;
L5 = G5-upsample2(G6);
L4 = G4-upsample2(G5);
L3 = G3-upsample2(G4);
L2 = G2-upsample2(G3);
L1 = G1-upsample2(G2);

% amplify high resolution edges
L2 = L2 * 1.5;
L1 = L1 * 2.1;

disp('I enhance the edges of the trees without amplifying noise too much');


R6 = L6;
R5 = L5+upsample2(R6);
R4 = L4+upsample2(R5);
R3 = L3+upsample2(R4);
R2 = L2+upsample2(R3);
R1 = L1+upsample2(R2);
imshow(G1);
pause
imshow(R1);
pause