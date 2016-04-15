function [u,v] = LucasKanade(It, It1, rect)
% CV Fall 2014 - Provided Code
% Lucas-Kanade algorithm that computes the optimal local motion from fram
% It to It1 that minimizes the pixel squared difference
%
% Oct-22-2011: Wen-Sheng Chu (wschu@cmu.edu)

im1 = double(rgb2gray(It));
im2 = double(rgb2gray(It1));

% init
th     = 10^-5;
change = 1;
u      = 0; 
v      = 0;

% compute gradient for im1
h    = fspecial('sobel');
imx1 = imfilter(im1,h','replicate');
imy1 = imfilter(im1,h ,'replicate');

% compute grid
[oX,oY] = meshgrid(rect(1):rect(3),rect(2):rect(4));
lt      = floor(rect(1:2));  % left-top
rb      = ceil(rect(3:4));   % right-bottom
iX      = lt(1):rb(1);
iY      = lt(2):rb(2);

% get interpolated images
Ix = interp2(iX,iY,imx1(iY,iX),oX,oY);
Iy = interp2(iX,iY,imy1(iY,iX),oX,oY);
I1 = interp2(iX,iY, im1(iY,iX),oX,oY);
A  = [Ix(:), Iy(:)];

% start iteration until the change in (u,v) is below a threshold
while change>th
  % compute grid
  [oX,oY] = meshgrid(rect(1):rect(3),rect(2):rect(4));
  lt      = floor(rect(1:2));  % left-top
  rb      = ceil(rect(3:4));   % right-bottom
  iX      = lt(1):rb(1);
  iY      = lt(2):rb(2);
  
  % get interpolated images
  I2      = imresize(interp2(iX,iY,im2(iY,iX),oX,oY), size(I1));
  Itt     = I2 - I1;
  
  % solve [u,v]
  x = A\Itt(:);
  
  % compute change
  change = norm(abs(x));
  
  % update
  u = u + x(1);
  v = v + x(2);
  rect = rect + [x;x]';
end