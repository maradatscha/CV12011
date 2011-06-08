function d = sift(pt, s, im)

    s_uniq = unique(s);
    s_uniq = sort(s_uniq);
    P = [];
    
    
    r = 12; 
    
    for si = 1:size(s_uniq,1)
        h = fspecial('gaussian', [2*r+1 2*r+1], s_uniq(si));
        ims = imfilter( im, h);    
        
        imxDer = 0.5*(ims(1:end-2, 1:end)-ims(3:end, 1:end));
        imxDer = [ zeros(1, size(ims,2)) ;imxDer;zeros(1, size(ims,2))];
        imyDer = 0.5*(ims(1:end, 1:end-2)-ims(1:end, 3:end));
        imyDer = [ zeros(size(ims,1),1) imyDer zeros(size(ims,1),1)];
        P(si).imxDer =  imxDer;
        P(si).imyDer =  imyDer;        
    end

        
        d = [];
        
    for p = 1:size(pt,1)
        sc = s(p);
        ptc = pt(p,:);
        i = find((s_uniq==sc),1);
        % compute histograms
        hist = zeros(128,1);
        rxDer = P(i).imxDer(ptc(1)-8:ptc(1)+8,ptc(2)-8:ptc(2)+8);
        ryDer = P(i).imyDer(ptc(1)-8:ptc(1)+8,ptc(2)-8:ptc(2)+8);
        
        for x =1:4
            for y = 1:4
                ind = sub2ind([4 4], x,y)-1;
                px = (x-1)*4+1;
                py = (y-1)*4+1;
                rxDerC = rxDer(px:px+4,py:py+4);
                ryDerC = ryDer(px:px+4,py:py+4);
                hist(ind*8+1:ind*8+8) = comp_hist(rxDerC, ryDerC);
            end
        end
        hist = hist./norm(hist);
        d = [d hist];
        
    end

end