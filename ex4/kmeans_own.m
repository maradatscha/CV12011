function [K mu] = kmeans_own(pts, k)

% create initial cluster centers
mu = zeros(k, size(pts,2));

if(k >= size(pts,1))
  % if we have more clusters than points, use points as cluster centers
  mu = pts(1:min([k size(pts,2)])+1,:);
else
  % else take random points from within the space of the given points
  ma = max(pts,[],1);
  mi = min(pts,[],1);
  ma = repmat(ma, k,1);
  mi = repmat(mi,k,1);  
  mu = rand(size(mu));
  mu = (mu.*(ma-mi))+mi;
  
end

ma = max(pts,[],1);
mi = min(pts,[],1);
  
KO = zeros(size(pts,1),1);
K = -ones(size(pts,1),1);

%while some ids change
it = 0;
while(sum(K ~= KO) > 0)
  it = it +1;
  KO = K;
  % assign points to cluster centers
  for p=1:size(pts,1)
    cu = 0;
    dist = inf;
    for c=1:size(mu,1)
      if(norm(pts(p,:)-mu(c,:)) < dist)
	dist = norm(pts(p,:)-mu(c,:));
	cu = c;
      end
    end
    K(p) = cu;
  end
  
  % compute new cluster centers
  s = zeros(size(mu,1),1);

  mu = zeros(k, size(pts,2));
  for p=1:size(pts,1)
    mu(K(p),:) = mu(K(p),:)+pts(p,:);
    s(K(p))=s(K(p))+1; 
  end
  s = repmat(s, 1, size(pts,2));
  mu = mu ./ s;
  % check for empty clusters
  
  for c = 1:size(mu,1)
    if(s(c) == 0)
      mu(c,:) = pts(randsample(size(pts,1),1), :);
    end
  end

end

%it
% filter out dropped clusters
%in = isnan(mu(:,1));
%mu = mu(~in,:)';
%sk = unique(sort(K));
%for t=1:sum(~in)
%  K(K == sk(t)) = t;
%end
  