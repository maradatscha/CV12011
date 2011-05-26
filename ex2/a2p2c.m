
G1A = im2double(imread('a2p2a.png'));
G1B = im2double(imread('a2p2b.png'));
G1C = im2double(imread('a2p2m.png'));

G1A = G1A(1:end-1, 1:end-1); % take care of uneven image
G1B = G1B(1:end-1, 1:end-1); % take care of uneven image
G1C = G1C(1:end-1, 1:end-1); % take care of uneven image

size(G1A)
size(G1B)
size(G1C)

g = make_gauss_filter([5 5], 1.0);

% create laplacian pyramid

G2A = downsample2(imfilter(G1A,g, 0 ,'same'));
G3A = downsample2(imfilter(G2A,g, 0 ,'same'));
G4A = downsample2(imfilter(G3A,g, 0 ,'same'));
G5A = downsample2(imfilter(G4A,g, 0 ,'same'));
G6A = downsample2(imfilter(G5A,g, 0 ,'same'));

L6A = G6A;
L5A = G5A-upsample2(G6A);
L4A = G4A-upsample2(G5A);
L3A = G3A-upsample2(G4A);
L2A = G2A-upsample2(G3A);
L1A = G1A-upsample2(G2A);

G2B = downsample2(imfilter(G1B,g, 0 ,'same'));
G3B = downsample2(imfilter(G2B,g, 0 ,'same'));
G4B = downsample2(imfilter(G3B,g, 0 ,'same'));
G5B = downsample2(imfilter(G4B,g, 0 ,'same'));
G6B = downsample2(imfilter(G5B,g, 0 ,'same'));

L6B = G6B;
L5B = G5B-upsample2(G6B);
L4B = G4B-upsample2(G5B);
L3B = G3B-upsample2(G4B);
L2B = G2B-upsample2(G3B);
L1B = G1B-upsample2(G2B);

G2C = downsample2(imfilter(G1C,g, 0 ,'same'));
G3C = downsample2(imfilter(G2C,g, 0 ,'same'));
G4C = downsample2(imfilter(G3C,g, 0 ,'same'));
G5C = downsample2(imfilter(G4C,g, 0 ,'same'));
G6C = downsample2(imfilter(G5C,g, 0 ,'same'));

L6 = L6B.*G6C + L6A.*(ones(size(G6C))-G6C);
L5 = L5B.*G5C + L5A.*(ones(size(G5C))-G5C);
L4 = L4B.*G4C + L4A.*(ones(size(G4C))-G4C);
L3 = L3B.*G3C + L3A.*(ones(size(G3C))-G3C);
L2 = L2B.*G2C + L2A.*(ones(size(G2C))-G2C);
L1 = L1B.*G1C + L1A.*(ones(size(G1C))-G1C);



%insert nice display method here



R6 = L6;
R5 = L5+upsample2(R6);
R4 = L4+upsample2(R5);
R3 = L3+upsample2(R4);
R2 = L2+upsample2(R3);
R1 = L1+upsample2(R2);

figure(2);
imshow(R1);
