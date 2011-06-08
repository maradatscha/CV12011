function c = tensor(im, sigma)

    r = 12; 
    sigmah = 1.6*sigma;
  
    h = fspecial('gaussian', [2*r+1 2*r+1], sigma);
    ims = imfilter( im, h);
  
  
  imxDer = 0.5*(ims(1:end-2, 1:end)-ims(3:end, 1:end));
  imxDer = [ zeros(1, size(ims,2)) ;imxDer;zeros(1, size(ims,2))];
  imyDer = 0.5*(ims(1:end, 1:end-2)-ims(1:end, 3:end));
  imyDer = [ zeros(size(ims,1),1) imyDer zeros(size(ims,1),1)];
  
  g = fspecial('gaussian', [2*r+1 2*r+1], sigmah);
  
  c = zeros(size(im,1), size(im,2),2,2);

    for x =r+1:size(im,1)-r-1
        for y =r+1:size(im,2)-r-1
           a = sum(sum(g.*(imxDer(x-r:x+r, y-r:y+r).^2)));
           b = sum(sum(g.*(imxDer(x-r:x+r, y-r:y+r).*imyDer(x-r:x+r, y-r:y+r))));
           d = sum(sum(g.*(imyDer(x-r:x+r, y-r:y+r).^2)));
           c(x,y,1,1) = a;
           c(x,y,1,2) = b;
           c(x,y,2,1) = b;
           c(x,y,2,2) = d;
        end
    end
    
    % take care of borders
    
end