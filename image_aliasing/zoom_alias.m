% simple example to show image aliasing due to zooming


im = imread('parrots.jpg');


zoom = 4

% get image dimensions and compute centre and window to zoom;
[n m o] = size(im)

% image centre
nmid = n/2;
mmid= m/2;

xoff = n/(zoom*2);
yoff = m/(zoom*2);

% cut portion of image from centre proportional to zoom
newim = im(nmid-xoff:nmid+xoff,mmid-yoff:mmid+yoff,:);


%zoom image use imresize function
newimzoom = imresize(newim,zoom);


% show images

figure(1)
imshow(im);
title('Original Image')

figure(2)
imshow(newim);
title('Original Image Cropped')

figure(3)
imshow(newimzoom);
title('Zoomed Image (Aliasing Artifacts)')