close all;
clear all;
imagesap = [];
imagesmb = [];
numap = 0;
nummb = 0;
dirap = dir('images/ap');
dirmb = dir('images/mb');

sigma = 1.4;
fsize = 25;
th = 1500;
% load all plane images 
dirname = 'images/ap/';
searchfor = strcat(dirname,'*.jpg');
files = dir(searchfor);
numap = numap + length(files);
for f=1:length(files)
  filename = strcat(dirname,'/', files(f).name);
  tmp = rgb2gray(imread(filename));
  tmp = double(imresize(tmp,[NaN 200], 'bicubic'));
  imagesap(f).im = tmp;
  [m h] = harris(tmp, sigma,fsize,th );

  px = [];
  py = [];
  for y=8:size(m,1)-8
    for x =8:size(m,2)-8
      if (m(y,x) ~= 0)
	py = [py;y];
	px = [px;x];
      end
    end
  end
  imagesap(f).d = sift(px , py, sigma, tmp);

end

% load all motorbike images 
dirname = 'images/mb/';
searchfor = strcat(dirname,'*.jpg');
files = dir(searchfor);
nummb = nummb + length(files);
for f=1:length(files)
  filename = strcat(dirname,'/', files(f).name);
  tmp = rgb2gray(imread(filename));
  tmp = double(imresize(tmp,[NaN 200], 'bicubic'));
  imagesmb(f).im = tmp;
  [m h] = harris(tmp, sigma,fsize,th );

  px = [];
  py = [];
  for y=8:size(m,1)-8
    for x =8:size(m,2)-8
      if (m(y,x) ~= 0)
	py = [py;y];
	px = [px;x];
      end
    end
  end
  imagesmb(f).d = sift(px , py, sigma, tmp);
end

lap = length(imagesap);

randIap = randsample(lap,lap);
trainap = imagesap(randIap(1:uint8(lap/2)));
testap = imagesap(randIap(uint8(lap/2+1):end));

lmb = length(imagesmb);
randImb = randsample(lmb,lmb);
trainmb = imagesmb(randImb(1:uint8(lmb/2+1)));
testmb = imagesmb(randImb(uint8(lmb/2+1):end));


numdmb = size(cat(2, trainmb(:).d)',1);
numdap = size(cat(2, trainap(:).d)',1);

% compute clusters over all training descriptors
[k mu] = kmeans_own([cat(2, trainap(:).d)'; cat(2, trainmb(:).d)'], 50);

% compute class-conditional probabilities for each cluster center
nap = hist(k(1:numdap),50);
nmb = hist(k(numdap+1:end),50);

sap = sum(nap)+50;
smb = sum(nmb)+50;

CCPap = (ones(1,50)+nap)/sap;
CCPmb = (ones(1,50)+nmb)/smb;


% compute class priors

Pap = numdap/(numdmb+numdap);
Pmb = numdmb/(numdmb+numdap);


% compute training error

errmb = 0;
for f=1:size(trainmb,2)
  pts = trainmb(f).d';
  n = zeros(1,50);
  for p=1:size(pts,1)
    cu = 0;
    dist = inf;
    for c=1:size(mu,1)
      if(norm(pts(p,:)-mu(c,:)) < dist)
	dist = norm(pts(p,:)-mu(c,:));
	cu = c;
      end
    end
    n(cu) = n(cu) +1;
  end
  
  if(Pap*prod(CCPap.^n) > Pmb*prod(CCPmb.^n))
    errmb = errmb+1;
  end
end

errmb


errap = 0;
for f=1:size(trainap,2)
  pts = trainap(f).d';
  n = zeros(1,50);
  for p=1:size(pts,1)
    cu = 0;
    dist = inf;
    for c=1:size(mu,1)
      if(norm(pts(p,:)-mu(c,:)) < dist)
	dist = norm(pts(p,:)-mu(c,:));
	cu = c;
      end
    end
    n(cu) = n(cu) +1;
  end
  
  if(Pap*prod(CCPap.^n) <Pmb*prod(CCPmb.^n))
    errap = errap+1;
  end
end

errap



% compute test error

errmb = 0;
for f=1:size(testmb,2)
  pts = testmb(f).d';
  n = zeros(1,50);
  for p=1:size(pts,1)
    cu = 0;
    dist = inf;
    for c=1:size(mu,1)
      if(norm(pts(p,:)-mu(c,:)) < dist)
	dist = norm(pts(p,:)-mu(c,:));
	cu = c;
      end
    end
    n(cu) = n(cu) +1;
  end
  
  if(Pap*prod(CCPap.^n) >Pmb*prod(CCPmb.^n))
    errmb = errmb+1;
  end
end

errmb


errap = 0;
for f=1:size(testap,2)
  pts = testap(f).d';
  n = zeros(1,50);
  for p=1:size(pts,1)
    cu = 0;
    dist = inf;
    for c=1:size(mu,1)
      if(norm(pts(p,:)-mu(c,:)) < dist)
	dist = norm(pts(p,:)-mu(c,:));
	cu = c;
      end
    end
    n(cu) = n(cu) +1;
  end
  
  if(Pap*prod(CCPap.^n) <Pmb*prod(CCPmb.^n))
    errap = errap+1;
  end
end

errap