function h = comp_hist(xder, yder)

    %directions
    
    B = [0 1; 0.5 0.5; 1 0; 0.5 -0.5; 0 -1; -0.5 -0.5; -1 0; -0.5 0.5 ];
    h = zeros(8,1);

    for i=1:size(xder,1)
        for j =1:size(xder,2)
        g = [xder(i,j) yder(i,j)];
            for c =1:size(h,1)
                b = B(c,:);
                gb = (dot(g,b) / dot(b,b)) * b;
                if(norm(gb) > 0)
                    h(c) = h(c) + norm(gb);
                end
            end
        end
    end
    
	
end