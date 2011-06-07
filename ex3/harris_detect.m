clear all;
close all;
im = double(rgb2gray(imread('a3a.png')));

%im= imresize(im, 0.25);

s = 1.4
a = 0.06

c = tensor(im, s);

ha = harris(c, s, a);
figure(1);
imagesc(ha);

ha_tl = zeros(size(ha));
ha_tt = zeros(size(ha));
ha_tr = zeros(size(ha));
ha_ll = zeros(size(ha));
ha_rr = zeros(size(ha));
ha_bl = zeros(size(ha));
ha_bt = zeros(size(ha));
ha_br = zeros(size(ha));

ha_tl(2:end,2:end)      = ha(1:end-1, 1:end-1);
ha_tt(2:end,1:end)      = ha(1:end-1, 1:end);
ha_tr(2:end,1:end-1)    = ha(1:end-1, 2:end);
ha_ll(1:end,2:end)      = ha(1:end, 1:end-1);
ha_rr(1:end,1:end-1)    = ha(1:end, 2:end);
ha_bl(1:end-1,2:end)    = ha(2:end, 1:end-1);
ha_bt(1:end-1,1:end)    = ha(2:end, 1:end);
ha_br(1:end-1,1:end-1)  = ha(2:end, 2:end);

[m i] = max([ha(:) ... 
    ha_tl(:)...
    ha_tt(:)...
    ha_tr(:)...
    ha_ll(:)...
    ha_rr(:)...
    ha_bl(:)...
    ha_bt(:)...
    ha_br(:)], [],  2);
    
size(i)    
haf = ha;
haf(i>1) = 0;

haf(haf<1500) = 0;
imagesc(haf);
