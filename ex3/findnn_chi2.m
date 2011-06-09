function [m i] = findnn_chi2(D1, s1,  D2, s2)

    assert(size(D1,2)==size(s1,2));
    assert(size(D2,2)==size(s2,2));

    m = inf.*ones(size(D1,2), 1);
    i = zeros(size(D1,2), 1);
    m2 = inf.*ones(size(D1,2), 1);
    i2 = zeros(size(D1,2), 1);
    
    for d1=1:size(D1,2)
        for d2=1:size(D2,2)
            if(s1(d1) == s2(d2))
              d = sum( (D1(d1)-D2(d2)).^2 ./ (D1(d1)+D2(2)) ) / 2.0;
                if (d < m(d1) && d < m2(d2))
                    if (i2(d2) > 0)
                        i(i2(d2)) = 0;
                    end
                    if (i(d1) > 0)
                        i2(i(d1)) = 0;
                    end
                    
                    m(d1) = d;
                    m2(d2) = d;
                    i(d1) = d2;
                    i2(d2) = d1;
                end
            end
        end
    end

end