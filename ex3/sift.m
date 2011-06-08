function d = sift(pt, s, im)

    s_uniq = unique(s);
    s_uniq = sort(s_uniq);
    P = [];
    
    
    r = 12; 
    
    for si = 1:size(s_uniq,1)
        h = fspecial('gaussian', [2*r+1 2*r+1], s_uniq(si));
        P(si).im = imfilter( im, h);    
        % compute gradients        
        
    end

        
    
    for p = 1:size(pt,1)
        sc = s(p)
        ptc = pt(p)
        i = find((s_uniq=sc),1)
        % compute histogram
    end

end