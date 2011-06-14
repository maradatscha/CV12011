function ha = harris(c, s, a)

    s2 = s*s;
    ha = zeros(size(c,1), size(c,2));

    for x =1:size(c,1)
        for y =1:size(c,2)
            t = reshape(c(x,y,:,:), [2 2]);
            ha(x,y) = det(s2.*t)-a*trace(t)^2;
        end
    end
    
end