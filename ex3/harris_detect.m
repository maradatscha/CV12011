function [PT S] = harris_detect(im, si, st, nd, t)

P = [];

for d=st-1:nd

    s = si^d
    a = 0.06;

    c = tensor(im, s);
    ha = harris(c, s, a);

    
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

    haf = ha;
    haf(i>1) = 0;
    haf(haf<1500) = 0;


    ind = [1:(size(haf,1)*size(haf,2))]'.*(haf(:)>0);
    b = (ind > 0);
    index = ind(b);

    P(d+1).ha = haf;
    [i,j] = ind2sub(size(haf), index);
    P(d+1).i = [i j];
   
    h = fspecial('gaussian', [25 25], s);
    l = fspecial('laplacian');
    img = imfilter(im,h);
    
    P(d+1).l = s.*s.*abs(imfilter(img, l));
end

PT = [];
S = [];

for d=st+1:nd
    i = P(d).i;
    c = P(d).l;
    n = P(d+1).l;
    p = P(d-1).l;
    [m, j] = max([ c(:) n(:) p(:)]  , [], 2);
    
        
    s = 1.4^(d-1)
    
    for p=1:size(i,1)
        sub = sub2ind(size(im), i(p,1),i(p,2));
        if (j(sub) == 1)
            PT = [PT; i(p,:)];
            S = [S s];
        else if(t)
            PT = [PT; i(p,:)];
            S = [S s];
        end
        
    end

end

end










